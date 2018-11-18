----------------------------------------------------------------------
-- Fichero: MicroMIPS.vhd
-- Descripción: Microprocesador MIPS
-- Fecha última modificación: 2012-01-20

-- Autores: Claudia Cea y Lucía Colmenarejo (Pareja 3)
-- Asignatura: E.C. 1º grado
-- Grupo de Prácticas: 2101
-- Grupo de Teoría: 210
-- Práctica: 5
-- Ejercicio: 3
----------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity MicroMIPS is
    port (
        Clk : in std_logic; -- Reloj
        NRst : in std_logic; -- Reset activo a nivel bajo
        MemProgAddr : out std_logic_vector(31 downto 0); -- Dirección para la memoria de programa
        MemProgData : in std_logic_vector(31 downto 0); -- Código de operación
        MemDataAddr : out std_logic_vector(31 downto 0); -- Dirección para la memoria de datos
        MemDataDataRead : in std_logic_vector(31 downto 0); -- Dato a leer en la memoria de datos
        MemDataDataWrite : out std_logic_vector(31 downto 0); -- Dato a guardar en la memoria de datos
        MemDataWE : out std_logic
    );
end MicroMIPS;

architecture P5e3 OF MicroMIPS is
component RegsMIPS is
    port(
        Clk : in std_logic; -- Reloj
        NRst : in std_logic; -- Reset asíncrono a nivel bajo
        A1 : in std_logic_vector(4 downto 0); -- Dirección para el puerto Rd1
        Rd1 : out std_logic_vector(31 downto 0); -- Dato del puerto Rd1
        A2 : in std_logic_vector(4 downto 0); -- Dirección para el puerto Rd2
        Rd2 : out std_logic_vector(31 downto 0); -- Dato del puerto Rd2
        A3 : in std_logic_vector(4 downto 0); -- Dirección para el puerto Wd3
        Wd3 : in std_logic_vector(31 downto 0); -- Dato de entrada Wd3
        We3 : in std_logic -- Habilitación del banco de registros
    );
end component;

component ALUMIPS is 
    port(
        Op1 : in std_logic_vector (31 downto 0); -- Operando 1
        Op2 : in std_logic_vector (31 downto 0); -- Operando 2
        ALUControl : in std_logic_vector (2 downto 0); -- Selección de operación
        Res : out std_logic_vector (31 downto 0); -- Resultado
        Z : out std_logic -- Resultado es igual a 0
   );
end component;


component UnidadControl is
    port(
        OPCode : in  std_logic_vector (5 downto 0); -- OPCode de la instrucción
        Funct : in std_logic_vector(5 downto 0); -- Funct de la instrucción

        -- Señales para el PC
        Jump : out  std_logic;
        RegToPC : out std_logic;
        Branch : out  std_logic;
        PCToReg : out std_logic;

        -- Señales para la memoria
        MemToReg : out  std_logic;
        MemWrite : out  std_logic;

        -- Señales para la ALU
        ALUSrc : out  std_logic;
        ALUControl : out  std_logic_vector (2 downto 0);
        ExtCero : out std_logic;

        -- Señales para el GPR
        RegWrite : out  std_logic;
        RegDest : out  std_logic
    );
end component;

signal A3: std_logic_vector(4 downto 0);
signal RD1, RD2: std_logic_vector(31 downto 0);

signal Res: std_logic_vector(31 downto 0);
signal Z: std_logic;

signal OPCode, Funct: std_logic_vector(5 downto 0);
signal Jump, RegToPC, Branch, PCToReg, MemToReg, MemWrite,ALUSrc, ExtCero, RegWrite, RegDest: std_logic;
signal ALUControl: std_logic_vector(2 downto 0);

--señales auxiliares--
signal PC: std_logic_vector(31 downto 0);
signal PCplus4: std_logic_vector(31 downto 0);

signal MUXRegDest: std_logic_vector(4 downto 0);
signal MUXPCToReg: std_logic_vector(4 downto 0);

signal DatoExtCero: std_logic_vector(31 downto 0); 
signal DatoExtSigno: std_logic_vector(31 downto 0);

signal MUXExtCero: std_logic_vector(31 downto 0);

