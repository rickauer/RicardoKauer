----------------------------------------------------------------------------------
--- Módulo da ULA ---
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ula_mod is -- aqui é o módulo ULA
    Port ( Cinr: in  STD_LOGIC; -- bit de entrada Carry In
			  ar, br : in  STD_LOGIC_vector(3 downto 0); -- dois vetores de entrada de 4 bits
			  sel : in  STD_LOGIC_vector(2 downto 0); -- vetor de entrada de 3 bits, vetor seletor de operações
           sr : out  STD_LOGIC_vector(3 downto 0); -- vetor de saída sr
           coutr,zero,over,neg : out  STD_LOGIC); -- bits de saída, flags: Carry Out, Zero, Overflow e Negativo, respectivamente

end ula_mod;

architecture Behavioral of ula_mod is
	component complemento -- utilizamos o component complemento para poder utilizar o módulo já feito posteriormente no begin
		    Port ( cin : in  STD_LOGIC;
			  a, b : in  STD_LOGIC_vector(3 downto 0);
           s : out  STD_LOGIC_vector(3 downto 0);
           cout,f3 : out  STD_LOGIC);
	end COMPONENT;
	component decremento -- utilizamos o component decremento para poder utilizar o módulo já feito posteriormente no begin
		    Port ( cin : in  STD_LOGIC;
			  a, b : in  STD_LOGIC_vector(3 downto 0);
           s : out  STD_LOGIC_vector(3 downto 0);
           cout,f3 : out  STD_LOGIC);
	end COMPONENT;
	component dobro -- utilizamos o component dobro para poder utilizar o módulo já feito posteriormente no begin
		    Port ( cin : in  STD_LOGIC;
			  a, b : in  STD_LOGIC_vector(3 downto 0);
           s : out  STD_LOGIC_vector(3 downto 0);
           cout,f3 : out  STD_LOGIC);
	end COMPONENT;
	component fourbits -- utilizamos o component fourbits para poder utilizar o módulo já feito posteriormente no begin
		    Port ( cin : in  STD_LOGIC;
			  a, b : in  STD_LOGIC_vector(3 downto 0);
           s : out  STD_LOGIC_vector(3 downto 0);
           cout,f3 : out  STD_LOGIC);
	end COMPONENT;
	component igual -- utilizamos o component igual para poder utilizar o módulo já feito posteriormente no begin
		    Port ( cin : in  STD_LOGIC;
			  a, b : in  STD_LOGIC_vector(3 downto 0);
           s : out  STD_LOGIC_vector(3 downto 0);
           cout,f3 : out  STD_LOGIC);
	end COMPONENT; 
	component increment -- utilizamos o component increment para poder utilizar o módulo já feito posteriormente no begin
		    Port ( cin : in  STD_LOGIC;
			  a, b : in  STD_LOGIC_vector(3 downto 0);
           s : out  STD_LOGIC_vector(3 downto 0);
           cout,f3 : out  STD_LOGIC);
	end COMPONENT;
	component shift -- utilizamos o component shift para poder utilizar o módulo já feito posteriormente no begin
		    Port ( cin : in  STD_LOGIC;
			  a, b : in  STD_LOGIC_vector(3 downto 0);
           s : out  STD_LOGIC_vector(3 downto 0);
           cout,f3 : out  STD_LOGIC);
	end COMPONENT;
	component subtracao -- utilizamos o component subtracao para poder utilizar o módulo já feito posteriormente no begin
		    Port ( cin : in  STD_LOGIC;
			  a, b : in  STD_LOGIC_vector(3 downto 0);
           s : out  STD_LOGIC_vector(3 downto 0);
           cout,f3 : out  STD_LOGIC);
	end COMPONENT;
	SIGNAL t0,t1,t2,t3,t4,t5,t6,t7,sc: STD_LOGIC_vector(3 downto 0); -- utilizamos um signal para mapear os vetores de saída de cada operação
	SIGNAL c0,c1,c2,c3,c4,c5,c6,c7,k0,k1,k2,k3,k4,k5,k6,k7,coutc: STD_LOGIC; -- utilizamos um signal para mapear os carry's out e os penúltimos carry's out de cada operação
	
begin
	OP0: complemento PORT MAP(cinr,ar,br,t0,c0,k0); -- operação de complemento
	OP1: decremento PORT MAP(cinr,ar,br,t1,c1,k1); -- operação de decremento
	OP2: dobro PORT MAP(cinr,ar,br,t2,c2,k2); -- operação dobro
	OP3: fourbits PORT MAP(cinr,ar,br,t3,c3,k3); -- operação de soma de 4 bits
	OP4: igual PORT MAP(cinr,ar,br,t4,c4,k4); -- operação de igualdade
	OP5: increment PORT MAP(cinr,ar,br,t5,c5,k5); -- operação de incremento
	OP6: shift PORT MAP(cinr,ar,br,t6,c6,k6); -- operação de shift
	OP7: subtracao PORT MAP(cinr,ar,br,t7,c7,k7); -- operação de subtração

	coutc <= c0 when (sel="000")else -- aqui é feita a seleção do carry out que deve ser considerado de acordo com a opeação feita
				c1 when (sel="001")else
				c2 when (sel="010")else
				c3 when (sel="011")else
				c4 when (sel="100")else
				c5 when (sel="101")else
				c6 when (sel="110")else
				c7;
	sc <= t0 when (sel="000")else -- aqui é feita a seleção do vetor de saída de acordo com a operação feita
			t1 when (sel="001")else
			t2 when (sel="010")else
			t3 when (sel="011")else
			t4 when (sel="100")else
			t5 when (sel="101")else
			t6 when (sel="110")else
			t7;
	over <= k0 XOR c0 when (sel="000")else  -- aqui é feita a flag de overflow, que seria o carry out XOR o penúltimo carry out
			k1 XOR c1 when (sel="001")else
			'0' when (sel="010")else -- não tem overflow nessa operação
			k3 XOR c3 when (sel="011")else
			k4 XOR c4 when (sel="100")else
			k5 XOR c5 when (sel="101")else
			'0' when (sel="110")else -- não tem overflow nessa operação
			k7 XOR c7;

	neg <= '1' when (sc(3) = '1') else -- aqui é feita a flag de negativo de acordo com o bit mais significativo do vetor de saída
			 '0';
	zero <= '1' when (sc(3)='0' AND sc(2)='0' AND sc(1)='0' AND sc(0)='0') else -- aqui é feita a flag de Zero, que recebe o valor de '1' quando o vetor de saída é "0000"
			  '0';
	coutr <= coutc; -- aqui o Carry Out oficial recebe o valor do signal coutc
	sr <= sc; -- aqui o vetor de saída oficial recebe o valor do signal sc

end Behavioral;
