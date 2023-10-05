----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:43:08 10/18/2022 
-- Design Name: 
-- Module Name:    dobro - Behavioral 
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

entity dobro is -- faremos o dobro do vetor "a"
    Port ( cin : in  STD_LOGIC; -- entrada de bit Carry In
			  a, b : in  STD_LOGIC_vector(3 downto 0); -- dois vetores de entrada de 4 bits, sendo que o vetor "a" é o que será dobrado
           s : out  STD_LOGIC_vector(3 downto 0); -- vetor de saída s
           cout,f3 : out  STD_LOGIC); -- bits de saída, Carry Out e penúltimo Carry Out, respectivamente

end dobro;
architecture Behavioral of dobro is
	component adder -- aqui chamamos o component adder para poder utilizar o módulo já feito adder posteriormente no begin
		PORT(x,y,z: IN std_logic; Sum, Carry: OUT std_logic);
	END COMPONENT;
	SIGNAL t: std_logic_vector(3 downto 1); -- aqui utilizamos o signal t para atribuir os carry's de entrada/saída bit a bit
begin
	FA1: adder PORT MAP('0',a(0),a(0),s(0),t(1)); -- aqui somamos o vetor "a" com ele mesmo para produzir o dobro de "a"
	FA2: adder PORT MAP(t(1),a(1),a(1),s(1),t(2));
	FA3: adder PORT MAP(t(2),a(2),a(2),s(2),t(3));
	FA4: adder PORT MAP(t(3),a(3),a(3),s(3),Cout);
	f3 <= t(3) ; -- aqui atribuímos o penúltimo carry out à f3
end Behavioral;
