library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.TEXTIO.all;
use work.all;

entity tb_datapath is
end tb_datapath; 

architecture behaviour of tb_datapath is

    signal clk                      : std_logic := '0';			-- Clock
    signal rst                      : std_logic := '0';			-- Reset
    constant clock_period           : integer := 20;
    constant clock_frequency        : real    := real(125*1000000);

	signal w_reg_file_read_address_0 : std_logic_vector(4 downto 0);
	signal w_reg_file_read_address_1 : std_logic_vector(4 downto 0);
	signal w_reg_file_write :  std_logic;
	signal w_reg_file_write_address :  std_logic_vector(4 downto 0);
	signal w_immediate :  std_logic_vector(31 downto 0);
	signal w_ALU_operation :  std_logic_vector(3 downto 0);
	signal w_ALU_branch :  std_logic;
	signal w_ALU_branch_control :  std_logic_vector(2 downto 0);
	signal w_JTU_mux_sel :  std_logic;
	signal w_data_format :  std_logic_vector(2 downto 0);
	signal w_datamem_write :  std_logic;
	signal w_jump_flag :  std_logic;
	signal w_mux0_sel :  std_logic_vector(1 downto 0);
	signal w_mux1_sel :  std_logic;
	signal w_instruction : std_logic_vector(31 downto 0); --change it back to output later
	signal w_debug_instruction_address :  std_logic_vector(31 downto 0);
	signal w_debug_regfile_x31_output :  std_logic_vector(31 downto 0);
	signal w_debug_regfile_x1_output :  std_logic_vector(31 downto 0);
	signal w_debug_regfile_x2_output :  std_logic_vector(31 downto 0);
	signal w_debug_ALU_output :  std_logic_vector(31 downto 0);
	signal w_debug_ALU_input_0 :  std_logic_vector(31 downto 0);
	signal w_debug_ALU_input_1 :  std_logic_vector(31 downto 0);
	signal w_debug_forward_mux_0 :  std_logic_vector(2 downto 0);
	signal w_debug_forward_mux_1 :  std_logic_vector(2 downto 0);
	signal w_debug_reg_file_read_address_0_ID_EXE :  std_logic_vector(4 downto 0);
	signal w_debug_reg_file_write_address_EX_MEM :  std_logic_vector(4 downto 0);
	signal w_debug_mux0_sel_MEM_WB :  std_logic_vector(1 downto 0);
	signal w_debug_reg_file_write_MEM_WB :  std_logic;
	signal w_debug_reg_file_write_address_MEM_WB :  std_logic_vector(4 downto 0);
	signal w_debug_ALU_output_MEM_WB :  std_logic_vector(31 downto 0);
	signal w_debug_ALU_output_EX_MEM :  std_logic_vector(31 downto 0);
	signal w_debug_register_file_output_0 :  std_logic_vector(31 downto 0);
	signal w_debug_register_file_output_1 :  std_logic_vector(31 downto 0);
	signal w_debug_register_file_output_0_ID_EX :  std_logic_vector(31 downto 0);
	signal w_debug_register_file_output_1_ID_EX :  std_logic_vector(31 downto 0);
	signal w_debug_instruction :  std_logic_vector(31 downto 0);                 
   
begin

