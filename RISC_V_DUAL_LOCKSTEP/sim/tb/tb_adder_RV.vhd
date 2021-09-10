library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.TEXTIO.all;
use work.all;

entity tb_adder_RV is
end tb_adder_RV; 

architecture behaviour of tb_adder_RV is

    signal w_input_0        : std_logic_vector (31 downto 0) := x"00000000";
    signal w_input_1       : std_logic_vector (31 downto 0) := x"00000000";

    signal w_output_0      : std_logic_vector (31 downto 0);
  
begin

-- clock and reset

    DUT_mux: entity work.adder
	port map(
		input_0 => w_input_0,
		input_1 => w_input_1,
		output_0 => w_output_0
	);


    tb_process : process 
    begin
       wait for 1 ns;

       w_input_0  <= x"00000001";
       w_input_1  <= x"00000010";
       assert(w_output_0 = x"00000011") report "Fail test 0" severity error;
       wait for 1 ns;

       w_input_0 <= x"00000100";
       w_input_1 <= x"00000100";
       assert(w_output_0 = x"00001000") report "Fail test 1" severity error;
       wait for 1 ns;


    end process;

	

end behaviour;