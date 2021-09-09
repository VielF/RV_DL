library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity top_detector is
    generic (
        NUMBER_FAULTS : integer := 7
    );
	port (
		i_clk : in std_logic;
		i_rst_n : in std_logic;
        ---- CORE_0 -----
        i_im_core0      : in std_logic_vector(31 downto 0);
        i_dm_core0      : in std_logic_vector(31 downto 0);
	    i_reg1_rd_core0 : in std_logic_vector(31 downto 0);
        i_reg2_rd_core0 : in std_logic_vector(31 downto 0);
        i_reg1_wr_core0 : in std_logic_vector(31 downto 0);
        i_pc_core0      : in std_logic_vector(31 downto 0);
        ---- CORE_1 -----
        i_im_core1      : in std_logic_vector(31 downto 0);
        i_dm_core1      : in std_logic_vector(31 downto 0);
	    i_reg1_rd_core1 : in std_logic_vector(31 downto 0);
        i_reg2_rd_core1 : in std_logic_vector(31 downto 0);
        i_reg1_wr_core1 : in std_logic_vector(31 downto 0);
        i_pc_core1      : in std_logic_vector(31 downto 0);
        MUX_IM_CTRL       : out std_logic;
        ---- SINGAL PROTECTION CONTROL -------
        o_RST_RV                    : out std_logic;
	o_MUX_IM_CTRL                          : out std_logic
        );
end top_detector;

architecture Behavioral of top_detector is
	constant c_ONE : std_logic := '1';
	signal w_COUNTER_COUNT_FAULTS_in         : std_logic_vector(3 downto 0);
    signal w_ENA_REG_MUX_IM_CTRL_out         : std_logic;
    signal w_ENA_COUNTER_COUNT_FAULTS_out    : std_logic;
begin    
    u_REG_FAULT : entity work.counter
    generic map(
		SIZE => 4
	)
	port map(
		i_clk       => i_clk,
		i_rst_n     => i_rst_n,
		i_ena_count => w_ENA_COUNTER_COUNT_FAULTS_out,
		o_counter   => w_COUNTER_COUNT_FAULTS_in
	);
    u_REG_MUX : entity work.reg_1b
    port map (
        i_clk => i_clk,
        i_rst_n => i_rst_n,
        i_ena => w_ENA_REG_MUX_IM_CTRL_out,
        i_din => c_ONE,
        o_dout => o_MUX_IM_CTRL
    );
    u_DETECTOR : entity work.detector 
    generic map (
        NUMBER_FAULTS => 7
    )
    port map (
        i_clk           => i_clk,
        i_rst_n         => i_rst_n,
        i_im_core0      => i_im_core0,
        i_dm_core0      => i_dm_core0,
        i_reg1_rd_core0 => i_reg1_rd_core0,
        i_reg2_rd_core0 => i_reg2_rd_core0,
        i_reg1_wr_core0 => i_reg1_wr_core0,
        i_pc_core0      => i_pc_core0,
        ---- CORE_1 ---- 
        i_im_core1      => i_im_core1,
        i_dm_core1      => i_dm_core1,
        i_reg1_rd_core1 => i_reg1_rd_core1,
        i_reg2_rd_core1 => i_reg2_rd_core1,
        i_reg1_wr_core1 => i_reg1_wr_core1,
        i_pc_core1      => i_pc_core1,
        ---- SINGAL PROTECTION CONTROL -------
        i_COUNTER_COUNT_FAULTS      => w_COUNTER_COUNT_FAULTS_in, 
        o_RST_RV                    => o_RST_RV,
        o_ENA_REG_MUX_IM_CTRL       => w_ENA_REG_MUX_IM_CTRL_out,
        o_ENA_COUNTER_COUNT_FAULTS  => w_ENA_COUNTER_COUNT_FAULTS_out
    );
end architecture Behavioral;