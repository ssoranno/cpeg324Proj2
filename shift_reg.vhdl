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
signal hold, s1, sr, load: std_logic;
signal temp: std_logic_vector(3 downto 0);
begin

-- hold <= '1' when sel = "00";
-- sl <= '1' when sel = "01";
-- sr <= '1' when sel = "10";
-- load <= '1' when sel = "11";

reg_process: process(clock)
begin
	if rising_edge(clock) then
		if(enable = '1') then
			case sel is
			when "00" =>
			when "01" => 
				--temp<= I;
				temp(3 downto 1) <= I(2 downto 0);--O(2);
				--temp(2) <= I(1);
				--temp(1) <= I(0);
				temp(0) <= I_SHIFT_IN;
				--temp<="0001";
				O<=temp;
			when "10" =>
				--temp<=I;
				temp(0) <= I(1);
				temp(1) <= I(2);
				temp(2) <= I(3);
				temp(3) <= I_SHIFT_IN;
				O <=temp;
			when "11" => O <=I;
			when others =>
			end case;
		end if;
	end if;
end process reg_process;
O<=temp;
--sel_process:process
--begin
--if(sel = "00") then
--	hold <= '1';
--elsif(sel = "10") then
--	sl <= '1';
--elsif(sel = "01") then
--	sr <= '1';
--else
--	load <= '1';
--end if;
--end process sel_process;

-- hold_process: process(hold)
-- begin
-- enable<='0'
-- end process hold_process;

-- sl_process: process(sl)
-- begin
-- if(clock'event and clock = '1') then
	-- if enable = '1' then
		-- O(3) <= O(2);
		-- O(2) <= O(1);
		-- O(1) <= O(0);
		-- O(0) <= I_SHIFT_IN;
	-- end if;
-- end if;
-- end process sl_process

-- sr_process: process(sr)
-- begin
-- if(clock'event and clock = '1') then
	-- if enable = '1' then
		-- O(0) <= O(1);
		-- O(1) <= O(2);
		-- O(2) <= O(3);
		-- O(3) <= I_SHIFT_IN;
	-- end if;
-- end if;
-- end process sr_process

-- load_process: process(load)
-- begin

-- end process load_process

end behav;

