----------------------------------------------------------------------
-- Fichero: ALUMIPS.vhd
-- Descripci�n: Unidad aritm�tico-l�gica combinacional
-- Fecha �ltima modificaci�n:

-- Autores: Claudia Cea Luc�a Colmenarejo (Pareja 3)
-- Asignatura: E.C. 1� grado
-- Grupo de Pr�cticas: 2101
-- Grupo de Teor�a: 210
-- Pr�ctica: 3
-- Ejercicio: 1
----------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;


entity ALUMIPS is
	port (
		  Op1 : in std_logic_vector (31 downto 0); -- Operando 1
        Op2 : in std_logic_vector (31 downto 0); -- Operando 2
        ALUControl : in std_logic_vector (2 downto 0); -- Selecci�n de operaci�n
        Res : out std_logic_vector (31 downto 0); -- Resultado
		  Z : out std_logic -- Resultado es igual a 0
	);
end ALUMIPS;

architecture P3e1 of ALUMIPS is
	--Se�ales auxiliares
	signal Resta, ResSign: std_logic_vector (31 downto 0);
	
begin
	--Asignaci�n de la se�al auxiliar resta
	Resta <= Op1 - Op2;
	
	--Proceso en el que asignamos las distintas operaciones
	process(ALUControl, Op1, Op2, Resta)
	begin
	
	case ALUControl is
	
		--Suma
		when "010" => 
			ResSign <= Op1 + Op2; 
			
		--Resta	
		when "110" => 
			ResSign <= Resta; 
			
		--AND	
		when "000" =>
			ResSign <= Op1 AND Op2; 
		
		--XOR
		when "011" =>
			ResSign <= Op1 XOR Op2; 
		
		--SLT (La salida Res se pone a 1 si Op1 < Op2)
		when "111" =>	
			--Si los operandos tienen el mismo signo, el valor de la salida depender� de cual sea el msb de la resta 
			if Op1(31) = Op2(31) then
				--Si es 1 significa que el resultado de la resta ha sido negativo, luego Op1 < Op2
				if Resta(31) = '1' then
					ResSign <= (0 => '1', others => '0');
				--Si es 0 significa que el resultado de la resta ha sido positivo, luego Op1 > Op2
				else
					ResSign <= (others => '0');
				end if;	
			--Si los operandos tienen distinto signo, el valor de la salida depender� del signo de Op1	
			else
				--Si el msb de Op1 es 1 entonces la salida se pone a 1 pues Op1 es negativo y Op2 positivo
				if Op1(31) = '1' then
					ResSign <= (0 => '1', others => '0');
				--Si el msb de Op1 es 0 entonces la salida se pone a 0 pues Op1 es positivo y Op2 negativo
				else
					ResSign <= (others => '0');
				end if;	
			end if;
		
		--NOR		
		when "101" =>
			ResSign <= Op1 NOR Op2; 
			
		--En cualquier otro caso ponemos la salida Res a cero	
		when others => 
			ResSign <= (others => '0'); 
			
	end case;
	end process;
	
	--Asignaci�n de la salida Res
	Res <= ResSign;
	
	--Asignaci�n de la salida Z
	--When else va fuera del proceso
	Z <= '1' when ResSign = X"00000000" else '0';
	
end P3e1;	