library ieee;
use ieee.std_logic_1164.all;

entity mux_2_1 is
	port (
		selection : in std_logic;
		input_0, input_1 : in std_logic_vector(31 downto 0);
		output_0 : out std_logic_vector(31 downto 0)
	);
end mux_2_1;

architecture behavioral of mux_2_1 is
begin
	output_0 <= input_0 when selection = '0' else input_1;
end behavioral;