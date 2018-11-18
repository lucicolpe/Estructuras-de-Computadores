----------------------------------------------------------------------
-- Fichero: UnidadControl.vhd
-- Descripción: unidad de Control para el microprocesador MIPS
-- Fecha última modificación: 2016-03-28

-- Autores: Claudia Cea y Lucía Colmenarejo (Pareja 3)
-- Asignatura: E.C. 1º grado
-- Grupo de Prácticas: 2101
-- Grupo de Teoría: 210
-- Práctica: 5
-- Ejercicio: 2
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UnidadControl is
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
end UnidadControl;

architecture P5e2 of UnidadControl is
begin
	--MemToReg
	MemToReg <= '1' when OPCode ="100011" else '0'; --Lee de la memoria en vez de la ALU en lw
	
	--MemWrite
	MemWrite <= '1' when OPCode ="101011" else '0'; --Solo se escribe en memoria con sw
	
	--Branch
	Branch <= '1' when OPCode ="000100" else '0'; --Se activa con la instrucción beq independientemente de si realiza o no el salto al final
	
	--ALUControl
	process(OpCode, Funct)
	begin
		case OPCode is 
			--Instrucciones tipo R
			when "000000" => 
				if Funct= "100100" then --And 
					ALUControl<= "000"; --And de dos registros
				elsif Funct= "100000" then --Add
					ALUControl<= "010"; --Suma dos registros
				elsif Funct= "100010" then --Sub
					ALUControl<= "110"; --Resta dos registros
				elsif Funct= "100111" then --Nor
					ALUControl<= "101"; --Nor de dos registros
				elsif Funct= "100110" then --Xor
					ALUControl<= "011"; --Xor de dos registros
				elsif Funct= "101010" then --Slt
					ALUControl<= "111"; --Slt de dos registros
				else
					ALUControl<= "000"; --Los casos en los que ALUControl es X (jr) lo ponemos a "000"
				end if;
		   --Instrucciones tipo I
			when "100011"=> ALUControl <=  "010"; --Lw: suma un registro y un dato inmmedianto
			when "101011"=> ALUControl <=  "010"; --Sw: suma un registro y un dato inmmedianto
			when "000100"=> ALUControl <=  "110"; --Beq: resta dos registros para ver si son iguales
			when "001000"=> ALUControl <=  "010"; --Addi: suma un registro y un dato inmmedianto 
			when "001100"=> ALUControl <=  "000"; --Andi: And de un registro y un dato inmmedianto	
			when "001110"=> ALUControl <=  "011"; --Xori: Xor de un registro y un dato inmmedianto
			when "001010"=> ALUControl <=  "111"; --Slti: Slt de un registro y un dato inmmedianto
			when others => ALUControl <= "000"; --Los casos en los que ALUControl es X (j y jal) lo ponemos a "000"
		end case;
	end process;
	
	--ALUSrc
	with OPCode select
		ALUSrc <= '0' when "000000", --En las instrucciones de tipo R a la ALU le entran dos registros
					 '0' when "000100", --En la instrucción beq a la ALU le entran dos registros
					 '1' when others; --En el resto de casos, a la ALU le entra un registro y un dato inmediato o es indiferente
					 
	--RegDest				 
	RegDest <= '1' when OPCode ="000000" else '0'; --En las instrucciones de tipo R se escribe en el registro destino rd y en las de tipo I en el registro rt
	
	--RegWrite
	process(OPCode, Funct)
	begin
		--Instrucciones tipo R
		if OPCode = "000000" then
			if Funct = "001000" then --jr
				RegWrite <= '0'; --No se escribe en ningún registro
			else 
				RegWrite <= '1'; --En el resto de casos sí se escribe en registro
			end if;
		--Instrucciones tipo I
		elsif OPCode= "101011" then --sw
			RegWrite <= '0'; --No se escribe en ningún registro
		elsif OPCode= "000100" then --beq
			RegWrite <= '0'; --No se escribe en ningún registro
		elsif OPCode= "000010" then --j
			RegWrite <= '0'; --No se escribe en ningún registro
		else 
			RegWrite <= '1'; --En el resto de casos sí se escribe en registro
		end if;
	end process;
	
	--RegToPC
	RegToPC <= '1' when OPCode = "000000" and Funct= "001000" else '0'; --Se activa con la instrucción jr
	
	--ExtCero
	with OPCode select
		ExtCero <= '1' when "001100", --Hacemos extensión de cero en la andi 
					  '1' when "001110", --Hacemos extensión de cero en la xori
					  '0' when others; --En el resto de casos hacemos la extensión en signo
	
   --Jump	
	with OPCode select
		Jump <= '1' when "000010", --Se activa con la intrucción j
				  '1' when "000011", --Se activa con la intrucción jal
				  '0' when others; --Como en el resto de casos no se produce un salto se pone a cero
	
	--PCToReg
	PCToReg <= '1' when OPCode= "000011" else '0'; --En la instrucción jal Pc+4 debe ir al banco de registros
	
end P5e2;

