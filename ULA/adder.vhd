----------------------------------------------------------------------------------
--- Somador de 1 bit ---
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder is --somador bit a bit 
    Port ( x, y, z: in  STD_LOGIC; --aqui definimos as entradas, sendo x e y os bits a serem somados e z o carry in
           Sum: out  STD_LOGIC; -- saída soma
           Carry : out  STD_LOGIC); -- saída carry out
end adder;

architecture dataflow of adder is

begin
Sum<= x XOR y XOR z; -- aqui definimos a saída Sum, que recebe o valor de x XOR y XOR z
Carry<=(y AND z) OR (y AND x) OR (z AND x); -- aqui definimos o carry de saída

end dataflow;
