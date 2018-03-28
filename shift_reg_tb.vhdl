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

constant clk_period : time := 10 ns;

begin
--  Component instantiation.
shift_reg_0: shift_reg port map (I => i, I_SHIFT_IN => i_shift_in, sel => sel, clock => clk, enable => enable, O => o);

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
	
	i <= "0001";
	i_shift_in <= '1';
	sel <= "11";
	enable <= '1';
	wait for 10 ns;
	
	sel <= "01";
	wait for 10 ns;
	sel <= "00";
	
	sel<= "10";
	wait for 10 ns;
	sel <= "00";
	
	enable <='0';
	wait for 10 ns;
	assert false report "end of test" severity note;
	
	
-- type pattern_type is record
-- --  The inputs of the shift_reg.
-- i: std_logic_vector (3 downto 0);
-- i_shift_in, clk, enable: std_logic;
-- sel: std_logic_vector(1 downto 0);
-- --  The expected outputs of the shift_reg.
-- o: std_logic_vector (3 downto 0);
-- end record;
-- --  The patterns to apply.
-- type pattern_array is array (natural range <>) of pattern_type;
-- constant patterns : pattern_array :=
-- (("0001", '1', '1', '0', "11", "0000"),
-- ("0001", '0', '1', '0', "00", "0001"));
-- begin
-- --  Check each pattern.
-- for n in patterns'range loop
-- --  Set the inputs.
-- i <= patterns(n).i;
-- i_shift_in <= patterns(n).i_shift_in;
-- sel <= patterns(n).sel;
-- clk <= patterns(n).clk;
-- enable <= patterns(n).enable;
-- --  Wait for the results.
-- wait for 1 ns;
-- --  Check the outputs.
-- assert o = patterns(n).o
-- report "bad output value" severity error;
-- end loop;
-- assert false report "end of test" severity note;
-- --  Wait forever; this will finish the simulation.
wait;
end process;
end behav;
