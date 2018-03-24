library ieee;
use ieee.std_logic_1164.all;

entity P1_tb is
end P1_tb;

architecture test of P1_tb is
	component generic_mux
		generic ( n : positive);
		port (
			a  : in std_logic_vector((n-1) downto 0);
			b  : in std_logic_vector((n-1) downto 0);
			c  : in std_logic_vector((n-1) downto 0);
			d  : in std_logic_vector((n-1) downto 0);
			sel : in std_logic_vector(1 downto 0);
			o  : out std_logic_vector((n-1) downto 0));
	end component;
	
	signal a : std_logic_vector(1 downto 0):="00";
	signal b : std_logic_vector(1 downto 0):="00";
	signal c : std_logic_vector(1 downto 0):="00";
	signal d : std_logic_vector(1 downto 0):="00";
	signal sel : std_logic_vector(1 downto 0):="00";
	signal o : std_logic_vector(1 downto 0):="00";
	
begin
	MUX: generic_mux 
		generic map(n =>2)
		port map(a=>a,b=>b,c=>c,d=>d,sel=>sel,o=>o);
	
	process begin
		wait for 10 ns;
		a<="00";
		b<="01";
		c<="10";
		d<="11";
		
		sel<="00";
		wait for 10 ns;
		assert(o = "00") report "Test Failed" severity error;
		
		sel<="01";
		wait for 10 ns;
		assert(o = "01") report "Test Failed" severity error;
		
		sel<="10";
		wait for 10 ns;
		assert(o = "10") report "Test Failed" severity error;
		
		sel<="11";
		wait for 10 ns;
		assert(o = "11") report "Test Failed" severity error;
		
		assert false report "Reached end of test";
		wait;
	
	end process;
end test;