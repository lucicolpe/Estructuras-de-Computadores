----------------------------------------------------------------------
-- Fichero: MicroSuma.vhd
-- Descripci�n: Microprocesador que permita realizar �nicamente sumas entre un registro y un dato inmediato
-- Fecha �ltima modificaci�n: 

-- Autores: Claudia Cea, Luc�a Colmenarejo (Pareja 3)
-- Asignatura: E.C. 1� grado
-- Grupo de Pr�cticas: 2101
-- Grupo de Teor�a: 210
-- Pr�ctica: 2
-- Ejercicio: 2
----------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_arith.ALL;
use IEEE.std_logic_unsigned.ALL;

--Componente de nivel superior
entity MicroSuma is
port(
	Clk: in std_logic; -- Reloj
	NRst: in std_logic; -- Reset as�ncrono a nivel bajo
	MemProgData: in std_logic_vector(31 downto 0); --Direcci�n para la memoria del programa
	MemProgAddr: out std_logic_vector(31 downto 0)); --C�digo de operaci�n
end MicroSuma;

architecture P2e2 of MicroSuma is
	
	--Declaraci�n de los componentes
	component regs
	port (
        Clk : in std_logic; -- Reloj
        NRst : in std_logic; -- Reset as�ncrono a nivel bajo
        RtIn : in std_logic_vector(31 downto 0); -- Dato de entrada RT
        RtAddr : in std_logic_vector(4  downto 0); -- Direcci�n RT
        RsAddr : in std_logic_vector(4 downto 0); -- Direcci�n RS
        RsOut : out std_logic_vector(31 downto 0) -- Salida RS
    );
	 end component;
	 
	 component ALUSuma
	 port (
        Op1 : in std_logic_vector(31 downto 0); -- Operando
        Op2 : in std_logic_vector(31 downto 0); -- Operando
        Res : out std_logic_vector(31 downto 0) -- Resultado
    );
	 end component;
	
	 component EXTSigno
	 port(
			DatoIn: in std_logic_vector(15 downto 0); --Dato de entrada en complemento a 2
			Op2: out std_logic_vector(31 downto 0) --Dato con extensi�n de signo
	 );
	 end component;
	 
	 component PC
	  port(
        Clk : in  STD_LOGIC; --Reloj
        Reset : in  STD_LOGIC; -- Reset as�ncrono a nivel bajo
        Q : out  STD_LOGIC_VECTOR (31 downto 0) --Salida del registro
    );
    end component;
	 
	 -- Se�ales auxiliares
	 signal q, op1, op2, res: std_logic_vector(31 downto 0);
	 
	 begin
		
		--Asociaci�n de las entradas y salidas de cada componente por nombre
		a1 : PC PORT MAP (Q =>q, Clk=>Clk, Reset=>NRst);
		a2 : EXTSigno PORT MAP (DatoIn=>MemProgData(15 downto 0), Op2=> op2);
		a3 : Regs PORT MAP (Clk=>Clk, NRst=>NRst, RsAddr=>MemProgData(25 downto 21), RtAddr=> MemProgData(20 downto 16), RtIn=>res, RsOut=> op1);
		a4 : ALUSuma PORT MAP (Op1=> op1, Op2=> op2, Res=> res);
				
		MemProgAddr <= q; --Asignaci�n de la salida 
			
end P2e2;
				
		
			
		

	








