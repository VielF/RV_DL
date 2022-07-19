-- 
-- File tb_controller_RV.cpp 
-- 
-- This file has the implementation for testbench to RISC-V controller module
-- 
-- Felipe Viel <felipe.viel@posgrad.ufsc.br>
-- Departamento de Engenharia Eletrica
-- 
-- Data da criacao: 13 de setembro de 2021.
-- Data da ultima alteracao: 16 de setembro de 2021.
-- 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.TEXTIO.all;
use work.all;

entity tb_controller_RV is
end tb_controller_RV; 

architecture beh of tb_controller_RV is

    signal clk                      : std_logic := '0';			-- Clock
    signal rst                      : std_logic := '0';			-- Reset
    constant clock_period           : integer := 20;
             
    signal w_instruction             : std_logic_vector(31 downto 0);  
    signal w_reg_file_read_address_0 : std_logic_vector(4 downto 0);
    signal w_reg_file_read_address_1 : std_logic_vector(4 downto 0);
    signal w_reg_file_write          : std_logic;
    signal w_reg_file_write_address  : std_logic_vector(4 downto 0);
    signal w_immediate               : std_logic_vector(31 downto 0);
    signal w_ALU_operation           : std_logic_vector(3 downto 0);
    signal w_ALU_branch              : std_logic;
    signal w_ALU_branch_control      : std_logic_vector(2 downto 0);
    signal w_JTU_mux_sel             : std_logic; 
    signal w_data_format             : std_logic_vector(2 downto 0); 
    signal w_datamem_write           : std_logic;  
    signal w_jump_flag               : std_logic;  
    signal w_mux0_sel                : std_logic_vector(1 downto 0);  
    signal w_mux1_sel                : std_logic;
   
begin

