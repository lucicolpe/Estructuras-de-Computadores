----------------------------------------------------------------------
-- Fichero: MemProgVectores.vhd
-- Descripci�n: Memoria de programa para vectores.asm
-- Fecha �ltima modificaci�n: 2016-03-28

-- Autores: Claudia Cea y Luc�a Colmenarejo (Pareja 3)
-- Asignatura: E.C. 1� grado
-- Grupo de Pr�cticas: 2101
-- Grupo de Teor�a: 210
-- Pr�ctica: 5
-- Ejercicio: 1
----------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_LOGIC_arith.ALL;
use IEEE.std_logic_unsigned.ALL;

entity MemProgVectores is
    port (
        MemProgAddr : in std_logic_vector(31 downto 0); -- Direcci�n para la memoria de programa
        MemProgData : out std_logic_vector(31 downto 0) -- C�digo de operaci�n
    );
end MemProgVectores;

architecture Simple of MemProgVectores is

begin

    LecturaMemProg: process(MemProgAddr)
    begin
        -- La memoria devuelve un valor para cada direcci�n.
        -- Estos valores son los c�digos de programa de cada instrucci�n,
        -- estando situado cada uno en su direcci�n.
        case MemProgAddr is
            when X"00000000" => MemProgData <= X"8c082034"; --lw $t0, C
            when X"00000004" => MemProgData <= X"20100000"; --addi $s0, $0, 0
            when X"00000008" => MemProgData <= X"20140000"; --addi $s4, $0, 0
            when X"0000000C" => MemProgData <= X"20150004"; --addi $s5, $0, 4
            when X"00000010" => MemProgData <= X"8c112000"; --lw $s1, N
            when X"00000014" => MemProgData <= X"0295602a"; --por 4: slt $t4, $s4, $s5 
            when X"00000018" => MemProgData <= X"11800003"; --beq $t4, $0 kes8
            when X"0000001C" => MemProgData <= X"01715820"; --add $t3, $t3, $s1
            when X"00000020" => MemProgData <= X"22940001"; --addi $s4, $s4, 1
            when X"00000024" => MemProgData <= X"08000005"; --j por4
            when X"00000028" => MemProgData <= X"22b50004"; --kes8: addi $s5, $s5, 4
            when X"0000002C" => MemProgData <= X"020b482a"; --for: slt $t1, $s0, $t3
            when X"00000030" => MemProgData <= X"1120000d"; --beq $t1, $0, done 
            when X"00000034" => MemProgData <= X"8e122004"; --lw $s2, A($s0)
            when X"00000038" => MemProgData <= X"8e13201c"; --lw $s3, B($s0)
            when X"0000003C" => MemProgData <= X"0294a022"; --sub $s4, $s4, $s4
            when X"00000040" => MemProgData <= X"0295502a"; --por8: slt $t2, $s4, $s5
            when X"00000044" => MemProgData <= X"11400003"; --beq $t2, $0, next
            when X"00000048" => MemProgData <= X"02d3b020"; --add $s6, $s6, $s3
				when X"0000004C" => MemProgData <= X"22940001"; --addi $s4, $s4, 1
				when X"00000050" => MemProgData <= X"08000010"; --j por8
				when X"00000054" => MemProgData <= X"02564022"; --next: sub $t0, $s2, $s6
				when X"00000058" => MemProgData <= X"ae082034"; --sw $t0, C($s0)
				when X"0000005C" => MemProgData <= X"02d6b022"; --sub $s6, $s6, $s6
				when X"00000060" => MemProgData <= X"22100004"; --addi $s0, $s0, 4
				when X"00000064" => MemProgData <= X"0800000b"; --j for
				when X"00000068" => MemProgData <= X"0800001a"; --done: fin: j fin
				
            when others => MemProgData <= X"00000000"; -- Resto de memoria vac�a
        end case;
    end process LecturaMemProg;

end Simple;








