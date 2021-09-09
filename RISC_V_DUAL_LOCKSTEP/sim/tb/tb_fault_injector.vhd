library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.TEXTIO.all;
use work.all;

entity tb_mux_IM is
end tb_mux_IM; 

architecture behaviour of tb_mux_IM is

    signal w_data_in      : std_logic_vector(31 downto 0) := x"00000000";
    signal w_sel_in       : std_logic := '0';

    signal w_data_out      : std_logic_vector(31 downto 0);
   
begin

-- clock and reset

    DUT_FI: entity work.fault_injector
    port map(
		i_data      => w_data_in,
		i_ena_fault => w_sel_in,
		o_data      => w_data_out
	);


    tb_process : process 
    begin
       wait for 1 ns;

       w_data_in <= x"FFFFFFFF";
       w_sel_in <= '0';
       assert(w_IM_out = x"FFFFFFFF") report "Fail test 0" severity error;
       wait for 1 ns;

       w_data_in <= x"FFFFFFFF";
       w_sel_in <= '1';
       assert(w_IM_out = x"FFFF0000") report "Fail test 1" severity error;
       wait for 1 ns;


    end process;

	

end behaviour;