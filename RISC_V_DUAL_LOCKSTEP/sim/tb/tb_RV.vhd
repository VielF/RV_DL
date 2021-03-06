library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.TEXTIO.all;
use work.all;

entity tb_RV is
end tb_RV; 

architecture behaviour of tb_RV is

    signal clk                      : std_logic := '0';			-- Clock
    signal rst                      : std_logic := '1';			-- Reset
    constant clock_period           : integer := 20;
    constant clock_frequency        : real    := real(125*1000000);

    signal w_debug_pc_output : std_logic_vector(31 downto 0);
    signal w_debug_regfile_x31_output : std_logic_vector(31 downto 0);
    signal w_debug_regfile_x1_output : std_logic_vector(31 downto 0);
    signal w_debug_regfile_x2_output : std_logic_vector(31 downto 0);
    signal w_debug_ALU_output : std_logic_vector(31 downto 0);
    signal w_debug_regfile_write : std_logic;
    signal w_debug_ALU_input_0 : std_logic_vector(31 downto 0);
    signal w_debug_ALU_input_1 : std_logic_vector(31 downto 0);
    signal w_debug_reg_file_read_address_0 : std_logic_vector(4 downto 0);
    signal w_debug_reg_file_read_address_1 : std_logic_vector(4 downto 0);
    signal w_debug_mux0_sel : std_logic_vector(1 downto 0);
    signal w_debug_immediate : std_logic_vector(31 downto 0);
    signal w_debug_ALU_operation : std_logic_vector(3 downto 0);
    signal w_debug_forward_mux_0 : std_logic_vector(2 downto 0);
    signal w_debug_forward_mux_1 : std_logic_vector(2 downto 0);
    signal w_debug_reg_file_read_address_0_ID_EXE : std_logic_vector(4 downto 0);
    signal w_debug_reg_file_write_address_EX_MEM : std_logic_vector(4 downto 0);
    signal w_debug_mux0_sel_MEM_WB : std_logic_vector(1 downto 0);
    signal w_debug_reg_file_write_MEM_WB : std_logic;
    signal w_debug_reg_file_write_address_MEM_WB : std_logic_vector(4 downto 0);
    signal w_debug_ALU_output_MEM_WB : std_logic_vector(31 downto 0);
    signal w_debug_ALU_output_EX_MEM : std_logic_vector(31 downto 0);
    signal w_debug_register_file_output_0 : std_logic_vector(31 downto 0);
    signal w_debug_register_file_output_1 : std_logic_vector(31 downto 0);
    signal w_debug_register_file_output_0_ID_EX : std_logic_vector(31 downto 0);
    signal w_debug_register_file_output_1_ID_EX : std_logic_vector(31 downto 0);
    signal w_debug_instruction : std_logic_vector(31 downto 0);
    signal w_debug_datamem_output : std_logic_vector(31 downto 0);
    signal w_debug_reg_wr_output  :  std_logic_vector(31 downto 0);
    signal w_progmem_output_backup :  std_logic_vector(31 downto 0);
    signal w_MUX_IM_CTRL           :  std_logic;
   
begin

