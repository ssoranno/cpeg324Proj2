-- Steven Soranno and Evan Deangelis
-- Problem 2 part b

library ieee;
use ieee.std_logic_1164.all;

entity shift_reg_8bit is
port(	I:	in std_logic_vector (7 downto 0); -- Input vector
		I_SHIFT_IN: in std_logic; -- Value to shift in
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; -- positive level triggering in problem 3
		enable:		in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
		O:	out std_logic_vector(7 downto 0)
);
end shift_reg_8bit;

architecture behav of shift_reg_8bit is

component shift_reg is
port(	I:	in std_logic_vector (3 downto 0); -- Input vector
		I_SHIFT_IN: in std_logic; -- Value to shift in
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; -- positive level triggering in problem 3
		enable:		in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
		O:	out std_logic_vector(3 downto 0)
);
end component;

-- Signals used to determine I_SHIFT_IN for SR1 and SR2
signal ISR1: std_logic;
signal ISR2: std_logic;

begin

-- If shift left I_SHIFT_IN for SR1 should be I_SHIFT_IN
-- If shift right I_SHIFT_IN for SR1 should be I(4)
ISR1<= I_SHIFT_IN when sel(0) = '1' else
	I(4) when sel(0) = '0';

-- If shift left I_SHIFT_IN for SR1 should be I(3)
-- If shift right I_SHIFT_IN for SR1 should be I_SHIFT_IN
ISR2<= I(3) when sel(0) = '1' else
	I_SHIFT_IN when sel(0) = '0';

-- Port maps for the 2 4-bit shift registers
SR1: shift_reg port map(I=>I(3 downto 0), I_SHIFT_IN=>ISR1, sel=>sel, enable=>enable, clock=>clock, O=>O(3 downto 0));
SR2: shift_reg port map(I=>I(7 downto 4), I_SHIFT_IN=>ISR2, sel=>sel, enable=>enable, clock=>clock, O=>O(7 downto 4));

end behav;