-- clock and reset

    clk   <= not clk after clock_period/2 * 1 ns; -- 
    rst   <= '1' after real(clock_period)*4.0 * 1 ns; -- release reset after 4 clock cycles

    DUT_DETECTOR: entity work.datapath
        port map(
            clock                                 => clk,      --: in std_logic;
            reset                                 => rst,      -- : in std_logic;
            reg_file_read_address_0               => w_reg_file_read_address_0             ,                        -- : in std_logic_vector(4 downto 0);
            reg_file_read_address_1               => w_reg_file_read_address_1             ,                        -- : in std_logic_vector(4 downto 0);
            reg_file_write                        => w_reg_file_write                      ,               -- : in std_logic;
            reg_file_write_address                => w_reg_file_write_address              ,                       -- : in std_logic_vector(4 downto 0);
            immediate                             => w_immediate                           ,          -- : in std_logic_vector(31 downto 0);
            ALU_operation                         => w_ALU_operation                       ,              -- : in std_logic_vector(3 downto 0);
            ALU_branch                            => w_ALU_branch                          ,           -- : in std_logic;
            ALU_branch_control                    => w_ALU_branch_control                  ,                   -- : in std_logic_vector(2 downto 0);
            JTU_mux_sel                           => w_JTU_mux_sel                         ,            -- : in std_logic;
            data_format                           => w_data_format                         ,            -- : in std_logic_vector(2 downto 0);
            datamem_write                         => w_datamem_write                       ,              -- : in std_logic;
            jump_flag                             => w_jump_flag                           ,          -- : in std_logic;
            mux0_sel                              => w_mux0_sel                            ,         -- : in std_logic_vector(1 downto 0);
            mux1_sel                              => w_mux1_sel                            ,         -- : in std_logic;
            instruction                           => w_instruction                         ,            -- : buffer std_logic_vector(31 downto 0); --change it back to output later
            debug_instruction_address             => w_debug_instruction_address           ,                          -- : out std_logic_vector(31 downto 0);
            debug_regfile_x31_output              => w_debug_regfile_x31_output            ,                         -- : out std_logic_vector(31 downto 0);
            debug_regfile_x1_output               => w_debug_regfile_x1_output             ,                        -- : out std_logic_vector(31 downto 0);
            debug_regfile_x2_output               => w_debug_regfile_x2_output             ,                        -- : out std_logic_vector(31 downto 0);
            debug_ALU_output                      => w_debug_ALU_output                    ,                 -- : out std_logic_vector(31 downto 0);
            debug_ALU_input_0                     => w_debug_ALU_input_0                   ,                  -- : out std_logic_vector(31 downto 0);
            debug_ALU_input_1                     => w_debug_ALU_input_1                   ,                  -- : out std_logic_vector(31 downto 0);
            debug_forward_mux_0                   => w_debug_forward_mux_0                 ,                    -- : out std_logic_vector(2 downto 0);
            debug_forward_mux_1                   => w_debug_forward_mux_1                 ,                    -- : out std_logic_vector(2 downto 0);
            debug_reg_file_read_address_0_ID_EXE  => w_debug_reg_file_read_address_0_ID_EXE,                                     -- : out std_logic_vector(4 downto 0);
            debug_reg_file_write_address_EX_MEM   => w_debug_reg_file_write_address_EX_MEM ,                                     --: out std_logic_vector(4 downto 0);
            debug_mux0_sel_MEM_WB                 => w_debug_mux0_sel_MEM_WB               ,                      -- : out std_logic_vector(1 downto 0);
            debug_reg_file_write_MEM_WB           => w_debug_reg_file_write_MEM_WB         ,                            -- : out std_logic;
            debug_reg_file_write_address_MEM_WB   => w_debug_reg_file_write_address_MEM_WB ,                                     --: out std_logic_vector(4 downto 0);
            debug_ALU_output_MEM_WB               => w_debug_ALU_output_MEM_WB             ,                         --: out std_logic_vector(31 downto 0);
            debug_ALU_output_EX_MEM               => w_debug_ALU_output_EX_MEM             ,                         --: out std_logic_vector(31 downto 0);
            debug_register_file_output_0          => w_debug_register_file_output_0        ,                              --: out std_logic_vector(31 downto 0);
            debug_register_file_output_1          => w_debug_register_file_output_1        ,                              --: out std_logic_vector(31 downto 0);
            debug_register_file_output_0_ID_EX    => w_debug_register_file_output_0_ID_EX  ,                                    --: out std_logic_vector(31 downto 0);
            debug_register_file_output_1_ID_EX    => w_debug_register_file_output_1_ID_EX  ,                                    --: out std_logic_vector(31 downto 0);
            debug_instruction                     => w_debug_instruction                                     --: out std_logic_vector(31 downto 0)
    
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