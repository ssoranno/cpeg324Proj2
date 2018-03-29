library ieee;
use ieee.std_logic_1164.all;
 

 entity full_adder is
 Port ( 	i1 : in STD_LOGIC;
 			i2 : in STD_LOGIC;
 			m : in STD_LOGIC;
 			Cin : in STD_LOGIC;
 			sum : out STD_LOGIC;
 			Cout : out STD_LOGIC);
end full_adder;
 
architecture behav of full_adder is

	signal x: std_logic;
 
begin
 	x <= i2 xor m; 
 	sum <= i1 XOR x XOR Cin;
 	Cout <= (i1 AND x) OR (Cin AND i1) OR (Cin AND x);
 
end behav;