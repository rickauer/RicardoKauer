----------------------------------------------------------------------------------
--- Operação Subtração ---
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity subtracao is -- aqui será feita a subtração "a"-"b"
    Port ( cin : in  STD_LOGIC; -- bit de entrada Carry In
			  a, b : in  STD_LOGIC_vector(3 downto 0); -- dois vetores de entrada de 4 bits
           s : out  STD_LOGIC_vector(3 downto 0); -- vetor de saída
           cout,f3 : out  STD_LOGIC); -- bits de saída, Carry Out e penúltimo Carry Out, respectivamente

end subtracao;
architecture Behavioral of subtracao is
	component adder -- aqui é utilizado o component adder para podermos posteriormente utilizar o módulo já feito no begin
		PORT(x,y,z: IN std_logic; Sum, Carry: OUT std_logic);
	END COMPONENT;
	SIGNAL t: std_logic_vector(3 downto 1); -- aqui utilizamos o signal t para atribuir os carry's de entrada/saída bit a bit
begin
	FA1: adder PORT MAP('1',a(0),NOT b(0),s(0),t(1)); -- aqui é feita a soma do vetor "a" com o vetor de complemento a dois de "b"
	FA2: adder PORT MAP(t(1),a(1),NOT b(1),s(1),t(2)); -- dessa forma, é somado "a" com NOT "b", recebendo '1' de carry In
	FA3: adder PORT MAP(t(2),a(2),NOT b(2),s(2),t(3));
	FA4: adder PORT MAP(t(3),a(3),NOT b(3),s(3),Cout);
		f3 <= t(3) ; -- aqui é feita a atribuição do penúltimo carry out à f3
end Behavioral;
