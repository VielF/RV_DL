-- This testbench test all mux from RISC-V core

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.TEXTIO.all;
use work.all;

entity tb_mux_RV is
end tb_mux_RV; 

architecture behaviour of tb_mux_RV is

    signal w_m21_input0     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m21_input1     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m21_out        : std_logic_vector (31 downto 0);
    signal w_m21_selection  : std_logic := '0';

    signal w_m31_input0     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m31_input1     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m31_input2     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m31_out        : std_logic_vector (31 downto 0);
    signal w_m31_selection  : std_logic_vector(1 downto 0) := "00";


    signal w_m51_input0     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m51_input1     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m51_input2     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m51_input3     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m51_input4     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m51_out        : std_logic_vector (31 downto 0);
    signal w_m51_selection  : std_logic_vector(2 downto 0) := "000";

    signal w_m321_input0     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input1     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input2     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input3     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input4     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input5     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input6     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input7     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input8     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input9     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input10     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input11     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input12     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input13     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input14     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input15     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input16     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input17     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input18     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input19     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input20     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input21     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input22     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input23     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input24     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input25     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input26     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input27     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input28     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input29     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input30     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_input31     : std_logic_vector (31 downto 0) := x"00000000";
    signal w_m321_out        : std_logic_vector (31 downto 0);
    signal w_m321_selection  : std_logic_vector(4 downto 0) := "00000";

   
begin