-- clock and reset

    clk   <= not clk after clock_period/2 * 1 ns; -- 
    rst   <= '1' after real(clock_period)*4.0 * 1 ns; -- release reset after 4 clock cycles

    TOP_CONTROLLER: entity work.controller
        port map (
            clock                     => clk, --: in std_logic;
            reset                     => rst, --: in std_logic;
            instruction               => w_instruction            , --: in std_logic_vector(31 downto 0);
            reg_file_read_address_0   => w_reg_file_read_address_0, --: out std_logic_vector(4 downto 0);
            reg_file_read_address_1   => w_reg_file_read_address_1, --: out std_logic_vector(4 downto 0);
            reg_file_write            => w_reg_file_write         , --: out std_logic;
            reg_file_write_address    => w_reg_file_write_address , --: out std_logic_vector(4 downto 0);
            immediate                 => w_immediate              , --: out std_logic_vector(31 downto 0);
            ALU_operation             => w_ALU_operation          , --: out std_logic_vector(3 downto 0);
            ALU_branch                => w_ALU_branch             , --: out std_logic;
            ALU_branch_control        => w_ALU_branch_control     , --: out std_logic_vector(2 downto 0);
            JTU_mux_sel               => w_JTU_mux_sel            , --: out std_logic;
            data_format               => w_data_format            , --: out std_logic_vector(2 downto 0);
            datamem_write             => w_datamem_write          , --: out std_logic;
            jump_flag                 => w_jump_flag              , --: out std_logic;
            mux0_sel                  => w_mux0_sel               , --: out std_logic_vector(1 downto 0);
            mux1_sel                  => w_mux1_sel                --: out std_logic
        );


    tb_process : process 
    begin
        w_instruction <= "00000000010000000000000011101111";   -- JAL x1, 4        
        wait for real(clock_period)*4.0 * 1 ns;
        assert(w_reg_file_read_address_0 = "00000") report "Fail test JAL reg_file_read_address_0" severity error;
        assert(w_reg_file_read_address_1 = "00000") report "Fail test JAL w_reg_file_read_address_1" severity error;
        assert(w_reg_file_write = '1') report "Fail test JAL w_reg_file_write" severity error;
        assert(w_reg_file_write_address = w_instruction(11 downto 7)) report "Fail test JAL w_reg_file_write_address" severity error;
        assert(w_immediate = std_logic_vector(shift_right(signed(w_instruction(31) & w_instruction(19 downto 12) & w_instruction(20) & w_instruction(30 downto 21) & '0' & "00000000000"), 11))) report "Fail test JAL w_immediate" severity error;
        assert(w_ALU_operation = "0000") report "Fail test JAL w_ALU_operation" severity error;
        assert(w_ALU_branch = '0') report "Fail test JAL w_ALU_branch" severity error;
        assert(w_ALU_branch_control = "000") report "Fail test JAL w_ALU_branch_control" severity error;
        assert(w_JTU_mux_sel = '0') report "Fail test JAL w_JTU_mux_sel" severity error;
        assert(w_data_format = "000") report "Fail test JAL w_data_format" severity error;
        assert(w_datamem_write = '0') report "Fail test JAL w_datamem_write" severity error;
        assert(w_jump_flag = '1') report "Fail test JAL w_jump_flag" severity error;
        assert(w_mux0_sel = "10") report "Fail test JAL w_mux0_sel" severity error;
        assert(w_mux1_sel = '0') report "Fail test JAL w_mux1_sel" severity error;
        

        w_instruction <= "00000000110001011000010001100011";           -- BEQ x11, x12, branch_jump   -- here test also: branchs with positive adderss
        wait for real(clock_period)*4.0 * 1 ns;
        assert(w_reg_file_read_address_0 = w_instruction(19 downto 15)) report "Fail test BEQ reg_file_read_address_0" severity error;
        assert(w_reg_file_read_address_1 = w_instruction(24 downto 20)) report "Fail test BEQ w_reg_file_read_address_1" severity error;
        assert(w_reg_file_write = '0') report "Fail test w_reg_file_write" severity error;
        assert(w_reg_file_write_address = w_instruction(11 downto 7)) report "Fail test BEQ w_reg_file_write_address" severity error;
        assert(w_immediate = std_logic_vector("00000000000000000" & w_instruction(31) & w_instruction(7) & w_instruction(30 downto 25) & w_instruction(11 downto 6) & '0')) report "Fail test BEQ w_immediate" severity error;
        assert(w_ALU_operation = "0000") report "Fail test BEQ w_ALU_operation" severity error;
        assert(w_ALU_branch = '1') report "Fail test w_ALU_branch" severity error;
        assert(w_ALU_branch_control = std_logic_vector(w_instruction(14 downto 12))) report "Fail test BEQ w_ALU_branch_control" severity error;
        assert(w_JTU_mux_sel = '0') report "Fail test BEQ w_JTU_mux_sel" severity error;
        assert(w_data_format = "000") report "Fail test BEQ w_data_format" severity error;
        assert(w_datamem_write = '0') report "Fail test BEQ w_datamem_write" severity error;
        assert(w_jump_flag = '0') report "Fail test BEQ w_jump_flag" severity error;
        assert(w_mux0_sel = "00") report "Fail test BEQ w_mux0_sel" severity error;
        assert(w_mux1_sel = '0') report "Fail test BEQ w_mux1_sel" severity error;


        w_instruction <= "00000000000100000000010110010011";           -- ADDI  x11, zero, 1   -- here test also: SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI
        wait for real(clock_period)*4.0 * 1 ns;
        assert(w_reg_file_read_address_0 = w_instruction(19 downto 15)) report "Fail test ADDI  reg_file_read_address_0" severity error;
        assert(w_reg_file_read_address_1 = w_instruction(24 downto 20)) report "Fail test ADDI  w_reg_file_read_address_1" severity error;
        assert(w_reg_file_write = '1') report "Fail test w_reg_file_write" severity error;
        assert(w_reg_file_write_address = w_instruction(11 downto 7)) report "Fail test ADDI  w_reg_file_write_address" severity error;
        assert(w_immediate = std_logic_vector(shift_right(signed(w_instruction(31 downto 20) & "00000000000000000000"), 20))) report "Fail test ADDI  w_immediate" severity error;
        assert(w_ALU_operation = std_logic_vector('0' & w_instruction(14 downto 12))) report "Fail test ADDI  _ALU_operation" severity error;
        assert(w_ALU_branch = '0') report "Fail test ADDI  w_ALU_branch" severity error;
        assert(w_ALU_branch_control = "000") report "Fail test ADDI  w_ALU_branch_control" severity error;
        assert(w_JTU_mux_sel = '0') report "Fail test ADDI  w_JTU_mux_sel" severity error;
        assert(w_data_format = "000") report "Fail test ADDI  w_data_format" severity error;
        assert(w_datamem_write = '0') report "Fail test ADDI w_datamem_write" severity error;
        assert(w_jump_flag = '0') report "Fail test ADDI  w_jump_flag" severity error;
        assert(w_mux0_sel = "00") report "Fail test ADDI  w_mux0_sel" severity error;
        assert(w_mux1_sel = '1') report "Fail test ADDI  w_mux1_sel" severity error;


        w_instruction <= "00000000000001010010010100000011";         -- LW a0, aa       -- aa is a variable
        wait for real(clock_period)*4.0 * 1 ns;
        assert(w_reg_file_read_address_0 = w_instruction(19 downto 15)) report "Fail test LW reg_file_read_address_0" severity error;
        assert(w_reg_file_read_address_1 = "00000") report "Fail test LW w_reg_file_read_address_1" severity error;
        assert(w_reg_file_write = '1') report "Fail test w_reg_file_write" severity error;
        assert(w_reg_file_write_address = w_instruction(11 downto 7)) report "Fail test LW w_reg_file_write_address" severity error;
        assert(w_immediate = std_logic_vector("00000000000000000000" & w_instruction(31 downto 20))) report "Fail test LW w_immediate" severity error;
        assert(w_ALU_operation = "0000") report "Fail test LW w_ALU_operation" severity error;
        assert(w_ALU_branch = '0') report "Fail test LW w_ALU_branch" severity error;
        assert(w_ALU_branch_control = "000") report "Fail test LW w_ALU_branch_control" severity error;
        assert(w_JTU_mux_sel = '0') report "Fail test LW w_JTU_mux_sel" severity error;
        assert(w_data_format = std_logic_vector(w_instruction(14 downto 12))) report "Fail test LW w_data_format" severity error;
        assert(w_datamem_write = '0') report "Fail test LW w_datamem_write" severity error;
        assert(w_jump_flag = '0') report "Fail test LW w_jump_flag" severity error;
        assert(w_mux0_sel = "01") report "Fail test LW w_mux0_sel" severity error;
        assert(w_mux1_sel = '1') report "Fail test LW w_mux1_sel" severity error;


        w_instruction <= "00000000000000010010110000100011";         -- SW x0, 24(sp)        
        wait for real(clock_period)*4.0 * 1 ns;
        assert(w_reg_file_read_address_0 = w_instruction(19 downto 15)) report "Fail test SW reg_file_read_address_0" severity error;
        assert(w_reg_file_read_address_1 = w_instruction(24 downto 20)) report "Fail test SW w_reg_file_read_address_1" severity error;
        assert(w_reg_file_write = '0') report "Fail test SW w_reg_file_write" severity error;
        assert(w_reg_file_write_address = w_instruction(11 downto 7)) report "Fail test SW w_reg_file_write_address" severity error;
        assert(w_immediate = std_logic_vector("00000000000000000000" & w_instruction(31 downto 25) & w_instruction(11 downto 7))) report "Fail test SW w_immediate" severity error;
        assert(w_ALU_operation = "0000") report "Fail test SW w_ALU_operation" severity error;
        assert(w_ALU_branch = '0') report "Fail test SW w_ALU_branch" severity error;
        assert(w_ALU_branch_control = "000") report "Fail test SW w_ALU_branch_control" severity error;
        assert(w_JTU_mux_sel = '0') report "Fail test SW w_JTU_mux_sel" severity error;
        assert(w_data_format = std_logic_vector(w_instruction(14 downto 12))) report "Fail test SW w_data_format" severity error;
        assert(w_datamem_write = '1') report "Fail test SW w_datamem_write" severity error;
        assert(w_jump_flag = '0') report "Fail test SW w_jump_flag" severity error;
        assert(w_mux0_sel = "00") report "Fail test SW w_mux0_sel" severity error;
        assert(w_mux1_sel = '1') report "Fail test SW w_mux1_sel" severity error;



        w_instruction <= "01000000101000101000001110110011";         -- SUB t2, t0, a0
        wait for real(clock_period)*4.0 * 1 ns;
        assert(w_reg_file_read_address_0 = w_instruction(19 downto 15)) report "Fail test SUB treg_file_read_address_0" severity error;
        assert(w_reg_file_read_address_1 = w_instruction(24 downto 20)) report "Fail test SUB tw_reg_file_read_address_1" severity error;
        assert(w_reg_file_write = '1') report "Fail test w_reg_file_write" severity error;
        assert(w_reg_file_write_address = w_instruction(11 downto 7)) report "Fail test SUB tw_reg_file_write_address" severity error;
        assert(w_immediate = x"00000000") report "Fail test SUB tw_immediate" severity error;
        assert(w_ALU_operation = std_logic_vector(w_instruction(30) & w_instruction(14 downto 12))) report "Fail test SUB tw_ALU_operation" severity error;
        assert(w_ALU_branch = '0') report "Fail test SUB tw_ALU_branch" severity error;
        assert(w_ALU_branch_control = "000") report "Fail test SUB tw_ALU_branch_control" severity error;
        assert(w_JTU_mux_sel = '0') report "Fail test SUB tw_JTU_mux_sel" severity error;
        assert(w_data_format = "000") report "Fail test SUB tw_data_format" severity error;
        assert(w_datamem_write = '0') report "Fail test SUB tw_datamem_write" severity error;
        assert(w_jump_flag = '0') report "Fail test SUB tw_jump_flag" severity error;
        assert(w_mux0_sel = "00") report "Fail test SUB tw_mux0_sel" severity error;
        assert(w_mux1_sel = '0') report "Fail test SUB tw_mux1_sel" severity error;



        w_instruction <= "00000000000000000001000000110111";        -- LUI x0, 1
        wait for real(clock_period)*4.0 * 1 ns;
        assert(w_reg_file_read_address_0 = "00000") report "Fail test LUI reg_file_read_address_0" severity error;
        assert(w_reg_file_read_address_1 = "00000") report "Fail test LUI w_reg_file_read_address_1" severity error;
        assert(w_reg_file_write = '1') report "Fail test LUI w_reg_file_write" severity error;
        assert(w_reg_file_write_address = w_instruction(11 downto 7)) report "Fail test LUI w_reg_file_write_address" severity error;
        assert(w_immediate = std_logic_vector(w_instruction(31 downto 12) & "000000000000")) report "Fail test LUI w_immediate" severity error;
        assert(w_ALU_operation = "0000") report "Fail test LUI w_ALU_operation" severity error;
        assert(w_ALU_branch = '0') report "Fail test LUI w_ALU_branch" severity error;
        assert(w_ALU_branch_control = "000") report "Fail test LUI w_ALU_branch_control" severity error;
        assert(w_JTU_mux_sel = '0') report "Fail test LUI w_JTU_mux_sel" severity error;
        assert(w_data_format = "000") report "Fail test LUI w_data_format" severity error;
        assert(w_datamem_write = '0') report "Fail test LUI w_datamem_write" severity error;
        assert(w_jump_flag = '0') report "Fail test LUI w_jump_flag" severity error;
        assert(w_mux0_sel = "00") report "Fail test LUI w_mux0_sel" severity error;
        assert(w_mux1_sel = '1') report "Fail test LUI w_mux1_sel" severity error;



        w_instruction <= "00000000000000001000000001100111";        -- JR x1 or JALR x0, x1, 0
        wait for real(clock_period)*4.0 * 1 ns;
        assert(w_reg_file_read_address_0 = w_instruction(19 downto 15)) report "Fail test JALR reg_file_read_address_0" severity error;
        assert(w_reg_file_read_address_1 = "00000") report "Fail test JALR w_reg_file_read_address_1" severity error;
        assert(w_reg_file_write = '1') report "Fail test JALR w_reg_file_write" severity error;
        assert(w_reg_file_write_address = w_instruction(11 downto 7)) report "Fail test w_reg_file_write_address" severity error;
        assert(w_immediate = std_logic_vector(shift_right(signed(w_instruction(31 downto 20) & "00000000000000000000"), 20))) report "Fail test JALR w_immediate" severity error;
        assert(w_ALU_operation = "0000") report "Fail test JALR w_ALU_operation" severity error;
        assert(w_ALU_branch = '0') report "Fail test JALR w_ALU_branch" severity error;
        assert(w_ALU_branch_control = "000") report "Fail test JALR w_ALU_branch_control" severity error;
        assert(w_JTU_mux_sel = '1') report "Fail test JALR w_JTU_mux_sel" severity error;
        assert(w_data_format = "000") report "Fail test JALR w_data_format" severity error;
        assert(w_datamem_write = '0') report "Fail test JALR w_datamem_write" severity error;
        assert(w_jump_flag = '1') report "Fail test JALR w_jump_flag" severity error;
        assert(w_mux0_sel = "10") report "Fail test JALR w_mux0_sel" severity error;
        assert(w_mux1_sel = '0') report "Fail test JALR w_mux1_sel" severity error;


        w_instruction <= "00000000000000000001000010010111";        -- AUIPC x1,1
        wait for real(clock_period)*4.0 * 1 ns;
        assert(w_reg_file_read_address_0 = "00000") report "Fail test AUIPC reg_file_read_address_0" severity error;
        assert(w_reg_file_read_address_1 = "00000") report "Fail test AUIPC w_reg_file_read_address_1" severity error;
        assert(w_reg_file_write = '1') report "Fail test AUIPC w_reg_file_write" severity error;
        assert(w_reg_file_write_address = w_instruction(11 downto 7)) report "Fail test AUIPC w_reg_file_write_address" severity error;
        assert(w_immediate = std_logic_vector(w_instruction(31 downto 12) & "000000000000")) report "Fail test AUIPC w_immediate" severity error;
        assert(w_ALU_operation = "0000") report "Fail test AUIPC w_ALU_operation" severity error;
        assert(w_ALU_branch = '0') report "Fail test AUIPC w_ALU_branch" severity error;
        assert(w_ALU_branch_control = "000") report "Fail test AUIPC w_ALU_branch_control" severity error;
        assert(w_JTU_mux_sel = '0') report "Fail test AUIPC w_JTU_mux_sel" severity error;
        assert(w_data_format = "000") report "Fail test AUIPC w_data_format" severity error;
        assert(w_datamem_write = '0') report "Fail test AUIPC w_datamem_write" severity error;
        assert(w_jump_flag = '0') report "Fail test AUIPC w_jump_flag" severity error;
        assert(w_mux0_sel = "00") report "Fail test AUIPC w_mux0_sel" severity error;
        assert(w_mux1_sel = '0') report "Fail test AUIPC w_mux1_sel" severity error;
        
        
    end process;

end beh;