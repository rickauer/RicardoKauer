----------------------------------------------------------------------------------
--- Somador de 4 bits ---
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity fourbits is -- aqui será feito a soma de dois vetores
    Port ( cin : in  STD_LOGIC; -- bit de entrada, Carry In
			  a, b : in  STD_LOGIC_vector(3 downto 0); -- dois vetores de entrada de 4 bits
           s : out  STD_LOGIC_vector(3 downto 0); -- vetor de saída s
           cout,f3 : out  STD_LOGIC); -- bits de saída, Carry Out e penúltimo Carry Out, respectivamente

end fourbits;
architecture Behavioral of fourbits is
	component adder -- aqui chamamos o component adder para poder utilizar o módulo adder já feito posteriormente no begin
		PORT(x,y,z: IN std_logic; Sum, Carry: OUT std_logic);
	END COMPONENT;
	SIGNAL t: std_logic_vector(3 downto 1); -- aqui utilizamos o signal t para atribuir os carry's de entrada/saída bit a bit
begin
	FA1: adder PORT MAP(Cin,a(0),b(0),s(0),t(1)); -- aqui é feita a soma dos dois vetores 
	FA2: adder PORT MAP(t(1),a(1),b(1),s(1),t(2));
	FA3: adder PORT MAP(t(2),a(2),b(2),s(2),t(3));
	FA4: adder PORT MAP(t(3),a(3),b(3),s(3),Cout);
	f3 <= t(3) ; -- aqui atribuímos o penúltimo carry out à f3
end Behavioral;
