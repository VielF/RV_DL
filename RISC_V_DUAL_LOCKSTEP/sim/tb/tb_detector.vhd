library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.TEXTIO.all;
use work.all;

entity tb_detector is
end tb_detector; 

architecture behaviour of tb_detector is

    signal clk                      : std_logic := '0';			-- Clock
    signal rst                      : std_logic := '0';			-- Reset
    constant clock_period           : integer := 20;
    constant clock_frequency        : real    := real(125*1000000);

    signal w_im_core0_in                   : std_logic_vector(31 downto 0) := x"00000000";
    signal w_dm_core0_in                   : std_logic_vector(31 downto 0) := x"00000000";
    signal w_reg1_rd_core0_in              : std_logic_vector(31 downto 0) := x"00000000";
    signal w_reg2_rd_core0_in              : std_logic_vector(31 downto 0) := x"00000000";
    signal w_reg1_wr_core0_in              : std_logic_vector(31 downto 0) := x"00000000";
    signal w_pc_core0_in                   : std_logic_vector(31 downto 0) := x"00000000";

    signal w_im_core1_in                   : std_logic_vector(31 downto 0) := x"00000000";
    signal w_dm_core1_in                   : std_logic_vector(31 downto 0) := x"00000000";
    signal w_reg1_rd_core1_in              : std_logic_vector(31 downto 0) := x"00000000";
    signal w_reg2_rd_core1_in              : std_logic_vector(31 downto 0) := x"00000000";
    signal w_reg1_wr_core1_in              : std_logic_vector(31 downto 0) := x"00000000";
    signal w_pc_core1_in                   : std_logic_vector(31 downto 0) := x"00000000";


    signal w_COUNTER_COUNT_FAULTS_in         : std_logic_vector (3 downto 0) := x"0";
    signal w_RST_RV_out                      : std_logic;
    signal w_ENA_REG_MUX_IM_CTRL_out         : std_logic;
    signal w_ENA_COUNTER_COUNT_FAULTS_out    : std_logic;
   
begin

