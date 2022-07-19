library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.TEXTIO.all;
use work.all;

entity tb_register_file_RV is
end tb_register_file_RV; 

architecture behaviour of tb_register_file_RV is

    signal clk                      : std_logic := '0';			-- Clock
    signal rst                      : std_logic := '1';			-- Reset
    constant clock_period           : integer := 20;
    constant clock_frequency        : real    := real(125*1000000);

    signal w_write_data      : std_logic_vector(31 downto 0) := x"00000000";
    signal w_write_address   : std_logic_vector(4 downto 0)  := "00000";
    signal w_read_address_0  : std_logic_vector(4 downto 0)  := "00000";
    signal w_read_address_1  : std_logic_vector(4 downto 0)  := "00000";
    signal w_write_control   : std_logic  := '0';
    signal w_clock           : std_logic  := '0' ;
    signal w_clear           : std_logic  := '0' ;
    signal w_output_data_0   : std_logic_vector(31 downto 0);
    signal w_output_data_1   : std_logic_vector(31 downto 0);
    signal w_debug_x31_output: std_logic_vector(31 downto 0);
    signal w_debug_x1_output : std_logic_vector(31 downto 0);
    signal w_debug_x2_output : std_logic_vector(31 downto 0);
   
begin

-- clock and reset

    clk   <= not clk after clock_period/2 * 1 ns; -- 
    rst   <= '0' after real(clock_period)*4.0 * 1 ns; -- release reset after 4 clock cycles

    DUT_DETECTOR: entity work.register_file
        port map(
            write_data       => w_write_data    , --: in std_logic_vector(31 downto 0);
            write_address    => w_write_address , --: in std_logic_vector(4 downto 0);
            read_address_0   => w_read_address_0, --: in std_logic_vector(4 downto 0);
            read_address_1   => w_read_address_1, --: in std_logic_vector(4 downto 0);
            write_control    => w_write_control , -- 
            clock            => clk, -- 
            clear            => rst, --: in std_logic;
            output_data_0    => w_output_data_0   , --: out std_logic_vector(31 downto 0);
            output_data_1    => w_output_data_1   , --: out std_logic_vector(31 downto 0);
            debug_x31_output => w_debug_x31_output, --: out std_logic_vector(31 downto 0);
            debug_x1_output  => w_debug_x1_output , --: out std_logic_vector(31 downto 0);
            debug_x2_output  => w_debug_x2_output  --: out std_logic_vector(31 downto 0)
        );


    tb_process : process 
    begin
       wait for real(clock_period)*4.0 * 1 ns;

       w_write_data      <= x"000000FF";   
       w_write_address   <= "00010";
       w_read_address_0  <= "00010";
       w_read_address_1  <= "00011";
       w_write_control   <= '1';

       wait for real(clock_period)*4.0 * 1 ns;
       
       
       w_write_data      <= x"000000FF";   
       w_write_address   <= "00010";
       w_read_address_0  <= "00010";
       w_read_address_1  <= "00011";
       w_write_control   <= '0';
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_output_data_0 = x"000000FF") report "Fail test 0" severity error;
       assert(w_output_data_1 = x"00000000") report "Fail test 1" severity error;

    end process;

	

end behaviour;