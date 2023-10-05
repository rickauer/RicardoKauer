----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:32:28 10/18/2022 
-- Design Name: 
-- Module Name:    decremento - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decremento is -- será feito o decremento de 1 bit
    Port ( cin : in  STD_LOGIC; -- bit de entrada, carry in
			  a, b : in  STD_LOGIC_vector(3 downto 0); -- dois vetores de 4 bits de entrada, onde o vetor "a" receberá o decremento
           s : out  STD_LOGIC_vector(3 downto 0); -- saída do vetor s
           cout,f3 : out  STD_LOGIC); -- saída de bit, carry out e penúltimo carry out, respectivamente

end decremento;
architecture Behavioral of decremento is
	component adder -- aqui usamos o component adder para utilizar o módulo já criado no begin posteriormente
		PORT(x,y,z: IN std_logic; Sum, Carry: OUT std_logic);
	END COMPONENT;
	SIGNAL t: std_logic_vector(3 downto 1); -- aqui utilizamos o signal t para atribuir os carry's de entrada/saída bit a bit
begin
	FA1: adder PORT MAP('0',a(0),'1',s(0),t(1)); -- aqui é onde o decremento ocorre
	FA2: adder PORT MAP(t(1),a(1),'1',s(1),t(2)); -- ao somar o vetor "a" com "1111" é o mesmo que subtrair "0001" de "a"
	FA3: adder PORT MAP(t(2),a(2),'1',s(2),t(3));
	FA4: adder PORT MAP(t(3),a(3),'1',s(3),Cout);
	f3 <= t(3) ; -- aqui atribuímos o penúltimo carry out à f3
end Behavioral;