signal MUXALUSrc: std_logic_vector(31 downto 0);

signal MUXMemToReg: std_logic_vector(31 downto 0);

signal DatoExtSignoDespl: std_logic_vector(31 downto 0);
signal BTA: std_logic_vector(31 downto 0);

signal MUXPCToReg2:std_logic_vector(31 downto 0);

signal PcSrc: std_logic;
signal MUXPCSrc: std_logic_vector(31 downto 0);

signal JumpDespl: std_logic_vector(27 downto 0);
signal JTA: std_logic_vector(31 downto 0);
signal MUXJump: std_logic_vector(31 downto 0);

signal MUXRegToPc: std_logic_vector(31 downto 0);

begin

RegsMIPSPortMap: RegsMIPS PORT MAP(
        Clk => Clk,
        NRst => NRst,
		  We3 => RegWrite,
        A1 => MemProgData(25 downto 21),
        A2 => MemProgData(20 downto 16),
		  A3 => A3,
		  RD1 => RD1,
		  RD2 => RD2, 	
		  Wd3 => MUXPCToReg2
);

ALUMIPSPortMap: ALUMIPS PORT MAP(
			ALUControl => ALUControl,
			Op1 => RD1,
			Op2 => MUXALUSrc,
			Res => Res,
			Z => Z
);

UnidadControlPortMap: UnidadControl PORT MAP(
		  OpCode => MemProgData(31 downto 26),
        Funct => MemProgData(5 downto 0),
        Jump => Jump,
        RegToPC => RegToPC,
        Branch => Branch,
        PCToReg => PCToReg,
        MemToReg => MemToReg,
        MemWrite => MemWrite,
        ALUSrc => ALUSrc,
        ALUControl => ALUControl,
        ExtCero => ExtCero,
        RegWrite => RegWrite,
        RegDest => RegDest
);

--PC
process(Clk, NRst)
begin
	if Nrst = '0' then
		PC <= (others => '0');
	elsif Clk = '1' and Clk' event then
		PC <= MuxRegToPC;
	end if;
end process;

MemProgAddr <= PC;

--A3
--Multiplexor RegDest
MUXRegDest <= MemProgData(20 downto 16) when RegDest = '0' else MemProgData(15 downto 11);
--Multiplexor PCToReg
MUXPCToReg <=  MUXRegDest when PCToReg = '0' else "11111";
A3 <= MUXPCToReg;

--Implementación de Ext Cero y Ext Signo 
DatoExtCero(31 downto 16) <= (others => '0');
DatoExtCero(15 downto 0) <= MemProgData(15 downto 0);
DatoExtSigno(31 downto 16) <= (others => MemProgData(15));
DatoExtSigno(15 downto 0) <= MemProgData(15 downto 0);

--Multiplexor ExtCero
MUXExtCero <= DatoExtCero when ExtCero = '1' else DatoExtSigno;

--Multiplexor ALUSrc
MUXALUSrc <= RD2 when ALUSrc = '0' else MUXExtCero;

--Memoria Datos
MemDataAddr <= Res;
MemDataDataWrite <= RD2;
MemDataWE <= MemWrite;

--Multiplexor MemToReg
MUXMemToReg <= Res when MemToReg = '0' else MemDataDataRead;

--BTA
PCplus4 <= PC+4;
--Desplazamiento <<2 de DatoExtSigno
DatoExtSignoDespl <= DatoExtSigno(29 downto 0) & "00";
--Sumador
BTA <= DatoExtSignoDespl + PCplus4;

--Multiplexor PCToReg2
MUXPCToReg2 <= MUXMemToReg when PCToReg = '0' else PCplus4;

--Multiplexor PCSrc
PCSrc <= Z AND Branch;
MUXPCSrc <= PCplus4 when PCSrc = '0' else BTA;

--JTA--
--Desplazamiento <<2 del jump
JumpDespl <= MemProgData(25 downto 0) & "00";
JTA <= PCplus4(31 downto 28) & JumpDespl;

--Multiplexor Jump
MUXJump <= MUXPCSrc when Jump = '0' else JTA;

--Multiplexor RegToPC
MUXRegToPC <= MUXJump when RegToPc ='0' else RD1;

end P5e3;