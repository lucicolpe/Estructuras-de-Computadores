----------------------------------------------------------------------
-- Fichero: Regs.vhd
-- Descripción: Módulo del banco de registros del microprocesador simplificado
-- Fecha última modificación:

-- Autores: Claudia Cea Lucía Colmenarejo (Pareja 3)
-- Asignatura: E.C. 1º grado
-- Grupo de Prácticas: 2101
-- Grupo de Teoría: 210
-- Práctica: 2
-- Ejercicio: 1
----------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity Regs is
    port (
        Clk : in std_logic; -- Reloj
        NRst : in std_logic; -- Reset asíncrono a nivel bajo
        RtIn : in std_logic_vector(31 downto 0); -- Dato de entrada RT
        RtAddr : in std_logic_vector(4  downto 0); -- Dirección RT
        RsAddr : in std_logic_vector(4 downto 0); -- Dirección RS
        RsOut : out std_logic_vector(31 downto 0) -- Salida RS
    );
end Regs;

architecture P2e2 of Regs is

    -- Tipo para almacenar los registros
    type regs_t is array (0 to 31) of std_logic_vector(31 downto 0);

    -- Esta es la señal que contiene los registros. El acceso es de la
    -- siguiente manera: regs(i) acceso al registro i, donde i es
    -- un entero. Para convertir del tipo std_logic_vector a entero se
    -- hace de la siguiente manera: conv_integer(slv), donde
    -- slv es un elemento de tipo std_logic_vector
	 
	 --Para convertir del tipo std_logic_vector a entero 
	 
	 
	 -- Registros inicializados a '0'
	 
	   
    -- NOTA: no cambie el nombre de esta señal.
    signal regs : regs_t;

	 begin  -- PRACTICA

    ------------------------------------------------------
    -- Escritura del registro RT
    ------------------------------------------------------
	 process(Clk, NRst)
		begin
			if NRst='0' then
				for i in 0 to 31 loop
					regs(i)<=(others=>'0');
				end loop;
			elsif Clk='1' and Clk'event then	
					--El registro 0 siempre tiene el valor 0
				   if conv_integer(RtAddr) /= 0 then
					regs(conv_integer(RtAddr))<=RtIn;
					end if;
			end if;
	 end process;
    ------------------------------------------------------
    -- Lectura del registro RS
    ------------------------------------------------------
	 RsOut<=regs(conv_integer(RsAddr));
	 
end P2e2;