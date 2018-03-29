-- Steven Soranno and Evan Deangelis
-- Problem 3

library ieee;
use ieee.std_logic_1164.all;
 
-- Full adder to be used by the adder/subtractor
 entity full_adder is
 Port ( 	i1 : in STD_LOGIC; -- input 1
 			i2 : in STD_LOGIC; -- input 2
 			m : in STD_LOGIC; -- mode
 			Cin : in STD_LOGIC; -- carry in
 			sum : out STD_LOGIC; -- sum
 			Cout : out STD_LOGIC); -- carry out
end full_adder;
 
architecture behav of full_adder is

	signal x: std_logic;
 
begin
 	x <= i2 xor m; 
 	sum <= i1 XOR x XOR Cin;
 	Cout <= (i1 AND x) OR (Cin AND i1) OR (Cin AND x);
 
end behav;