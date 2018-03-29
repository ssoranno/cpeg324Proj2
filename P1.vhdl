-- Steven Soranno and Evan Deangelis
-- Problem 1

library ieee;
use ieee.std_logic_1164.all;

entity generic_mux is
  generic ( n : positive);
  port (
    a  : in std_logic_vector((n-1) downto 0);
    b  : in std_logic_vector((n-1) downto 0);
	c  : in std_logic_vector((n-1) downto 0);
	d  : in std_logic_vector((n-1) downto 0);
	sel : in std_logic_vector(1 downto 0);
    o  : out std_logic_vector((n-1) downto 0));
end generic_mux;

architecture M of generic_mux is
begin
	o <= (a after 5 ns) when sel="00" else
	(b after 5 ns) when sel="01" else
	(c after 5 ns) when sel="10" else
	(d after 5 ns) when sel="11";
end M;