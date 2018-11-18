----------------------------------------------------------------------
-- Fichero: MicroSuma.vhd
-- Descripción: Microprocesador que permita realizar únicamente sumas entre un registro y un dato inmediato
-- Fecha última modificación: 

-- Autores: Claudia Cea, Lucía Colmenarejo (Pareja 3)
-- Asignatura: E.C. 1º grado
-- Grupo de Prácticas: 2101
-- Grupo de Teoría: 210
-- Práctica: 2
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
	NRst: in std_logic; -- Reset asíncrono a nivel bajo
	MemProgData: in std_logic_vector(31 downto 0); --Dirección para la memoria del programa
	MemProgAddr: out std_logic_vector(31 downto 0)); --Código de operación
end MicroSuma;

architecture P2e2 of MicroSuma is
	
	--Declaración de los componentes
	component regs
	port (
        Clk : in std_logic; -- Reloj
        NRst : in std_logic; -- Reset asíncrono a nivel bajo
        RtIn : in std_logic_vector(31 downto 0); -- Dato de entrada RT
        RtAddr : in std_logic_vector(4  downto 0); -- Dirección RT
        RsAddr : in std_logic_vector(4 downto 0); -- Dirección RS
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
			Op2: out std_logic_vector(31 downto 0) --Dato con extensión de signo
	 );
	 end component;
	 
	 component PC
	  port(
        Clk : in  STD_LOGIC; --Reloj
        Reset : in  STD_LOGIC; -- Reset asíncrono a nivel bajo
        Q : out  STD_LOGIC_VECTOR (31 downto 0) --Salida del registro
    );
    end component;
	 
	 -- Señales auxiliares
	 signal q, op1, op2, res: std_logic_vector(31 downto 0);
	 
	 begin
		
		--Asociación de las entradas y salidas de cada componente por nombre
		a1 : PC PORT MAP (Q =>q, Clk=>Clk, Reset=>NRst);
		a2 : EXTSigno PORT MAP (DatoIn=>MemProgData(15 downto 0), Op2=> op2);
		a3 : Regs PORT MAP (Clk=>Clk, NRst=>NRst, RsAddr=>MemProgData(25 downto 21), RtAddr=> MemProgData(20 downto 16), RtIn=>res, RsOut=> op1);
		a4 : ALUSuma PORT MAP (Op1=> op1, Op2=> op2, Res=> res);
				
		MemProgAddr <= q; --Asignación de la salida 
			
end P2e2;
				
		
			
		

	








