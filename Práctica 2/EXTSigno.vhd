----------------------------------------------------------------------
-- Fichero: EXTSigno.vhd
-- Descripci�n: Pasa un n�mero de 16 bits a uno de 32 haciendo una extensi�n del signo
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
use IEEE.std_LOGIC_arith.ALL;
use IEEE.std_logic_unsigned.ALL;


entity EXTSigno is
port(
			DatoIn: in std_logic_vector(15 downto 0); --Dato de entrada en complemento a 2
			Op2: out std_logic_vector(31 downto 0) --Dato con extensi�n de signo
);
end EXTSigno;

architecture P2e2 of EXTSigno is
begin

	--Rellenamos con el msb del dato de entrada para mantener el n�mero con su signo
	Op2(31 downto 16) <= (others => DatoIn(15));
	Op2(15 downto 0) <= DatoIn;
	
end P2e2;




	