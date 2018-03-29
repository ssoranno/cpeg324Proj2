-- Steven Soranno and Evan Deangelis
-- Problem 2 part a

library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity shift_reg_tb is
end shift_reg_tb;

architecture behav of shift_reg_tb is
--  Declaration of the component that will be instantiated.
component shift_reg
port (	I:	in std_logic_vector (3 downto 0);
		I_SHIFT_IN: in std_logic;
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; 
		enable:		in std_logic;
		O:	out std_logic_vector(3 downto 0)
);
end component;
--  Specifies which entity is bound with the component.
-- for shift_reg_0: shift_reg use entity work.shift_reg(rtl);
signal i, o : std_logic_vector(3 downto 0);
signal i_shift_in, clk, enable : std_logic;
signal sel : std_logic_vector(1 downto 0);

-- set constant clock period to 10 ns
constant clk_period : time := 10 ns;

begin
--  Component instantiation.
shift_reg_0: shift_reg port map (I => i, I_SHIFT_IN => i_shift_in, sel => sel, clock => clk, enable => enable, O => o);

-- Clock process
clk_process : process
begin
	for i in 1 to 30 loop
	clk <= '0';
	wait for clk_period/2;
	clk <= '1';
	wait for clk_period/2;
	end loop;
	wait;
end process;

-- This process does the real job.
process
begin
	
	-- Test part 1: i = 0001
	-- i_shift_in = 1 and enable= 1
	i <= "0001";
	i_shift_in <= '1';
	enable <= '1';
	
	-- Test if load works correctly for i = 0001
	sel <= "11";
	wait for 10 ns;
	assert(o = "0001") report "Test Failed" severity error;
	
	-- Test if shift left changes 0001 to 0011
	sel <= "01";
	wait for 10 ns;
	assert(o = "0011") report "Test Failed" severity error;
	
	-- Test if shift right changes 0001 to 1000
	sel<= "10";
	wait for 10 ns;
	assert(o = "1000") report "Test Failed" severity error;
	
	-- Test if hold works correctly
	sel<= "00";
	wait for 10 ns;
	assert(o = "1000") report "Test Failed" severity error;
	
	-- Test if enable = 0 prevents 0001 from being shifted to 1000
	-- this test should cause 0001 to remain unchanged.
	sel<="11";
	wait for 10 ns;
	enable <='0';
	wait for 5 ns;
	sel<="10";
	wait for 5 ns;
	assert(o = "0001") report "Test Failed" severity error;
	enable<='1';
	
	-- Test if i_shift_in works if it is 0 instead of 1
	i_shift_in <= '0';
	sel<="11";
	wait for 10 ns;
	assert(o = "0001") report "Test Failed" severity error;
	
	-- Test if shift left changes 0001 to 0010
	sel<="01";
	wait for 10 ns;
	assert(o = "0010") report "Test Failed" severity error;
	
	-- Test if shift right changes 0001 to 0000
	sel<="10";
	wait for 10 ns;
	assert(o = "0000") report "Test Failed" severity error;
----------------------------------------------------------------------	
	-- Test part 2: i = 1010
	-- i_shift_in = 1 and enable= 1
	i <= "1010";
	i_shift_in <= '1';
	enable <= '1';
	
	-- Test if load works correctly for i = 0001
	sel <= "11";
	wait for 10 ns;
	assert(o = "1010") report "Test Failed" severity error;
	
	-- Test if shift left changes 1010 to 0101
	sel <= "01";
	wait for 10 ns;
	assert(o = "0101") report "Test Failed" severity error;
	
	-- Test if shift right changes 1010 to 1101
	sel<= "10";
	wait for 10 ns;
	assert(o = "1101") report "Test Failed" severity error;
	
	-- Test if hold works correctly
	sel<= "00";
	wait for 10 ns;
	assert(o = "1101") report "Test Failed" severity error;
	
	-- Test if enable = 0 prevents 1010 from being shifted to 1101
	-- this test should cause 1010 to remain unchanged.
	sel<="11";
	wait for 10 ns;
	enable <='0';
	wait for 5 ns;
	sel<="10";
	wait for 5 ns;
	assert(o = "1010") report "Test Failed" severity error;
	enable <= '1';
	-- Test if i_shift_in works if it is 0 instead of 1
	i_shift_in <= '0';
	sel<="11";
	wait for 10 ns;
	assert(o = "1010") report "Test Failed" severity error;
	
	-- Test if shift left changes 1010 to 0100
	sel<="01";
	wait for 10 ns;
	assert(o = "0100") report "Test Failed" severity error;
	
	-- Test if shift right changes 1010 to 0101
	sel<="10";
	wait for 10 ns;
	assert(o = "0101") report "Test Failed" severity error;
	
	assert false report "end of test" severity note;
	
wait;
end process;
end behav;
