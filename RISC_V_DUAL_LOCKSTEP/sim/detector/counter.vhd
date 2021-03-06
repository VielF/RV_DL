library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity counter is
	generic (
		SIZE : natural := 4
	);
	port (
		i_clk : in std_logic;
		i_rst_n : in std_logic;
		i_ena_count : in std_logic;
		o_counter : out std_logic_vector(SIZE-1 downto 0)
	);
end counter;

architecture description of counter is
	signal conter_reg : std_logic_vector(SIZE-1 downto 0) := (others => '0');
begin
	process (i_clk, i_rst_n, i_ena_count)
	begin
		if (i_rst_n = '0') then
			conter_reg <= (others => '0');
		elsif rising_edge(i_clk) then
			if (i_ena_count = '1') then
				conter_reg <= conter_reg + "0001";
			else
				conter_reg <= conter_reg;
			end if;
		end if;
	end process;
	
	o_counter <= conter_reg;

end description;