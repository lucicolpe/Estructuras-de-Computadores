----------------------------------------------------------------------
-- Fichero: RegsMIPS.vhd
-- Descripción: Banco de registros de propósito general del microprocesador MIPS
-- Fecha última modificación:

-- Autores: Claudia Cea Lucía Colmenarejo (Pareja 3)
-- Asignatura: E.C. 1º grado
-- Grupo de Prácticas: 2101
-- Grupo de Teoría: 210
-- Práctica: 3
-- Ejercicio: 2
----------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity RegsMIPS is
    port (
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
end RegsMIPS;

architecture P3e2 of RegsMIPS is

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
            if NRst='0' then --Reset activado
                for i in 0 to 31 loop
                    regs(i)<=(others=>'0');
                end loop;
            elsif Clk='1' and Clk'event then 
						if We3 = '1' then --Write Enable activado
                    --El registro 0 siempre tiene el valor 0
							if conv_integer(A3) /= 0 then
								regs(conv_integer(A3))<=Wd3;
							end if;
						end if; 
            end if;
     end process;
    ------------------------------------------------------
    -- Lectura del registro RS
    ------------------------------------------------------
     Rd1<=regs(conv_integer(A1));
     Rd2<=regs(conv_integer(A2));
	  
end P3e2;



