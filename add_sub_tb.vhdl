-- Steven Soranno and Evan Deangelis
-- Problem 3

library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity add_sub_tb is
end add_sub_tb;

architecture test of add_sub_tb is
--  Declaration of the component that will be instantiated.
	component add_sub is
	port(	A:	in std_logic_vector (3 downto 0);
			B:	in std_logic_vector (3 downto 0);
			mode: in std_logic;
			Carry: out std_logic;        
			S:	out std_logic_vector(3 downto 0)
	);
	end component;

	signal a, b, s: std_logic_vector(3 downto 0);
	signal mode, carry: std_logic;
begin
	adder: add_sub
	port map (
		A=> a,
		B=> b,
		mode=>mode,
		Carry=>carry,
		S=>s
	);

	process begin
	
		-- Test 1 + 1 = 2
		wait for 10 ns;
		a<="0001";
		b<="0001";
		mode<='0';
		wait for 10 ns;
		assert(s = "0010") report "Test Failed 1" severity error;

		-- Test -7 + 1 = -6
		a<="1001";
		b<="0001";
		mode<='0';
		wait for 10 ns;
		assert(s = "1010") report "Test Failed 2" severity error;

		-- Test 1 - 1 = 0
		a<="0001";
		b<="0001";
		mode<='1';
		wait for 10 ns;
		assert(s = "0000") report "Test Failed 3" severity error;
		
		-- Test 7 + 2 = 9 (overflow)
		a<="0111";
		b<="0010";
		mode<='0';
		wait for 10 ns;
		assert(s = "0001") report "Test Failed 4" severity error;

		-- Test -7 - 2 = -9 (underflow)
		a<="1001";
		b<="0010";
		mode<='1';
		wait for 10 ns;
		assert(s = "0111") report "Test Failed 5" severity error;
		
		-- Test -8 + -1 = -9 (underflow)
		a<="1000";
		b<="1111";
		mode<='0';
		wait for 10 ns;
		assert(s = "0111") report "Test Failed 6" severity error;
		
		-- Test 3 - 4 = -1
		a<="0011";
		b<="0100";
		mode<='1';
		wait for 10 ns;
		assert(s = "1111") report "Test Failed 3" severity error;
		
		wait for 10 ns;
		
		assert false report "end of test" severity note;

	wait;
	end process;
end test;