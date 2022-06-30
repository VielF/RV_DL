library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.TEXTIO.all;
use work.all;

entity tb_mux_IM is
end tb_mux_IM; 

architecture behaviour of tb_mux_IM is

    signal w_IM_core_in         : std_logic_vector (31 downto 0) := x"00000000";
    signal w_IM_backup_in       : std_logic_vector (31 downto 0) := x"00000000";

    signal w_IM_out      : std_logic_vector (31 downto 0);

    signal w_sel_in      : std_logic := '0';

   
begin

-- clock and reset

    DUT_mux: entity work.mux_IM
    port map(
		i_IM_core   => w_IM_core_in,
		i_IM_backup => w_IM_backup_in,
		i_sel       => w_sel_in,
		o_IM        => w_IM_out
	);


    tb_process : process 
    begin
       wait for 1 ns;

       w_IM_core_in <= x"0000FFFF";
       w_IM_core_in <= x"A00AA00A";
       w_sel_in <= '0';
       assert(w_IM_out = x"0000FFFF") report "Fail test 0" severity error;
       wait for 1 ns;

       w_IM_core_in <= x"0000FFFF";
       w_IM_core_in <= x"A00AA00A";
       w_sel_in <= '1';
       assert(w_IM_out = x"A00AA00A") report "Fail test 1" severity error;
       wait for 1 ns;


    end process;

	

end behaviour;