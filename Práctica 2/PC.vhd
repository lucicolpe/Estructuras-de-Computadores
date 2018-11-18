----------------------------------------------------------------------
-- Fichero: PC.vhd
-- Descripci�n: Registro de 32 bits que incrementa en 4 cada ciclo de reloj (tipo contador)
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


-- Contador de 32 bits
entity PC is
    Port (
        Clk : in  STD_LOGIC; --Reloj
        Reset : in  STD_LOGIC; --Reset as�ncrono
        Q : out  STD_LOGIC_VECTOR (31 downto 0) --Salida del registro
    );
end PC;

architecture P2e2 of PC is

    -- Se�al auxiliar que almacena el valor
    signal qTemp : std_logic_vector (31 downto 0);

    begin

    Q <= qTemp;

    process (Clk, Reset)
    begin
        if Reset = '0' then
            qTemp <= (OTHERS => '0');
        elsif Clk='1' and Clk'event then
            qTemp <= qTemp + 4; --Incrementa en 4 cada ciclo de reloj
        end if;

    end process;

end P2e2;



