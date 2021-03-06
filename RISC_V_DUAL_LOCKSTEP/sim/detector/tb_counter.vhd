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

    signal w_COUNTER_COUNT_FAULTS_in         : std_logic_vector (3 downto 0) := x"0";
    signal w_ENA_COUNTER_COUNT_FAULTS_out    : std_logic;
   
begin

-- clock and reset

    clk   <= not clk after clock_period/2 * 1 ns; -- 
    rst   <= '1' after real(clock_period)*4.0 * 1 ns; -- release reset after 4 clock cycles

    DUT_DETECTOR: entity work.counter
       generic map (
		SIZE => 4
	)
	port map(
		i_clk => clk,
		i_rst_n => rst, 
		i_ena_count => w_ENA_COUNTER_COUNT_FAULTS_out, 
		o_counter => w_COUNTER_COUNT_FAULTS_in
	);


    tb_process : process 
    begin
       wait for real(clock_period)*4.0 * 1 ns;

       w_ENA_COUNTER_COUNT_FAULTS_out <= '0'; 
       wait for real(clock_period)*4.0 * 1 ns;
       assert(w_COUNTER_COUNT_FAULTS_in = x"0") report "Fail test 0" severity error;

       w_ENA_COUNTER_COUNT_FAULTS_out <= '1'; 
       wait for real(clock_period)*1.0 * 1 ns;
       w_ENA_COUNTER_COUNT_FAULTS_out <= '0';
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_COUNTER_COUNT_FAULTS_in = x"1") report "Fail test 1" severity error;

       w_ENA_COUNTER_COUNT_FAULTS_out <= '1'; 
       wait for real(clock_period)*1.0 * 1 ns;
       w_ENA_COUNTER_COUNT_FAULTS_out <= '0';
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_COUNTER_COUNT_FAULTS_in = x"2") report "Fail test 2" severity error;

       w_ENA_COUNTER_COUNT_FAULTS_out <= '1'; 
       wait for real(clock_period)*1.0 * 1 ns;
       w_ENA_COUNTER_COUNT_FAULTS_out <= '0';
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_COUNTER_COUNT_FAULTS_in = x"3") report "Fail test 3" severity error;

       w_ENA_COUNTER_COUNT_FAULTS_out <= '1'; 
       wait for real(clock_period)*1.0 * 1 ns;
       w_ENA_COUNTER_COUNT_FAULTS_out <= '0';
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_COUNTER_COUNT_FAULTS_in = x"4") report "Fail test 4" severity error;

       w_ENA_COUNTER_COUNT_FAULTS_out <= '1'; 
       wait for real(clock_period)*1.0 * 1 ns;
       w_ENA_COUNTER_COUNT_FAULTS_out <= '0';
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_COUNTER_COUNT_FAULTS_in = x"5") report "Fail test 5" severity error;

       w_ENA_COUNTER_COUNT_FAULTS_out <= '1'; 
       wait for real(clock_period)*1.0 * 1 ns;
       w_ENA_COUNTER_COUNT_FAULTS_out <= '0';
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_COUNTER_COUNT_FAULTS_in = x"6") report "Fail test 6" severity error;

       w_ENA_COUNTER_COUNT_FAULTS_out <= '1'; 
       wait for real(clock_period)*1.0 * 1 ns;
       w_ENA_COUNTER_COUNT_FAULTS_out <= '0';
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_COUNTER_COUNT_FAULTS_in = x"7") report "Fail test 7" severity error;


    end process;

	

end behaviour;