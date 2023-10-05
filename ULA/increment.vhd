----------------------------------------------------------------------------------
--- Operação Incremento ---
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity increment is -- aqui será feito o incremento de 1 bit ao vetor "a"
    Port ( cin : in  STD_LOGIC; -- bit de entrada, Carry In
			  a, b : in  STD_LOGIC_vector(3 downto 0); -- dois vetores de entrada de 4 bits, onde o vetor "a" que receberá o incremento
           s : out  STD_LOGIC_vector(3 downto 0); -- vetor de saída s
           cout,f3 : out  STD_LOGIC); -- bits de saída, Carry Out e penúltimo Carry Out, respectivamente

end increment;
architecture Behavioral of increment is
	component adder -- aqui chamamos o component adder para utilizar o módulo já feito posteriormente no begin
		PORT(x,y,z: IN std_logic; Sum, Carry: OUT std_logic);
	END COMPONENT;
	SIGNAL t: std_logic_vector(3 downto 1); -- aqui utilizamos o signal t para atribuir os carry's de entrada/saída bit a bit
begin
	FA1: adder PORT MAP('1',a(0),'0',s(0),t(1)); -- aqui é feito o incremento ao somar "a" com o vetor "0000" e recebendo '1' de carry in 
	FA2: adder PORT MAP(t(1),a(1),'0',s(1),t(2));
	FA3: adder PORT MAP(t(2),a(2),'0',s(2),t(3));
	FA4: adder PORT MAP(t(3),a(3),'0',s(3),Cout);
	f3 <= t(3) ; -- aqui é feita a atribuição do penúltimo carry out à f3
end Behavioral;