-- clock and reset

    DUT_mux_2_1: entity work.mux_2_1
        port map(
            selection => w_m21_selection,
            input_0   => w_m21_input0, 
            input_1   => w_m21_input1,
            output_0  => w_m21_out
        );


    DUT_mux_3_1: entity work.mux_3_1
        port map(
            selection => w_m31_selection,
            input_0   => w_m31_input0, 
            input_1   => w_m31_input1, 
            input_2   => w_m31_input2,
            output_0  => w_m31_out
        );


    DUT_mux_5_1: entity work.mux_5_1
        port map(
            selection => w_m51_selection,
            input_0   => w_m51_input0, 
            input_1   => w_m51_input1,  
            input_2   => w_m51_input2,  
            input_3   => w_m51_input3, 
            input_4   => w_m51_input4, 
            output_0   => w_m51_out
        );

    DUT_mux_32_1: entity work.mux_32_1
        port map(
            selection   =>  w_m321_selection,
            input_0   =>    w_m321_input0 , 
            input_1   =>    w_m321_input1 , 
            input_2   =>    w_m321_input2 , 
            input_3   =>    w_m321_input3 , 
            input_4   =>    w_m321_input4 , 
            input_5   =>    w_m321_input5 , 
            input_6   =>    w_m321_input6 , 
            input_7   =>    w_m321_input7 , 
            input_8   =>    w_m321_input8 , 
            input_9   =>    w_m321_input9 , 
            input_10   =>   w_m321_input10,
            input_11   =>   w_m321_input11,
            input_12   =>   w_m321_input12,
            input_13   =>   w_m321_input13,
            input_14   =>   w_m321_input14,
            input_15   =>   w_m321_input15,
            input_16   =>   w_m321_input16,
            input_17   =>   w_m321_input17,
            input_18   =>   w_m321_input18,
            input_19   =>   w_m321_input19,
            input_20   =>   w_m321_input20,
            input_21   =>   w_m321_input21,
            input_22   =>   w_m321_input22,
            input_23   =>   w_m321_input23,
            input_24   =>   w_m321_input24,
            input_25   =>   w_m321_input25,
            input_26   =>   w_m321_input26,
            input_27   =>   w_m321_input27,
            input_28   =>   w_m321_input28,
            input_29   =>   w_m321_input29,
            input_30   =>   w_m321_input20,
            input_31   =>   w_m321_input31,
            output_0   =>   w_m321_out
        );


    tb_process_mux21 : process 
    begin
       wait for 1 ns;

       w_m21_input0    <= x"0000FFFF";
       w_m21_input1    <= x"A00AA00A";
       w_m21_selection       <= '0';
       assert(w_m21_out = x"0000FFFF") report "Fail test 0" severity error;
       wait for 1 ns;

       w_m21_input0    <= x"0000FFFF";
       w_m21_input1    <= x"A00AA00A";
       w_m21_selection <= '1';
       assert(w_m21_out = x"A00AA00A") report "Fail test 1" severity error;
       wait for 1 ns;
    end process;

    tb_process_mux31 : process 
    begin
       wait for 1 ns;

       w_m31_input0    <= x"0000FFFF";
       w_m31_input1    <= x"A00AA00A";
       w_m31_input2    <= x"E00EE0EE";
       w_m31_selection <= "00";    
       assert(w_m31_out = x"0000FFFF") report "Fail test 0" severity error;
       wait for 1 ns;

       w_m31_input0    <= x"0000FFFF";
       w_m31_input1    <= x"A00AA00A";
       w_m31_input2    <= x"E00EE0EE";
       w_m31_selection <= "01";    
       assert(w_m31_out = x"A00AA00A") report "Fail test 1" severity error;
       wait for 1 ns;

       w_m31_input0    <= x"0000FFFF";
       w_m31_input1    <= x"A00AA00A";
       w_m31_input2    <= x"E00EE0EE";
       w_m31_selection <= "10";    
       assert(w_m31_out = x"E00EE0EE") report "Fail test 2" severity error;
       wait for 1 ns;

       w_m31_input0    <= x"0000FFFF";
       w_m31_input1    <= x"A00AA00A";
       w_m31_input2    <= x"E00EE0EE";
       w_m31_selection <= "11";    
       assert(w_m31_out = x"E00EE0EE") report "Fail test 3" severity error;
       wait for 1 ns;
    end process;

    tb_process_mux51 : process 
    begin
       wait for 1 ns;
       
       w_m51_input0   <= x"0000000F";
       w_m51_input1   <= x"000000FF";
       w_m51_input2   <= x"00000FFF";
       w_m51_input3   <= x"0000FFFF";
       w_m51_input4   <= x"000FFFFF";      
       w_m51_selection <= "000";
       assert(w_m51_out = x"0000000F") report "Fail test 0" severity error;
       wait for 1 ns;
    
       w_m51_selection <= "001";
       assert(w_m51_out = x"000000FF") report "Fail test 0" severity error;
       wait for 1 ns;
      
       w_m51_selection <= "010";
       assert(w_m51_out = x"00000FFF") report "Fail test 0" severity error;
       wait for 1 ns;
   
       w_m51_selection <= "011";
       assert(w_m51_out = x"0000FFFF") report "Fail test 0" severity error;
       wait for 1 ns;
      
       w_m51_selection <= "100";
       assert(w_m51_out = x"000FFFFF") report "Fail test 0" severity error;
       wait for 1 ns;
    end process;

    tb_process_mux321 : process 
    begin
       wait for 1 ns;

       w_m321_input0   <= x"0000000F";
       w_m321_input1   <= x"000000FF";
       w_m321_input2   <= x"00000FFF";
       w_m321_input3   <= x"0000FFFF";
       w_m321_input4   <= x"000FFFFF";
       w_m321_input5   <= x"000F000F";
       w_m321_input6   <= x"000F00FF";
       w_m321_input7   <= x"000F0FFF";
       w_m321_input8   <= x"000FFFFF";
       w_m321_input9   <= x"00FFFFFF";
       w_m321_input10  <= x"F000000F";
       w_m321_input11  <= x"F00000FF";
       w_m321_input12  <= x"F0000FFF";
       w_m321_input13  <= x"F000FFFF";
       w_m321_input14  <= x"F00FFFFF";
       w_m321_input15  <= x"F00F000F";
       w_m321_input16  <= x"F00F00FF";
       w_m321_input17  <= x"F00F0FFF";
       w_m321_input18  <= x"F00FFFFF";
       w_m321_input19  <= x"F0FFFFFF";
       w_m321_input20  <= x"FA00000F";
       w_m321_input21  <= x"FA0000FF";
       w_m321_input22  <= x"FA000FFF";
       w_m321_input23  <= x"FA00FFFF";
       w_m321_input24  <= x"FA0FFFFF";
       w_m321_input25  <= x"FA0F000F";
       w_m321_input26  <= x"FA0F00FF";
       w_m321_input27  <= x"FA0F0FFF";
       w_m321_input28  <= x"FA0FFFFF";
       w_m321_input29  <= x"FAFFFFFF";
       w_m321_input20  <= x"FAFFAAAA";
       w_m321_input31  <= x"AAAAAAAA";     
       w_m321_selection <= "00000";
       assert(w_m321_out = x"0000000F") report "Fail test 0" severity error;
       wait for 1 ns;

       w_m321_selection <= "11111";
       assert(w_m321_out = x"AAAAAAAA") report "Fail test 0" severity error;
       wait for 1 ns;
    end process;

	

end behaviour;