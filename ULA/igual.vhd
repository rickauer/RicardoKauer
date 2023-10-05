----------------------------------------------------------------------------------
--- Operação que verifica igualdade entre dois vetores ---
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity igual is -- aqui será feita a comparação igual de dois vetores
    Port ( cin : in  STD_LOGIC; -- bit de entrada Carry In
			  a, b : in  STD_LOGIC_vector(3 downto 0); -- dois vetores de entrada de 4 bits
           s : out  STD_LOGIC_vector(3 downto 0); -- vetor de saída s
           cout,f3 : out  STD_LOGIC); -- bits de saída, Carry Out e penúltimo Carry Out, respectivamente
end igual;

architecture Behavioral of igual is
	
begin
		s <= "0001" WHEN a = b -- aqui ocorre a atribuição à s de acordo com a comparação entra "a" e "b"
		ELSE "0000";
		f3 <= '0'; -- aqui definimos o vetor f3 como '0' uma vez que não ocorre nenhuma operação utilizando o adder
end Behavioral;
