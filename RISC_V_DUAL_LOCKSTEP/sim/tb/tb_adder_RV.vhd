library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.TEXTIO.all;
use work.all;

entity tb_adder_RV is
end tb_adder_RV; 

architecture behaviour of tb_adder_RV is

    constant clock_period           : integer := 10;

    signal w_aclk : std_logic;
    signal w_s_axis_a_tvalid : std_logic;
    signal w_s_axis_a_tready : std_logic;
    signal w_s_axis_a_tdata   : std_logic_vector(31 downto 0);
    signal w_s_axis_b_tvalid  : std_logic;
    signal w_s_axis_b_tready : std_logic;
    signal w_s_axis_b_tdata   : std_logic_vector(31 downto 0);
    signal w_m_axis_result_tvalid : std_logic;
    signal w_m_axis_result_tready : std_logic;
    signal w_m_axis_result_tdata   : std_logic_vector(31 downto 0);

    component fpu_test 
    port (   aclk : in STD_LOGIC;
             s_axis_a_tvalid : in STD_LOGIC;
             s_axis_a_tready : out STD_LOGIC;
             s_axis_a_tdata : in std_logic_vector(31 downto 0);
             s_axis_b_tvalid : in STD_LOGIC;
             s_axis_b_tready : out STD_LOGIC;
             s_axis_b_tdata : in std_logic_vector(31 downto 0);
             m_axis_result_tvalid : out STD_LOGIC;
             m_axis_result_tready : in STD_LOGIC;
             m_axis_result_tdata : out std_logic_vector(31 downto 0)
    );
end component;

  
begin

-- clock and reset

    DUT_mux: fpu_test 
    port map (
      aclk            => w_aclk,
      s_axis_a_tvalid => w_s_axis_a_tvalid,
      s_axis_a_tready => w_s_axis_a_tready,
      s_axis_a_tdata  => w_s_axis_a_tdata,
      s_axis_b_tvalid => w_s_axis_b_tvalid,
      s_axis_b_tready => w_s_axis_b_tready,
      s_axis_b_tdata  => w_s_axis_b_tdata,
      m_axis_result_tvalid => w_m_axis_result_tvalid,
      m_axis_result_tready => w_m_axis_result_tready,
      m_axis_result_tdata  => w_m_axis_result_tdata
    );

    w_aclk   <= not clk after clock_period/2 * 1 ns; -- 
    --rst   <= '1' after real(clock_period)*4.0 * 1 ns; -- release reset after 4 clock cycles

    tb_process : process 
    begin
       wait for 1 ns;

       w_s_axis_a_tvalid  <= '1';
       w_s_axis_a_tdata   <= x"404ccccd";
       w_s_axis_b_tvalid  <= '1';
       w_s_axis_a_tdata   <= x"3fe66666";
       w_m_axis_result_tready <= '0';
       wait for 120 ns;
       --wait for (w_m_axis_result_tvalid = '1');
       w_m_axis_result_tready <= '1';
       assert(w_m_axis_result_tvalid = '1') report "Fail test 0" severity error;
       assert(w_m_axis_result_tdata = x"40a00000") report "Fail test 0" severity error;
       

       w_input_0 <= x"00000100";
       w_input_1 <= x"00000100";
       assert(w_output_0 = x"00001000") report "Fail test 1" severity error;
       wait for 1 ns;


    end process;

	

end behaviour;