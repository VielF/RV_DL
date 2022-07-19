library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.TEXTIO.all;
use work.all;

entity tb_RV_DL is
end tb_RV_DL; 

architecture behaviour of tb_RV_DL is

    constant clock_period           : integer := 10;

    signal w_aclk : std_logic := '0';
    signal w_rst_n       : std_logic := '0';
    -------- TO DEBUG ---------------
    ---- FAULT
    signal w_FAULT_INJECTION_SIM_RV0     : std_logic_vector(2 downto 0);
    signal w_FAULT_INJECTION_SIM_RV1     : std_logic_vector(2 downto 0);
    ---- CORE_0 -----
    signal w_debug_im_core0_debug        :  std_logic_vector(31 downto 0);
    signal w_debug_dm_core0_debug        :  std_logic_vector(31 downto 0);
    signal w_debug_reg1_rd_core0_debug   :  std_logic_vector(31 downto 0);
    signal w_debug_reg2_rd_core0_debug   :  std_logic_vector(31 downto 0);
    signal w_debug_reg1_wr_core0_debug   :  std_logic_vector(31 downto 0);
    signal w_debug_pc_core0_debug        :  std_logic_vector(31 downto 0);
    ---- CORE_1 -----
    signal w_debug_im_core1_debug        :  std_logic_vector(31 downto 0);
    signal w_debug_dm_core1_debug        :  std_logic_vector(31 downto 0);
    signal w_debug_reg1_rd_core1_debug   :  std_logic_vector(31 downto 0);
    signal w_debug_reg2_rd_core1_debug   :  std_logic_vector(31 downto 0);
    signal w_debug_reg1_wr_core1_debug   :  std_logic_vector(31 downto 0);
    signal w_debug_pc_core1_debug        :  std_logic_vector(31 downto 0);
    ---- SINGAL PROTECTION CONTROL ----
    signal w_debug_RST_RV_debug          :  std_logic;
    signal w_debug_MUX_IM_CTRL_debug     :  std_logic;  
    

    component RV_DL
        generic (
            NUMBER_FAULTS : integer := 7
        );
        port (
            i_clk : in std_logic;
            i_rst_n : in std_logic;
            -------- TO DEBUG ---------------
            ---- FAULT
            i_FAULT_INJECTION_SIM_RV0   : in std_logic_vector(2 downto 0);
            i_FAULT_INJECTION_SIM_RV1   : in std_logic_vector(2 downto 0);
            ---- CORE_0 -----
            o_debug_im_core0_debug        : out std_logic_vector(31 downto 0);
            o_debug_dm_core0_debug        : out std_logic_vector(31 downto 0);
            o_debug_reg1_rd_core0_debug   : out std_logic_vector(31 downto 0);
            o_debug_reg2_rd_core0_debug   : out std_logic_vector(31 downto 0);
            o_debug_reg1_wr_core0_debug   : out std_logic_vector(31 downto 0);
            o_debug_pc_core0_debug        : out std_logic_vector(31 downto 0);
            ---- CORE_1 -----
            o_debug_im_core1_debug        : out std_logic_vector(31 downto 0);
            o_debug_dm_core1_debug        : out std_logic_vector(31 downto 0);
            o_debug_reg1_rd_core1_debug   : out std_logic_vector(31 downto 0);
            o_debug_reg2_rd_core1_debug   : out std_logic_vector(31 downto 0);
            o_debug_reg1_wr_core1_debug   : out std_logic_vector(31 downto 0);
            o_debug_pc_core1_debug        : out std_logic_vector(31 downto 0);
            ---- SINGAL PROTECTION CONTROL -------
            o_debug_RST_RV_debug          : out std_logic;
            o_debug_MUX_IM_CTRL_debug     : out std_logic
            );
    end component;

  
