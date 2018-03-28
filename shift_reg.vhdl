library ieee;
use ieee.std_logic_1164.all;
-- library STD;
-- use STD.textio.all;
-- use IEEE.std_logic_textio.all;

entity shift_reg is
port(	I:	in std_logic_vector (3 downto 0);
		I_SHIFT_IN: in std_logic;
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; -- positive level triggering in problem 3
		enable:		in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
		O:	out std_logic_vector(3 downto 0)
);
end shift_reg;

architecture behav of shift_reg is
begin

reg_process: process(clock)
begin
	if rising_edge(clock) then
		if(enable = '1') then
			case sel is
			when "00" =>
			when "01" => 
				O(3 downto 1) <= I(2 downto 0);
				O(0) <= I_SHIFT_IN;
			when "10" =>
				O(2 downto 0) <= I(3 downto 1);
				O(3) <= I_SHIFT_IN;
			when "11" => O <=I;
			when others =>
			end case;
		end if;
	end if;
end process reg_process;

end behav;

