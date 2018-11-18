----------------------------------------------------------------------
-- Fichero: ALUSuma.vhd
-- Descripci�n: Suma dos cantidades
-- Fecha �ltima modificaci�n:

-- Autores:
-- Asignatura: E.C. 1� grado
-- Grupo de Pr�cticas:
-- Grupo de Teor�a:
-- Pr�ctica: 2
-- Ejercicio: 2
----------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_LOGIC_arith.ALL;
use IEEE.std_logic_unsigned.ALL;

entity ALUSuma is
    port (
        Op1 : in std_logic_vector(31 downto 0); -- Operando
        Op2 : in std_logic_vector(31 downto 0); -- Operando
        Res : out std_logic_vector(31 downto 0) -- Resultado
    );
end ALUSuma;

architecture P2e2 of ALUSuma is

begin

	Res <= Op1 + Op2; --Asignaci�n de la salida
	
end P2e2;
