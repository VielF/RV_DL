library ieee;
use ieee.std_logic_1164.all;

entity reg_pp is
	generic (
		SIZE : natural := 4
	);
	port (
		i_clk : in std_logic;
		i_rst_n : in std_logic;
		i_din   : in std_logic_vector(SIZE-1 downto 0);
		i_ena_count : in std_logic;
		o_dout : out std_logic_vector(SIZE-1 downto 0)
	);
end reg1b;

architecture description of reg1b is
	signal internal_value : std_logic := '0';
begin
	process (clock, clear, load, internal_value)
	begin
		if (clear = '1') then
			internal_value <= '0';
		elsif rising_edge(clock) then
			if (load = '1') then
				internal_value <= reg_in;
			else
				internal_value <= internal_value;
			end if;
		end if;
		reg_out <= internal_value;
	end process;
end description;