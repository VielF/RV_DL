library ieee;
use ieee.std_logic_1164.all;

entity mux_IM is
	port (
		i_IM_core   : in std_logic_vector(31 downto 0);
		i_IM_backup : in std_logic_vector(31 downto 0);
		i_sel       : in std_logic;
		o_IM        : out std_logic_vector(31 downto 0)
	);
end mux_IM;

architecture description of reg_1b is

begin
	
    o_IM <= i_IM_core when i_sel = '0' else i_IM_backup;

end description;