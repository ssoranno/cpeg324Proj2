-- Steven Soranno and Evan Deangelis
-- Problem 3

library ieee;
use ieee.std_logic_1164.all;

entity add_sub is
port(	A:	in std_logic_vector (3 downto 0);
		B:	in std_logic_vector (3 downto 0);
		mode: in std_logic;
		Carry: out std_logic;        
		S:	out std_logic_vector(3 downto 0)
);
end add_sub;

architecture behav of add_sub is

	component full_adder is
		port (	i1 : in STD_LOGIC;
 				i2 : in STD_LOGIC;
 				Cin : in STD_LOGIC;
 				m : in STD_LOGIC;
 				sum : out STD_LOGIC;
 				Cout : out STD_LOGIC
		);
	end component;

	signal c : std_logic_vector(3 downto 0);
	signal temp : std_logic;

begin 
-- Port maps for the 4 full adders
FA1: full_adder 
	port map(i1 => A(0),
				 i2 => B(0) ,
				 m=> mode,
				 Cin => mode,
				 sum => S(0),
				 Cout => c(0)
	);

FA2: full_adder 
	port map(i1 => A(1),
				 i2 => B(1),
				 m=> mode,
				 Cin => c(0),
				 sum => S(1),
				 Cout => c(1)
	);

FA3: full_adder 
	port map(i1 => A(2),
				 i2 => B(2),
				 m=> mode,
				 Cin => c(1),
				 sum => S(2),
				 Cout => c(2)
		
	);

temp <= '0' when ((A(3)= '0') AND (B(3)= '0') AND (mode = '0')) else
	c(2) when NOT ((A(3)= '0') AND (B(3)='0') AND (mode = '0'));

FA4: full_adder 
	port map(i1 => A(3),
				 i2 => B(3),
				 m=> mode,
				 Cin => temp,
				 sum => S(3),
				 Cout => c(3)
		
	);

	Carry <= c(3) xor c(2);
end behav;