begin

    -- clock and reset
    w_aclk   <= not w_aclk after clock_period/2 * 1 ns; -- 
    --w_rst_n   <= '1' after real(clock_period)*4.0 * 1 ns; -- release reset after 4 clock cycles

    DUT_mux: RV_DL
    generic map(
        NUMBER_FAULTS => 7
    )
    port map(
        i_clk                         => w_aclk,
        i_rst_n                       => w_rst_n,
        -------- TO DEBUG -----------
        ---- FAULT
        i_FAULT_INJECTION_SIM_RV0     => w_FAULT_INJECTION_SIM_RV0,
        i_FAULT_INJECTION_SIM_RV1     => w_FAULT_INJECTION_SIM_RV1,
        ---- CORE_0 -----
        o_debug_im_core0_debug        => w_debug_im_core0_debug     ,
        o_debug_dm_core0_debug        => w_debug_dm_core0_debug     ,
        o_debug_reg1_rd_core0_debug   => w_debug_reg1_rd_core0_debug,
        o_debug_reg2_rd_core0_debug   => w_debug_reg2_rd_core0_debug,
        o_debug_reg1_wr_core0_debug   => w_debug_reg1_wr_core0_debug,
        o_debug_pc_core0_debug        => w_debug_pc_core0_debug     ,
        ---- CORE_1 -----
        o_debug_im_core1_debug        => w_debug_im_core1_debug     ,
        o_debug_dm_core1_debug        => w_debug_dm_core1_debug     ,
        o_debug_reg1_rd_core1_debug   => w_debug_reg1_rd_core1_debug,
        o_debug_reg2_rd_core1_debug   => w_debug_reg2_rd_core1_debug,
        o_debug_reg1_wr_core1_debug   => w_debug_reg1_wr_core1_debug,
        o_debug_pc_core1_debug        => w_debug_pc_core1_debug     ,
        ---- SINGAL PROTECTION CONTROL 
        o_debug_RST_RV_debug          => w_debug_RST_RV_debug     ,
        o_debug_MUX_IM_CTRL_debug     => w_debug_MUX_IM_CTRL_debug
    );

    tb_process : process 
    begin
       w_rst_n   <= '0';
       wait for real(clock_period)*4.0 * 1 ns;
       w_rst_n   <= '1';
       wait for real(clock_period)*4.0 * 1 ns;
       
       ---- 5 cycles of instruction
       ---- Test without fail
       w_FAULT_INJECTION_SIM_RV0 <= "000";
       w_FAULT_INJECTION_SIM_RV1 <= "000";
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_im_core0_debug /= w_debug_im_core1_debug) report "Fail test im_core NFJ test" severity error;
       assert(w_debug_dm_core0_debug /= w_debug_dm_core1_debug) report "Fail test dm_core NFJ test" severity error;
       assert(w_debug_reg1_rd_core0_debug /= w_debug_reg1_rd_core1_debug) report "Fail test reg1_rd_core NFJ test" severity error; 
       assert(w_debug_reg2_rd_core0_debug /= w_debug_reg2_rd_core1_debug) report "Fail test reg2_rd_core NFJ test" severity error;
       assert(w_debug_reg1_wr_core0_debug /= w_debug_reg1_wr_core1_debug) report "Fail test reg1_wr_core NFJ test" severity error;
       assert(w_debug_pc_core0_debug /= w_debug_pc_core1_debug) report "Fail test pc_core NFJ test" severity error;
       assert(w_debug_RST_RV_debug = '0') report "Fail test reset NFJ test" severity error;
       assert(w_debug_MUX_IM_CTRL_debug = '0') report "Fail test IM backup NFJ test" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_im_core0_debug /= w_debug_im_core1_debug) report "Fail test im_core NFJ test" severity error;
       assert(w_debug_dm_core0_debug /= w_debug_dm_core1_debug) report "Fail test dm_core NFJ test" severity error;
       assert(w_debug_reg1_rd_core0_debug /= w_debug_reg1_rd_core1_debug) report "Fail test reg1_rd_core NFJ test" severity error; 
       assert(w_debug_reg2_rd_core0_debug /= w_debug_reg2_rd_core1_debug) report "Fail test reg2_rd_core NFJ test" severity error;
       assert(w_debug_reg1_wr_core0_debug /= w_debug_reg1_wr_core1_debug) report "Fail test reg1_wr_core NFJ test" severity error;
       assert(w_debug_pc_core0_debug /= w_debug_pc_core1_debug) report "Fail test pc_core NFJ test" severity error;
       assert(w_debug_RST_RV_debug = '0') report "Fail test reset NFJ test" severity error;
       assert(w_debug_MUX_IM_CTRL_debug = '0') report "Fail test IM backup NFJ test" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_im_core0_debug /= w_debug_im_core1_debug) report "Fail test im_core NFJ test" severity error;
       assert(w_debug_dm_core0_debug /= w_debug_dm_core1_debug) report "Fail test dm_core NFJ test" severity error;
       assert(w_debug_reg1_rd_core0_debug /= w_debug_reg1_rd_core1_debug) report "Fail test reg1_rd_core NFJ test" severity error; 
       assert(w_debug_reg2_rd_core0_debug /= w_debug_reg2_rd_core1_debug) report "Fail test reg2_rd_core NFJ test" severity error;
       assert(w_debug_reg1_wr_core0_debug /= w_debug_reg1_wr_core1_debug) report "Fail test reg1_wr_core NFJ test" severity error;
       assert(w_debug_pc_core0_debug /= w_debug_pc_core1_debug) report "Fail test pc_core NFJ test" severity error;
       assert(w_debug_RST_RV_debug = '0') report "Fail test reset NFJ test" severity error;
       assert(w_debug_MUX_IM_CTRL_debug = '0') report "Fail test IM backup NFJ test" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_im_core0_debug /= w_debug_im_core1_debug) report "Fail test im_core NFJ test" severity error;
       assert(w_debug_dm_core0_debug /= w_debug_dm_core1_debug) report "Fail test dm_core NFJ test" severity error;
       assert(w_debug_reg1_rd_core0_debug /= w_debug_reg1_rd_core1_debug) report "Fail test reg1_rd_core NFJ test" severity error; 
       assert(w_debug_reg2_rd_core0_debug /= w_debug_reg2_rd_core1_debug) report "Fail test reg2_rd_core NFJ test" severity error;
       assert(w_debug_reg1_wr_core0_debug /= w_debug_reg1_wr_core1_debug) report "Fail test reg1_wr_core NFJ test" severity error;
       assert(w_debug_pc_core0_debug /= w_debug_pc_core1_debug) report "Fail test pc_core NFJ test" severity error;
       assert(w_debug_RST_RV_debug = '0') report "Fail test reset NFJ test" severity error;
       assert(w_debug_MUX_IM_CTRL_debug = '0') report "Fail test IM backup NFJ test" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_im_core0_debug /= w_debug_im_core1_debug) report "Fail test im_core NFJ test" severity error;
       assert(w_debug_dm_core0_debug /= w_debug_dm_core1_debug) report "Fail test dm_core NFJ test" severity error;
       assert(w_debug_reg1_rd_core0_debug /= w_debug_reg1_rd_core1_debug) report "Fail test reg1_rd_core NFJ test" severity error; 
       assert(w_debug_reg2_rd_core0_debug /= w_debug_reg2_rd_core1_debug) report "Fail test reg2_rd_core NFJ test" severity error;
       assert(w_debug_reg1_wr_core0_debug /= w_debug_reg1_wr_core1_debug) report "Fail test reg1_wr_core NFJ test" severity error;
       assert(w_debug_pc_core0_debug /= w_debug_pc_core1_debug) report "Fail test pc_core NFJ test" severity error;
       assert(w_debug_RST_RV_debug = '0') report "Fail test reset NFJ test" severity error;
       assert(w_debug_MUX_IM_CTRL_debug = '0') report "Fail test IM backup NFJ test" severity error;
       

       ---- 5 cycles of instruction
       ---- Test fail IM
       w_FAULT_INJECTION_SIM_RV0 <= "001";
       w_FAULT_INJECTION_SIM_RV1 <= "000";
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_im_core0_debug = w_debug_im_core1_debug) report "Fail test im_core FJ test - 1" severity error;
       assert(w_debug_RST_RV_debug = '1') report "Fail test reset NFJ test" severity error;
       assert(w_debug_MUX_IM_CTRL_debug = '0') report "Fail test IM backup NFJ test" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_im_core0_debug = w_debug_im_core1_debug) report "Fail test im_core FJ test - 1" severity error;
       assert(w_debug_RST_RV_debug = '1') report "Fail test reset NFJ test" severity error;
       assert(w_debug_MUX_IM_CTRL_debug = '0') report "Fail test IM backup NFJ test" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_im_core0_debug = w_debug_im_core1_debug) report "Fail test im_core FJ test - 1" severity error;
       assert(w_debug_RST_RV_debug = '1') report "Fail test reset NFJ test" severity error;
       assert(w_debug_MUX_IM_CTRL_debug = '0') report "Fail test IM backup NFJ test" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_im_core0_debug = w_debug_im_core1_debug) report "Fail test im_core FJ test - 1" severity error;
       assert(w_debug_RST_RV_debug = '1') report "Fail test reset NFJ test" severity error;
       assert(w_debug_MUX_IM_CTRL_debug = '0') report "Fail test IM backup NFJ test" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_im_core0_debug = w_debug_im_core1_debug) report "Fail test im_core FJ test - 1" severity error;
       assert(w_debug_RST_RV_debug = '1') report "Fail test reset NFJ test" severity error;
       assert(w_debug_MUX_IM_CTRL_debug = '0') report "Fail test IM backup NFJ test" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_im_core0_debug = w_debug_im_core1_debug) report "Fail test im_core FJ test - 1" severity error;
       assert(w_debug_RST_RV_debug = '1') report "Fail test reset NFJ test" severity error;
       assert(w_debug_MUX_IM_CTRL_debug = '0') report "Fail test IM backup NFJ test" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_im_core0_debug = w_debug_im_core1_debug) report "Fail test im_core FJ test - 1" severity error;
       assert(w_debug_RST_RV_debug = '1') report "Fail test reset NFJ test" severity error;
       assert(w_debug_MUX_IM_CTRL_debug = '1') report "Fail test IM backup NFJ test" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_im_core0_debug = w_debug_im_core1_debug) report "Fail test im_core FJ test - 1" severity error;
       assert(w_debug_RST_RV_debug = '1') report "Fail test reset NFJ test" severity error;
       assert(w_debug_MUX_IM_CTRL_debug = '1') report "Fail test IM backup NFJ test" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_im_core0_debug = w_debug_im_core1_debug) report "Fail test im_core FJ test - 1" severity error;
       assert(w_debug_RST_RV_debug = '1') report "Fail test reset NFJ test" severity error;
       assert(w_debug_MUX_IM_CTRL_debug = '1') report "Fail test IM backup NFJ test" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_im_core0_debug = w_debug_im_core1_debug) report "Fail test im_core FJ test - 1" severity error;
       assert(w_debug_RST_RV_debug = '1') report "Fail test reset NFJ test" severity error;
       assert(w_debug_MUX_IM_CTRL_debug = '1') report "Fail test IM backup NFJ test" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_im_core0_debug = w_debug_im_core1_debug) report "Fail test im_core FJ test - 1" severity error;
       assert(w_debug_RST_RV_debug = '1') report "Fail test reset NFJ test" severity error;
       assert(w_debug_MUX_IM_CTRL_debug = '1') report "Fail test IM backup NFJ test" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_im_core0_debug = w_debug_im_core1_debug) report "Fail test im_core FJ test - 1" severity error;
       assert(w_debug_RST_RV_debug = '1') report "Fail test reset NFJ test" severity error;
       assert(w_debug_MUX_IM_CTRL_debug = '1') report "Fail test IM backup NFJ test" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_im_core0_debug = w_debug_im_core1_debug) report "Fail test im_core FJ test - 1" severity error;
       assert(w_debug_RST_RV_debug = '1') report "Fail test reset NFJ test" severity error;
       assert(w_debug_MUX_IM_CTRL_debug = '1') report "Fail test IM backup NFJ test" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_im_core0_debug = w_debug_im_core1_debug) report "Fail test im_core FJ test - 1" severity error;
       assert(w_debug_RST_RV_debug = '1') report "Fail test reset NFJ test" severity error;
       assert(w_debug_MUX_IM_CTRL_debug = '1') report "Fail test IM backup NFJ test" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_im_core0_debug = w_debug_im_core1_debug) report "Fail test im_core FJ test - 1" severity error;
       assert(w_debug_RST_RV_debug = '1') report "Fail test reset NFJ test" severity error;
       assert(w_debug_MUX_IM_CTRL_debug = '1') report "Fail test IM backup NFJ test" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_im_core0_debug = w_debug_im_core1_debug) report "Fail test im_core FJ test - 1" severity error;
       assert(w_debug_RST_RV_debug = '1') report "Fail test reset NFJ test" severity error;
       assert(w_debug_MUX_IM_CTRL_debug = '1') report "Fail test IM backup NFJ test" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_im_core0_debug = w_debug_im_core1_debug) report "Fail test im_core FJ test - 1" severity error;
       assert(w_debug_RST_RV_debug = '1') report "Fail test reset NFJ test" severity error;
       assert(w_debug_MUX_IM_CTRL_debug = '1') report "Fail test IM backup NFJ test" severity error;

       


       ---- 5 cycles of instruction
       ---- Test fail DM
       w_FAULT_INJECTION_SIM_RV0 <= "010";
       w_FAULT_INJECTION_SIM_RV1 <= "000";
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_dm_core0_debug = w_debug_dm_core1_debug) report "Fail test dm_core FJ test - 1" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_dm_core0_debug = w_debug_dm_core1_debug) report "Fail test dm_core FJ test - 1" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_dm_core0_debug = w_debug_dm_core1_debug) report "Fail test dm_core FJ test - 1" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_dm_core0_debug = w_debug_dm_core1_debug) report "Fail test dm_core FJ test - 1" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_dm_core0_debug = w_debug_dm_core1_debug) report "Fail test dm_core FJ test - 1" severity error;


       ---- 5 cycles of instruction
       ---- Test fail reg1_rd
       w_FAULT_INJECTION_SIM_RV0 <= "011";
       w_FAULT_INJECTION_SIM_RV1 <= "000";
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_reg1_rd_core0_debug = w_debug_reg1_rd_core1_debug) report "Fail test reg1_rd_core FJ test - 1" severity error; 
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_reg1_rd_core0_debug = w_debug_reg1_rd_core1_debug) report "Fail test reg1_rd_core FJ test - 1" severity error; 
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_reg1_rd_core0_debug = w_debug_reg1_rd_core1_debug) report "Fail test reg1_rd_core FJ test - 1" severity error; 
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_reg1_rd_core0_debug = w_debug_reg1_rd_core1_debug) report "Fail test reg1_rd_core FJ test - 1" severity error; 
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_reg1_rd_core0_debug = w_debug_reg1_rd_core1_debug) report "Fail test reg1_rd_core FJ test - 1" severity error; 


       ---- 5 cycles of instruction
       ---- Test fail reg2_rd
       w_FAULT_INJECTION_SIM_RV0 <= "011";
       w_FAULT_INJECTION_SIM_RV1 <= "000";
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_reg2_rd_core0_debug = w_debug_reg2_rd_core1_debug) report "Fail test reg2_rd_core FJ test - 1" severity error; 
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_reg2_rd_core0_debug = w_debug_reg2_rd_core1_debug) report "Fail test reg2_rd_core FJ test - 1" severity error; 
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_reg2_rd_core0_debug = w_debug_reg2_rd_core1_debug) report "Fail test reg2_rd_core FJ test - 1" severity error; 
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_reg2_rd_core0_debug = w_debug_reg2_rd_core1_debug) report "Fail test reg2_rd_core FJ test - 1" severity error; 
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_reg2_rd_core0_debug = w_debug_reg2_rd_core1_debug) report "Fail test reg2_rd_core FJ test - 1" severity error; 
       
      
       ---- 5 cycles of instruction
       ---- Test fail reg1_wr
       w_FAULT_INJECTION_SIM_RV0 <= "100";
       w_FAULT_INJECTION_SIM_RV1 <= "000";
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_reg1_wr_core0_debug /= w_debug_reg1_wr_core1_debug) report "Fail test reg1_wr_core FJ test - 1" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_reg1_wr_core0_debug /= w_debug_reg1_wr_core1_debug) report "Fail test reg1_wr_core FJ test - 1" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_reg1_wr_core0_debug /= w_debug_reg1_wr_core1_debug) report "Fail test reg1_wr_core FJ test - 1" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_reg1_wr_core0_debug /= w_debug_reg1_wr_core1_debug) report "Fail test reg1_wr_core FJ test - 1" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_reg1_wr_core0_debug /= w_debug_reg1_wr_core1_debug) report "Fail test reg1_wr_core FJ test - 1" severity error;
       
       
       ---- 5 cycles of instruction
       ---- Test fail pc_core
       w_FAULT_INJECTION_SIM_RV0 <= "101";
       w_FAULT_INJECTION_SIM_RV1 <= "000";
       wait for real(clock_period)*1.0 * 1 ns;
       assert((w_debug_dm_core0_debug = w_debug_dm_core1_debug) and (w_debug_pc_core0_debug = w_debug_pc_core1_debug)) report "Fail test dm_core and pc_core FJ test - 2" severity error;
       assert(w_debug_pc_core0_debug /= w_debug_pc_core1_debug) report "Fail test pc_core FJ test - 1" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_pc_core0_debug /= w_debug_pc_core1_debug) report "Fail test pc_core FJ test - 1" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_pc_core0_debug /= w_debug_pc_core1_debug) report "Fail test pc_core FJ test - 1" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_pc_core0_debug /= w_debug_pc_core1_debug) report "Fail test pc_core FJ test - 1" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_pc_core0_debug /= w_debug_pc_core1_debug) report "Fail test pc_core FJ test - 1" severity error;
       
       w_rst_n   <= '0';
       wait for real(clock_period)*1.0 * 1 ns;
       w_rst_n   <= '1';
       ---- 5 cycles of instruction
       ---- Test fail 
       w_FAULT_INJECTION_SIM_RV0 <= "101";
       w_FAULT_INJECTION_SIM_RV1 <= "010";
       wait for real(clock_period)*1.0 * 1 ns;
       assert((w_debug_dm_core0_debug = w_debug_dm_core1_debug) and (w_debug_pc_core0_debug = w_debug_pc_core1_debug)) report "Fail test dm_core and pc_core FJ test - 2" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert((w_debug_dm_core0_debug = w_debug_dm_core1_debug) and (w_debug_pc_core0_debug = w_debug_pc_core1_debug)) report "Fail test dm_core and pc_core FJ test - 2" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert((w_debug_dm_core0_debug = w_debug_dm_core1_debug) and (w_debug_pc_core0_debug = w_debug_pc_core1_debug)) report "Fail test dm_core and pc_core FJ test - 2" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert((w_debug_dm_core0_debug = w_debug_dm_core1_debug) and (w_debug_pc_core0_debug = w_debug_pc_core1_debug)) report "Fail test dm_core and pc_core FJ test - 2" severity error;
       wait for real(clock_period)*1.0 * 1 ns;
       assert((w_debug_dm_core0_debug = w_debug_dm_core1_debug) and (w_debug_pc_core0_debug = w_debug_pc_core1_debug)) report "Fail test dm_core and pc_core FJ test - 2" severity error;

       w_FAULT_INJECTION_SIM_RV0 <= "000";
       w_FAULT_INJECTION_SIM_RV1 <= "000";
       wait;


    end process;

	

end behaviour;