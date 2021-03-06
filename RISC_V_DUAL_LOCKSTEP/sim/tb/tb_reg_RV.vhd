-- This testbench test all reg from RISC-V core

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.TEXTIO.all;
use work.all;

entity tb_reg_RV is
end tb_reg_RV; 

architecture behaviour of tb_reg_RV is

    signal w_reg1b_reg_in     : std_logic   := '1';
    signal w_reg1b_load       : std_logic   := '0';
    signal w_reg1b_out        : std_logic;

    signal w_reg2b_reg_in     : std_logic_vector (1 downto 0) := "01";
    signal w_reg2b_load       : std_logic   := '0';
    signal w_reg2b_out        : std_logic_vector (1 downto 0);

    signal w_reg3b_reg_in     : std_logic_vector (2 downto 0) := "001";
    signal w_reg3b_load       : std_logic   := '0';
    signal w_reg3b_out        : std_logic_vector (2 downto 0);

    signal w_reg4b_reg_in     : std_logic_vector (3 downto 0) := "0001";
    signal w_reg4b_load       : std_logic   := '0';
    signal w_reg4b_out        : std_logic_vector (3 downto 0);

    signal w_reg5b_reg_in     : std_logic_vector (4 downto 0) := "00001";
    signal w_reg5b_load       : std_logic   := '0';
    signal w_reg5b_out        : std_logic_vector (4 downto 0);

    signal w_reg32bfe_reg_in     : std_logic_vector (31 downto 0) := x"00000001";
    signal w_reg32bfe_load       : std_logic   := '0';
    signal w_reg32bfe_out        : std_logic_vector (31 downto 0);

    signal w_reg32b_reg_in     : std_logic_vector (31 downto 0) := x"00000001";
    signal w_reg32b_load       : std_logic   := '0';
    signal w_reg32b_out        : std_logic_vector (31 downto 0);
    

    signal clk                      : std_logic := '0';			-- Clock
    signal rst                      : std_logic := '1';			-- Reset
    constant clock_period           : integer := 20;
    constant clock_frequency        : real    := real(125*1000000);

   
begin

-- clock and reset

    clk   <= not clk after clock_period/2 * 1 ns; -- 
    rst   <= '0' after real(clock_period)*4.0 * 1 ns; -- release reset after 4 clock cycles

    DUT_reg1b : entity work.reg1b
        port map(
            reg_in  => w_reg1b_reg_in,
            load    => w_reg1b_load,
            clock   => clk, 
            clear   => rst,
            reg_out => w_reg1b_out
        );


    DUT_reg2b : entity work.reg2b
        port map(
            reg_in  => w_reg2b_reg_in,
            load    => w_reg2b_load,
            clock   => clk, 
            clear   => rst,
            reg_out => w_reg2b_out
        );


    DUT_reg3b : entity work.reg3b
        port map(
            reg_in  => w_reg3b_reg_in,
            load    => w_reg3b_load,
            clock   => clk, 
            clear   => rst,
            reg_out => w_reg3b_out
        );

    DUT_reg4b : entity work.reg4b
        port map(
            reg_in  => w_reg4b_reg_in,
            load    => w_reg4b_load,
            clock   => clk, 
            clear   => rst,
            reg_out => w_reg4b_out
        );
    
    DUT_reg5b : entity work.reg5b
        port map(
            reg_in  => w_reg5b_reg_in,
            load    => w_reg5b_load,
            clock   => clk, 
            clear   => rst,
            reg_out => w_reg5b_out
        );
    
    DUT_reg32falling : entity work.reg32b_falling_edge
        port map(
            reg_in  => w_reg32bfe_reg_in,
            load    => w_reg32bfe_load,
            clock   => clk, 
            clear   => rst,
            reg_out => w_reg32bfe_out
        );

    DUT_reg32 : entity work.reg32b
        port map(
            reg_in  => w_reg32b_reg_in,
            load    => w_reg32b_load,
            clock   => clk, 
            clear   => rst,
            reg_out => w_reg32b_out
        );


    tb_process : process 
    begin
       wait for 1 ns;

       w_reg1b_load <= '0';
       w_reg2b_load <= '0';
       w_reg3b_load <= '0';
       w_reg4b_load <= '0';
       w_reg5b_load <= '0';
       w_reg32bfe_load <= '0';
       w_reg32b_load <= '0';
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_reg1b_out = '0') report "Fail test 1" severity error;
       assert(w_reg2b_out = "00") report "Fail test 2" severity error;
       assert(w_reg3b_out = "000") report "Fail test 3" severity error;
       assert(w_reg4b_out = "0000") report "Fail test 4" severity error;
       assert(w_reg5b_out = "00000") report "Fail test 5" severity error;
       assert(w_reg32bfe_out = x"00000000") report "Fail test 6" severity error;
       assert(w_reg32b_out = x"00000000") report "Fail test 7" severity error;

       wait for real(clock_period)*1.0 * 1 ns;

       w_reg1b_load <= '1';
       w_reg2b_load <= '1';
       w_reg3b_load <= '1';
       w_reg4b_load <= '1';
       w_reg5b_load <= '1';
       w_reg32bfe_load <= '1';
       w_reg32b_load <= '1';
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_reg1b_out = '1') report "Fail test 8" severity error;
       assert(w_reg2b_out = "01") report "Fail test 9" severity error;
       assert(w_reg3b_out = "001") report "Fail test 10" severity error;
       assert(w_reg4b_out = "0001") report "Fail test 11" severity error;
       assert(w_reg5b_out = "00001") report "Fail test 12" severity error;
       assert(w_reg32bfe_out = x"00000001") report "Fail test 13" severity error;
       assert(w_reg32b_out = x"00000001") report "Fail test 14" severity error;
    end process;

end behaviour;