-- clock and reset

    clk   <= not clk after clock_period/2 * 1 ns; -- 
    rst   <= '1' after real(clock_period)*4.0 * 1 ns; -- release reset after 4 clock cycles

    DUT_DETECTOR: entity work.detector 
    generic map (
        NUMBER_FAULTS => 7
    )
    port map (
        i_clk           => clk,
        i_rst_n         => rst,

        i_im_core0      => w_im_core0_in     ,
        i_dm_core0      => w_dm_core0_in     ,
        i_reg1_rd_core0 => w_reg1_rd_core0_in,
        i_reg2_rd_core0 => w_reg2_rd_core0_in,
        i_reg1_wr_core0 => w_reg1_wr_core0_in,
        i_pc_core0      => w_pc_core0_in     ,
    
        ---- CORE_1 ---- 
        i_im_core1      => w_im_core1_in     ,
        i_dm_core1      => w_dm_core1_in     ,
        i_reg1_rd_core1 => w_reg1_rd_core1_in,
        i_reg2_rd_core1 => w_reg2_rd_core1_in,
        i_reg1_wr_core1 => w_reg1_wr_core1_in,
        i_pc_core1      => w_pc_core1_in     ,

        ---- SINGAL PROTECTION CONTROL -------
        i_COUNTER_COUNT_FAULTS      => w_COUNTER_COUNT_FAULTS_in     , 
        o_RST_RV                    => w_RST_RV_out                  ,
        o_ENA_REG_MUX_IM_CTRL       => w_ENA_REG_MUX_IM_CTRL_out     ,
        o_ENA_COUNTER_COUNT_FAULTS  => w_ENA_COUNTER_COUNT_FAULTS_out
    );


    tb_process : process 
    begin
        w_im_core0_in <= x"00000000";    
        w_dm_core0_in <= x"00000000";    
        w_reg1_rd_core0_in <= x"00000000";
        w_reg2_rd_core0_in <= x"00000000";
        w_reg1_wr_core0_in <= x"00000000";
        w_pc_core0_in <= x"00000000";

        w_im_core1_in <= x"00000000";     
        w_dm_core1_in <= x"00000000";     
        w_reg1_rd_core1_in <= x"00000000";
        w_reg2_rd_core1_in <= x"00000000";
        w_reg1_wr_core1_in <= x"00000000";
        w_pc_core1_in <= x"00000000"; 
        
        w_COUNTER_COUNT_FAULTS_in <= x"0";
        wait for real(clock_period)*4.0 * 1 ns;
        assert(w_RST_RV_out = '0' or 
               w_ENA_REG_MUX_IM_CTRL_out = '0' or 
               w_ENA_COUNTER_COUNT_FAULTS_out = '0') report "Fail test basic" severity error;

        w_im_core0_in <= x"00000001";    
        w_dm_core0_in <= x"00000000";    
        w_reg1_rd_core0_in <= x"00000000";
        w_reg2_rd_core0_in <= x"00000000";
        w_reg1_wr_core0_in <= x"00000000";
        w_pc_core0_in <= x"00000000";

        w_im_core1_in <= x"00000000";     
        w_dm_core1_in <= x"00000000";     
        w_reg1_rd_core1_in <= x"00000000";
        w_reg2_rd_core1_in <= x"00000000";
        w_reg1_wr_core1_in <= x"00000000";
        w_pc_core1_in <= x"00000000"; 
        
        w_COUNTER_COUNT_FAULTS_in <= x"0";
        wait for real(clock_period)*4.0 * 1 ns;
        assert(w_RST_RV_out = '1' or 
               w_ENA_REG_MUX_IM_CTRL_out = '0' or 
               w_ENA_COUNTER_COUNT_FAULTS_out = '1') report "Fail test basic IM" severity error;

        w_im_core0_in <= x"00000000";    
        w_dm_core0_in <= x"00000001";    
        w_reg1_rd_core0_in <= x"00000000";
        w_reg2_rd_core0_in <= x"00000000";
        w_reg1_wr_core0_in <= x"00000000";
        w_pc_core0_in <= x"00000000";

        w_im_core1_in <= x"00000000";     
        w_dm_core1_in <= x"00000000";     
        w_reg1_rd_core1_in <= x"00000000";
        w_reg2_rd_core1_in <= x"00000000";
        w_reg1_wr_core1_in <= x"00000000";
        w_pc_core1_in <= x"00000000"; 
        
        w_COUNTER_COUNT_FAULTS_in <= x"0";
        wait for real(clock_period)*4.0 * 1 ns;
        assert(w_RST_RV_out = '1' or 
               w_ENA_REG_MUX_IM_CTRL_out = '0' or 
               w_ENA_COUNTER_COUNT_FAULTS_out = '0') report "Fail test DM" severity error;
        
        w_im_core0_in <= x"00000000";    
        w_dm_core0_in <= x"00000000";    
        w_reg1_rd_core0_in <= x"00000001";
        w_reg2_rd_core0_in <= x"00000000";
        w_reg1_wr_core0_in <= x"00000000";
        w_pc_core0_in <= x"00000000";

        w_im_core1_in <= x"00000000";     
        w_dm_core1_in <= x"00000000";     
        w_reg1_rd_core1_in <= x"00000000";
        w_reg2_rd_core1_in <= x"00000000";
        w_reg1_wr_core1_in <= x"00000000";
        w_pc_core1_in <= x"00000000"; 
        
        w_COUNTER_COUNT_FAULTS_in <= x"0";
        wait for real(clock_period)*4.0 * 1 ns;
        assert(w_RST_RV_out = '1' or 
               w_ENA_REG_MUX_IM_CTRL_out = '0' or 
               w_ENA_COUNTER_COUNT_FAULTS_out = '0') report "Fail test REG1_RD" severity error;

        
        w_im_core0_in <= x"00000000";    
        w_dm_core0_in <= x"00000000";    
        w_reg1_rd_core0_in <= x"00000000";
        w_reg2_rd_core0_in <= x"00000001";
        w_reg1_wr_core0_in <= x"00000000";
        w_pc_core0_in <= x"00000000";

        w_im_core1_in <= x"00000000";     
        w_dm_core1_in <= x"00000000";     
        w_reg1_rd_core1_in <= x"00000000";
        w_reg2_rd_core1_in <= x"00000000";
        w_reg1_wr_core1_in <= x"00000000";
        w_pc_core1_in <= x"00000000"; 
        
        w_COUNTER_COUNT_FAULTS_in <= x"0";
        wait for real(clock_period)*4.0 * 1 ns;
        assert(w_RST_RV_out = '1' or 
               w_ENA_REG_MUX_IM_CTRL_out = '0' or 
               w_ENA_COUNTER_COUNT_FAULTS_out = '0') report "Fail test REG2_RD" severity error;


        w_im_core0_in <= x"00000000";    
        w_dm_core0_in <= x"00000000";    
        w_reg1_rd_core0_in <= x"00000000";
        w_reg2_rd_core0_in <= x"00000000";
        w_reg1_wr_core0_in <= x"00000001";
        w_pc_core0_in <= x"00000000";

        w_im_core1_in <= x"00000000";     
        w_dm_core1_in <= x"00000000";     
        w_reg1_rd_core1_in <= x"00000000";
        w_reg2_rd_core1_in <= x"00000000";
        w_reg1_wr_core1_in <= x"00000000";
        w_pc_core1_in <= x"00000000"; 
        
        w_COUNTER_COUNT_FAULTS_in <= x"0";
        wait for real(clock_period)*4.0 * 1 ns;
        assert(w_RST_RV_out = '1' or 
               w_ENA_REG_MUX_IM_CTRL_out = '0' or 
               w_ENA_COUNTER_COUNT_FAULTS_out = '0') report "Fail test REG1_WR" severity error;

        
        w_im_core0_in <= x"00000000";    
        w_dm_core0_in <= x"00000000";    
        w_reg1_rd_core0_in <= x"00000000";
        w_reg2_rd_core0_in <= x"00000000";
        w_reg1_wr_core0_in <= x"00000000";
        w_pc_core0_in <= x"00000001";

        w_im_core1_in <= x"00000000";     
        w_dm_core1_in <= x"00000000";     
        w_reg1_rd_core1_in <= x"00000000";
        w_reg2_rd_core1_in <= x"00000000";
        w_reg1_wr_core1_in <= x"00000000";
        w_pc_core1_in <= x"00000000"; 
        
        w_COUNTER_COUNT_FAULTS_in <= x"0";
        wait for real(clock_period)*4.0 * 1 ns;
        assert(w_RST_RV_out = '1' or 
               w_ENA_REG_MUX_IM_CTRL_out = '0' or 
               w_ENA_COUNTER_COUNT_FAULTS_out = '0') report "Fail test REG1_PC" severity error;

        w_im_core0_in <= x"00000001";    
        w_dm_core0_in <= x"00000000";    
        w_reg1_rd_core0_in <= x"00000000";
        w_reg2_rd_core0_in <= x"00000000";
        w_reg1_wr_core0_in <= x"00000000";
        w_pc_core0_in <= x"00000000";

        w_im_core1_in <= x"00000000";     
        w_dm_core1_in <= x"00000000";     
        w_reg1_rd_core1_in <= x"00000000";
        w_reg2_rd_core1_in <= x"00000000";
        w_reg1_wr_core1_in <= x"00000000";
        w_pc_core1_in <= x"00000000"; 
        
        w_COUNTER_COUNT_FAULTS_in <= x"7";
        wait for real(clock_period)*4.0 * 1 ns;
        assert(w_RST_RV_out = '1' or 
               w_ENA_REG_MUX_IM_CTRL_out = '0' or 
               w_ENA_COUNTER_COUNT_FAULTS_out = '0') report "Fail test IM complete" severity error;


    end process;

	

end behaviour;