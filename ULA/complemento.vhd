----------------------------------------------------------------------------------
--- Operação Complemento
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity complemento is -- aqui fazemos o complemento a dois de um vetor 
    Port ( cin : in  STD_LOGIC; -- bit de entrada, Carry In
			  a, b : in  STD_LOGIC_vector(3 downto 0); -- recebemos dois vetores de 4 bits de entrada, sendo que o vetor "a" é o que terá seu complemento feito
           s : out  STD_LOGIC_vector(3 downto 0); -- vetor de saída s
           cout,f3: out  STD_LOGIC); -- bits de saída, onde cout é o Carry Out e o f3 é o penúltimo Carry feito na soma

end complemento;
architecture Behavioral of complemento is
	component adder -- aqui fazemos o component adder para poder usar o módulo já criado e facilitar o complemento a dois
		PORT(x,y,z: IN std_logic; Sum, Carry: OUT std_logic);
	END COMPONENT;
	SIGNAL t: std_logic_vector(3 downto 1); -- aqui utilizamos o sinal t para usar os carry's de entrada/saída bit a bit
begin
	FA1: adder PORT MAP('1',NOT a(0),'0',s(0),t(1)); -- aqui é onde ocorre o complemento
	FA2: adder PORT MAP(t(1),NOT a(1),'0',s(1),t(2)); -- somamos o vetor NOT a com "0000" recebendo carry in '1'
	FA3: adder PORT MAP(t(2),NOT a(2),'0',s(2),t(3));
	FA4: adder PORT MAP(t(3),NOT a(3),'0',s(3),Cout);
	f3 <= t(3) ; -- aqui atribuímos f3 ao penúltimo carry out
end Behavioral;
