library ieee;
use ieee.std_logic_1164.all;

entity mux_32_1 is
	port (
		selection : in std_logic_vector(4 downto 0);
		input_0, input_1, input_2, input_3, input_4, input_5, input_6, input_7, input_8, input_9, input_10, input_11, input_12, input_13, input_14, input_15, input_16, input_17,
		input_18, input_19, input_20, input_21, input_22, input_23, input_24, input_25, input_26, input_27, input_28, input_29, input_30, input_31 : in std_logic_vector(31 downto 0);
		output_0 : out std_logic_vector(31 downto 0)
	);
end mux_32_1;

architecture behavioral of mux_32_1 is
begin
	output_0 <= input_0 when selection = "00000" else
		input_1 when selection = "00001"  else
		input_2 when selection = "00010"  else
		input_3 when selection = "00011"  else
		input_4 when selection = "00100"  else
		input_5 when selection = "00101"  else
		input_6 when selection = "00110"  else
		input_7 when selection = "00111"  else
		input_8 when selection = "01000"  else
		input_9 when selection = "01001"  else
		input_10 when selection = "01010" else
		input_11 when selection = "01011" else
		input_12 when selection = "01100" else
		input_13 when selection = "01101" else
		input_14 when selection = "01110" else
		input_15 when selection = "01111" else
		input_16 when selection = "10000" else
		input_17 when selection = "10001" else
		input_18 when selection = "10010" else
		input_19 when selection = "10011" else
		input_20 when selection = "10100" else
		input_21 when selection = "10101" else
		input_22 when selection = "10110" else
		input_23 when selection = "10111" else
		input_24 when selection = "11000" else
		input_25 when selection = "11001" else
		input_26 when selection = "11010" else
		input_27 when selection = "11011" else
		input_28 when selection = "11100" else
		input_29 when selection = "11101" else
		input_30 when selection = "11110" else
		input_31;
end behavioral;