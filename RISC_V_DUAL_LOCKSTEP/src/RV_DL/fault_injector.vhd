library ieee;
use ieee.std_logic_1164.all;

entity fault_injector is
	port (
		i_data      : in std_logic_vector(31 downto 0);
		i_ena_fault : in std_logic;
		o_data      : out std_logic_vector(31 downto 0)
	);
end fault_injector;

architecture description of fault_injector is

begin
	
    o_data <= i_data when i_sel = '0' else (i_data(31 downto 20) & not(i_data(19 downto 0)));

end description;