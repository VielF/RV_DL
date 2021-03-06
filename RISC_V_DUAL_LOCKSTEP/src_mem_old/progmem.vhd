library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity progmem is
	port (
		address : in std_logic_vector(15 downto 0);
		clock : in std_logic;
		output_data : out std_logic_vector(31 downto 0)
	);
end entity progmem;

architecture behavioural of progmem is

begin
	myROM: process(clock,address) is
	begin
    	if (rising_edge(clock)) then
        	case address is
            		when x"0001"   => output_data <= "00000000000100000000000100010011"; -- ADDI x2, x0, 1;
            		when x"0002"   => output_data <= "00000000001000000000111110110011"; -- ADD  x31, x0, x2; --debug the result
            		when x"0003"   => output_data <= "00000000001000001000000010110011"; -- ADD  x1, x1, x2;
            		when x"0004"   => output_data <= "00000000000100000000111110110011"; -- ADD  x31, x0, x1; --debug the result
            		when x"0005"   => output_data <= "00000000000100010000000100110011"; -- ADD  x2, x2, x1;
            		when x"0006"   => output_data <= "00000000001000000000111110110011"; -- ADD  x31, x0, x2; --debug the result
			--when x"0007"   => output_data <= "00000000100000000000000001100111"; -- JALR x0, x0, 8;
            		when others => output_data <= x"00000000"; -- 0
        	end case;
    	end if;
	end process myROM;

end architecture behavioural;
