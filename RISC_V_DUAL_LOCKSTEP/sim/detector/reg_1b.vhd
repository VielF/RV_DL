library ieee;
use ieee.std_logic_1164.all;

entity reg_1b is
	port (
		i_clk : in std_logic;
		i_rst_n : in std_logic;
		i_din   : in std_logic;
		i_ena : in std_logic;
		o_dout : out std_logic
	);
end reg_1b;

architecture description of reg_1b is
	signal internal_value : std_logic := '0';
begin
	process (i_clk, i_rst_n, i_din)
	begin
		if (i_rst_n = '0') then
			internal_value <= '0';
		elsif rising_edge(i_clk) then
			if (i_ena = '1') then
				internal_value <= i_din;
			else
				internal_value <= internal_value;
			end if;
		end if;
	end process;
    
    o_dout <= internal_value;

end description;