-- clock and reset

    clk   <= not clk after clock_period/2 * 1 ns; -- 
    rst   <= '0' after real(clock_period)*4.0 * 1 ns; -- release reset after 4 clock cycles
    w_progmem_output_backup <= x"00000000";
    w_MUX_IM_CTRL           <= '0';

    DUT_RV: entity work.microcontroller
        port map(
            clock                                   => clk,--: in std_logic;
            reset                                   => rst,-- : in std_logic;
            debug_pc_output                         => w_debug_pc_output                     ,-- : out std_logic_vector(31 downto 0);
            debug_regfile_x31_output                => w_debug_regfile_x31_output            ,-- : out std_logic_vector(31 downto 0);
            debug_regfile_x1_output                 => w_debug_regfile_x1_output             ,-- : out std_logic_vector(31 downto 0);
            debug_regfile_x2_output                 => w_debug_regfile_x2_output             ,-- : out std_logic_vector(31 downto 0);
            debug_ALU_output                        => w_debug_ALU_output                    ,-- : out std_logic_vector(31 downto 0);
            debug_regfile_write                     => w_debug_regfile_write                 ,-- : out std_logic;
            debug_ALU_input_0                       => w_debug_ALU_input_0                   ,-- : out std_logic_vector(31 downto 0);
            debug_ALU_input_1                       => w_debug_ALU_input_1                   ,-- : out std_logic_vector(31 downto 0);
            debug_reg_file_read_address_0           => w_debug_reg_file_read_address_0       ,-- : out std_logic_vector(4 downto 0);
            debug_reg_file_read_address_1           => w_debug_reg_file_read_address_1       ,-- : out std_logic_vector(4 downto 0);
            debug_mux0_sel                          => w_debug_mux0_sel                      ,-- : out std_logic_vector(1 downto 0);
            debug_immediate                         => w_debug_immediate                     ,-- : out std_logic_vector(31 downto 0);
            debug_ALU_operation                     => w_debug_ALU_operation                 ,-- : out std_logic_vector(3 downto 0);
            debug_forward_mux_0                     => w_debug_forward_mux_0                 ,-- : out std_logic_vector(2 downto 0);
            debug_forward_mux_1                     => w_debug_forward_mux_1                 ,-- : out std_logic_vector(2 downto 0);
            debug_reg_file_read_address_0_ID_EXE    => w_debug_reg_file_read_address_0_ID_EXE,-- : out std_logic_vector(4 downto 0);
            debug_reg_file_write_address_EX_MEM     => w_debug_reg_file_write_address_EX_MEM ,-- : out std_logic_vector(4 downto 0);
            debug_mux0_sel_MEM_WB                   => w_debug_mux0_sel_MEM_WB               ,-- : out std_logic_vector(1 downto 0);
            debug_reg_file_write_MEM_WB             => w_debug_reg_file_write_MEM_WB         ,-- : out std_logic;
            debug_reg_file_write_address_MEM_WB     => w_debug_reg_file_write_address_MEM_WB ,-- : out std_logic_vector(4 downto 0);
            debug_ALU_output_MEM_WB                 => w_debug_ALU_output_MEM_WB             ,-- : out std_logic_vector(31 downto 0);
            debug_ALU_output_EX_MEM                 => w_debug_ALU_output_EX_MEM             ,-- : out std_logic_vector(31 downto 0);
            debug_register_file_output_0            => w_debug_register_file_output_0        ,-- : out std_logic_vector(31 downto 0);
            debug_register_file_output_1            => w_debug_register_file_output_1        ,-- : out std_logic_vector(31 downto 0);
            debug_register_file_output_0_ID_EX      => w_debug_register_file_output_0_ID_EX  ,-- : out std_logic_vector(31 downto 0);
            debug_register_file_output_1_ID_EX      => w_debug_register_file_output_1_ID_EX  ,-- : out std_logic_vector(31 downto 0);
            debug_instruction                       => w_debug_instruction,                   -- : out std_logic_vector(31 downto 0)
	    debug_datamem_output                    => w_debug_datamem_output,
            debug_reg_wr_output                     => w_debug_reg_wr_output,
            progmem_output_backup                   => w_progmem_output_backup,
            MUX_IM_CTRL                             => w_MUX_IM_CTRL
        );

    tb_process : process 
    begin 
       wait for real(clock_period)*1.0 * 1 ns;
       assert(w_debug_pc_output = x"00000004") report "Fail test PC counter" severity error;
       assert(w_debug_ALU_output = x"00000000") report "Fail test ALUout" severity error;
       assert(w_debug_ALU_input_0 = x"00000000") report "Fail test ALUin1" severity error;
       assert(w_debug_ALU_input_1 = x"00000000") report "Fail test ALUin2" severity error;
       assert(w_debug_reg_file_read_address_0 = "00000") report "Fail reg_file_read_address_0" severity error;
       assert(w_debug_reg_file_read_address_1 = "00000") report "Fail reg_file_read_address_1" severity error;
       assert(w_debug_immediate = x"00000000") report "Fail immediate" severity error;
       assert(w_debug_forward_mux_1 = "000") report "Fail forward_mux_1" severity error;
       assert(w_debug_reg_file_write_address_EX_MEM = "00000") report "Fail reg_file_write_address_EX_MEM" severity error;
       assert(w_debug_instruction = x"00100113") report "Fail Instru" severity error;
       assert(w_debug_ALU_output_EX_MEM = x"00100113") report "Fail ALU_output_EX_MEM" severity error;

       wait for real(clock_period)*2.0 * 1 ns;
       assert(w_debug_pc_output = x"00000008") report "Fail test PC counter" severity error;
       assert(w_debug_ALU_output = x"00000000") report "Fail test ALUout" severity error;
       assert(w_debug_ALU_input_0 = x"00000000") report "Fail test ALUin1" severity error;
       assert(w_debug_ALU_input_1 = x"00000000") report "Fail test ALUin2" severity error;
       assert(w_debug_reg_file_read_address_0 = "00001") report "Fail reg_file_read_address_0" severity error;
       assert(w_debug_reg_file_read_address_1 = "00000") report "Fail reg_file_read_address_1" severity error;
       assert(w_debug_immediate = x"00000001") report "Fail immediate" severity error;
       assert(w_debug_forward_mux_1 = "000") report "Fail forward_mux_1" severity error;
       assert(w_debug_reg_file_write_address_EX_MEM = "00000") report "Fail reg_file_write_address_EX_MEM" severity error;
       assert(w_debug_instruction = x"00100113") report "Fail Instru" severity error;
       assert(w_debug_ALU_output_EX_MEM = x"00200FB3") report "Fail ALU_output_EX_MEM" severity error;

       wait for real(clock_period)*3.0 * 1 ns;
       assert(w_debug_pc_output = x"0000000c") report "Fail test PC counter" severity error;
       assert(w_debug_ALU_output = x"00000001") report "Fail test ALUout" severity error;
       assert(w_debug_ALU_input_0 = x"00000000") report "Fail test ALUin1" severity error;
       assert(w_debug_ALU_input_1 = x"00000001") report "Fail test ALUin2" severity error;
       assert(w_debug_reg_file_read_address_0 = "00010") report "Fail reg_file_read_address_0" severity error;
       assert(w_debug_reg_file_read_address_1 = "00000") report "Fail reg_file_read_address_1" severity error;
       assert(w_debug_immediate = x"00000000") report "Fail immediate" severity error;
       assert(w_debug_forward_mux_1 = "000") report "Fail forward_mux_1" severity error;
       assert(w_debug_reg_file_write_address_EX_MEM = "00000") report "Fail reg_file_write_address_EX_MEM" severity error;
       assert(w_debug_instruction = x"00100113") report "Fail Instru" severity error;
       assert(w_debug_ALU_output_EX_MEM = x"002080B3") report "Fail ALU_output_EX_MEM" severity error;

       wait for real(clock_period)*4.0 * 1 ns;
       assert(w_debug_pc_output = x"00000010") report "Fail test PC counter" severity error;
       assert(w_debug_ALU_output = x"00000001") report "Fail test ALUout" severity error;
       assert(w_debug_ALU_input_0 = x"00000000") report "Fail test ALUin1" severity error;
       assert(w_debug_ALU_input_1 = x"00000001") report "Fail test ALUin2" severity error;
       assert(w_debug_reg_file_read_address_0 = "00001") report "Fail reg_file_read_address_0" severity error;
       assert(w_debug_reg_file_read_address_1 = "00000") report "Fail reg_file_read_address_1" severity error;
       assert(w_debug_immediate = x"00000000") report "Fail immediate" severity error;
       assert(w_debug_forward_mux_1 = "001") report "Fail forward_mux_1" severity error;
       assert(w_debug_reg_file_write_address_EX_MEM = "00010") report "Fail reg_file_write_address_EX_MEM" severity error;
       assert(w_debug_instruction = x"00000001") report "Fail Instru" severity error;
       assert(w_debug_ALU_output_EX_MEM = x"00100FB3") report "Fail ALU_output_EX_MEM" severity error;

       wait for real(clock_period)*5.0 * 1 ns;
       assert(w_debug_pc_output = x"00000000") report "Fail test PC counter" severity error;
       assert(w_debug_ALU_output = x"00000000") report "Fail test ALUout" severity error;
       assert(w_debug_ALU_input_0 = x"00000000") report "Fail test ALUin1" severity error;
       assert(w_debug_ALU_input_1 = x"00000000") report "Fail test ALUin2" severity error;
       assert(w_debug_reg_file_read_address_0 = "00000") report "Fail reg_file_read_address_0" severity error;
       assert(w_debug_reg_file_read_address_1 = "00000") report "Fail reg_file_read_address_1" severity error;
       assert(w_debug_immediate = x"00000000") report "Fail immediate" severity error;
       assert(w_debug_forward_mux_1 = "000") report "Fail forward_mux_1" severity error;
       assert(w_debug_reg_file_write_address_EX_MEM = "00000") report "Fail reg_file_write_address_EX_MEM" severity error;
       assert(w_debug_instruction = x"00100113") report "Fail Instru" severity error;
       assert(w_debug_ALU_output_EX_MEM = x"00100113") report "Fail ALU_output_EX_MEM" severity error;

       


    end process;

	

end behaviour;