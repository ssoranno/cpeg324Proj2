library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity shift_reg_8bit_tb is
end shift_reg_8bit_tb;

architecture behav of shift_reg_8bit_tb is
--  Declaration of the component that will be instantiated.
component shift_reg_8bit
port (	I:	in std_logic_vector (7 downto 0);
		I_SHIFT_IN: in std_logic;
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; 
		enable:		in std_logic;
		O:	out std_logic_vector(7 downto 0)
);
end component;
--  Specifies which entity is bound with the component.
-- for shift_reg_0: shift_reg_8bit use entity work.shift_reg_8bit(rtl);
signal i, o : std_logic_vector(7 downto 0);
signal i_shift_in, clk, enable : std_logic;
signal sel : std_logic_vector(1 downto 0);

-- set constant clock period to 10 ns
constant clk_period : time := 10 ns;

begin
--  Component instantiation.
shift_reg_0: shift_reg_8bit port map (I => i, I_SHIFT_IN => i_shift_in, sel => sel, clock => clk, enable => enable, O => o);

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
	
	-- Test part 1: i = 00000001
	-- i_shift_in = 1 and enable= 1
	i <= "00000001";
	i_shift_in <= '1';
	enable <= '1';
	
	-- Test if load works correctly for i = 00000001
	sel <= "11";
	wait for 10 ns;
	assert(o = "00000001") report "Test Failed 1" severity error;
	
	-- Test if shift left changes 00000001 to 00000011
	sel <= "01";
	wait for 10 ns;
	assert(o = "00000011") report "Test Failed 2" severity error;
	
	-- Test if shift right changes 00000001 to 10000000
	sel<= "10";
	wait for 10 ns;
	assert(o = "10000000") report "Test Failed 3" severity error;
	
	-- Test if hold works correctly
	sel<= "00";
	wait for 10 ns;
	assert(o = "10000000") report "Test Failed 4" severity error;
	
	-- Test if enable = 0 prevents 00000001 from being shifted to 10000000
	-- this test should cause 00000001 to remain unchanged.
	sel<="11";
	wait for 10 ns;
	enable <='0';
	wait for 5 ns;
	sel<="10";
	wait for 5 ns;
	assert(o = "00000001") report "Test Failed 5" severity error;
	enable<='1';
	
	-- Test if i_shift_in works if it is 0 instead of 1
	i_shift_in <= '0';
	sel<="11";
	wait for 10 ns;
	assert(o = "00000001") report "Test Failed 6" severity error;
	
	-- Test if shift left changes 00000001 to 00000010
	sel<="01";
	wait for 10 ns;
	assert(o = "00000010") report "Test Failed 7" severity error;
	
	-- Test if shift right changes 00000001 to 00000000
	sel<="10";
	wait for 10 ns;
	assert(o = "00000000") report "Test Failed 8" severity error;
----------------------------------------------------------------------	
	-- Test part 2: i = 00001010
	-- i_shift_in = 1 and enable= 1
	i <= "00001010";
	i_shift_in <= '1';
	enable <= '1';
	
	-- Test if load works correctly for i = 00000001
	sel <= "11";
	wait for 10 ns;
	assert(o = "00001010") report "Test Failed 1" severity error;
	
	-- Test if shift left changes 00001010 to 00010101
	sel <= "01";
	wait for 10 ns;
	assert(o = "00010101") report "Test Failed 2" severity error;
	
	-- Test if shift right changes 00001010 to 10000101
	sel<= "10";
	wait for 10 ns;
	assert(o = "10000101") report "Test Failed 3" severity error;
	
	-- Test if hold works correctly
	sel<= "00";
	wait for 10 ns;
	assert(o = "10000101") report "Test Failed 4" severity error;
	
	-- Test if enable = 0 prevents 00001010 from being shifted to 10000101
	-- this test should cause 00001010 to remain unchanged.
	sel<="11";
	wait for 10 ns;
	enable <='0';
	wait for 5 ns;
	sel<="10";
	wait for 5 ns;
	assert(o = "00001010") report "Test Failed 5" severity error;
	enable <= '1';
	
	-- Test if i_shift_in works if it is 0 instead of 1
	i_shift_in <= '0';
	sel<="11";
	wait for 10 ns;
	assert(o = "00001010") report "Test Failed 6" severity error;
	
	-- Test if shift left changes 00001010 to 00010100
	sel<="01";
	wait for 10 ns;
	assert(o = "00010100") report "Test Failed 7" severity error;
	
	-- Test if shift right changes 00001010 to 00000101
	sel<="10";
	wait for 10 ns;
	assert(o = "00000101") report "Test Failed 8" severity error;
	
	assert false report "end of test" severity note;
	
wait;
end process;
end behav;
