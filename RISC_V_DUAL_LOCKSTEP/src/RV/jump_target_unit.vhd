library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity jump_target_unit is
	port (
		mux_sel : in std_logic;
		current_instruction_address : in std_logic_vector(31 downto 0);
		regfile_address : in std_logic_vector(31 downto 0);
		immediate : in std_logic_vector(31 downto 0);
		target_address : out std_logic_vector(31 downto 0)
	);
end jump_target_unit;

architecture behavioral of jump_target_unit is
	signal mux_output : std_logic_vector (31 downto 0) := X"00000000";
	signal current_instruction_address_aux : std_logic_vector (31 downto 0);
	component mux_2_1
	port (
		selection : in std_logic;
		input_0, input_1 : in std_logic_vector(31 downto 0);
		output_0 : out std_logic_vector(31 downto 0)
	);
	end component;

	component adder
	port (
		input_0 : in std_logic_vector(31 downto 0);
		input_1 : in std_logic_vector(31 downto 0);
		output_0 : out std_logic_vector(31 downto 0)
	);
	end component;
begin
	--This is using promem_interface div by 4
	--current_instruction_address_aux <= std_logic_vector(unsigned(current_instruction_address) - 16) when current_instruction_address /= x"00000000" else current_instruction_address;
	--This is using promem_interface not div by 4
	current_instruction_address_aux <= std_logic_vector(unsigned(current_instruction_address) - 4) when current_instruction_address /= x"00000000" else current_instruction_address;
	--internal_mux : mux_2_1 port map(mux_sel, current_instruction_address, regfile_address, mux_output);
	internal_mux : mux_2_1 port map(mux_sel, current_instruction_address_aux, regfile_address, mux_output);
	internal_adder : adder port map(mux_output, immediate, target_address);
end behavioral;