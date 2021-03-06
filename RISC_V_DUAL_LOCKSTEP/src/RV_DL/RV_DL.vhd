library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity RV_DL is
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
end RV_DL;

architecture Behavioral of RV_DL is
	

    signal rst_cores        : std_logic;

    ---- CORE_0 --- 
    signal w_im_core0       : std_logic_vector(31 downto 0);        
    signal w_dm_core0       : std_logic_vector(31 downto 0);  
    signal w_reg1_rd_core0  : std_logic_vector(31 downto 0);   
    signal w_reg2_rd_core0  : std_logic_vector(31 downto 0);   
    signal w_reg1_wr_core0  : std_logic_vector(31 downto 0);   
    signal w_pc_core0       : std_logic_vector(31 downto 0);    
    ---- CORE_1 ---
    signal w_im_core1       : std_logic_vector(31 downto 0);       
    signal w_dm_core1       : std_logic_vector(31 downto 0);       
    signal w_reg1_rd_core1  : std_logic_vector(31 downto 0);         
    signal w_reg2_rd_core1  : std_logic_vector(31 downto 0);          
    signal w_reg1_wr_core1  : std_logic_vector(31 downto 0);          
    signal w_pc_core1       : std_logic_vector(31 downto 0);

---------------------- FAULT INJECTION --------------------------
    ---- CORE_0 --- 
    signal w_im_core0_FJ       : std_logic_vector(31 downto 0);        
    signal w_dm_core0_FJ       : std_logic_vector(31 downto 0);  
    signal w_reg1_rd_core0_FJ  : std_logic_vector(31 downto 0);   
    signal w_reg2_rd_core0_FJ  : std_logic_vector(31 downto 0);   
    signal w_reg1_wr_core0_FJ  : std_logic_vector(31 downto 0);   
    signal w_pc_core0_FJ       : std_logic_vector(31 downto 0);    
    ---- CORE_1 ---
    signal w_im_core1_FJ       : std_logic_vector(31 downto 0);       
    signal w_dm_core1_FJ       : std_logic_vector(31 downto 0);       
    signal w_reg1_rd_core1_FJ  : std_logic_vector(31 downto 0);         
    signal w_reg2_rd_core1_FJ  : std_logic_vector(31 downto 0);          
    signal w_reg1_wr_core1_FJ  : std_logic_vector(31 downto 0);          
    signal w_pc_core1_FJ       : std_logic_vector(31 downto 0);   
          
    ---- SINGAL PRO
    signal w_RST_RV         : std_logic;           
    signal w_MUX_IM_CTRL    : std_logic;          

    ---- IM BACKUP        
    signal w_promem_output_bakcup       : std_logic_vector(31 downto 0);
begin    

    u_FJ_CORE0 : entity work.fault_injector
        port map(
            i_ena_fault     => i_FAULT_INJECTION_SIM_RV0,
            
            i_im_core       => w_im_core0     ,
            i_dm_core       => w_dm_core0     ,
            i_reg1_rd_core  => w_reg1_rd_core0,
            i_reg2_rd_core  => w_reg2_rd_core0,
            i_reg1_wr_core  => w_reg1_wr_core0,
            i_pc_core       => w_pc_core0     ,
            
            o_im_core       => w_im_core0_FJ     ,
            o_dm_core       => w_dm_core0_FJ     ,
            o_reg1_rd_core  => w_reg1_rd_core0_FJ,
            o_reg2_rd_core  => w_reg2_rd_core0_FJ,
            o_reg1_wr_core  => w_reg1_wr_core0_FJ,
            o_pc_core       => w_pc_core0_FJ     
        );

    u_FJ_CORE1 : entity work.fault_injector
        port map(
            i_ena_fault     => i_FAULT_INJECTION_SIM_RV1,
            
            i_im_core       => w_im_core1     ,
            i_dm_core       => w_dm_core1     ,
            i_reg1_rd_core  => w_reg1_rd_core1,
            i_reg2_rd_core  => w_reg2_rd_core1,
            i_reg1_wr_core  => w_reg1_wr_core1,
            i_pc_core       => w_pc_core1     ,
            
            o_im_core       => w_im_core1_FJ     ,
            o_dm_core       => w_dm_core1_FJ     ,
            o_reg1_rd_core  => w_reg1_rd_core1_FJ,
            o_reg2_rd_core  => w_reg2_rd_core1_FJ,
            o_reg1_wr_core  => w_reg1_wr_core1_FJ,
            o_pc_core       => w_pc_core1_FJ     
        );

    u_FAULT_DETECTOR : entity work.top_detector 
        generic map(
            NUMBER_FAULTS => NUMBER_FAULTS
        )
        port map (
            i_clk           => i_clk,
            i_rst_n         => i_rst_n,
            ---- CORE_0 -----
            i_im_core0      => w_im_core0_FJ,
            i_dm_core0      => w_dm_core0_FJ,
            i_reg1_rd_core0 => w_reg1_rd_core0_FJ,
            i_reg2_rd_core0 => w_reg2_rd_core0_FJ,
            i_reg1_wr_core0 => w_reg1_wr_core0_FJ,
            i_pc_core0      => w_pc_core0_FJ,
            ---- CORE_1 -----
            i_im_core1      => w_im_core1_FJ,
            i_dm_core1      => w_dm_core1_FJ,
            i_reg1_rd_core1 => w_reg1_rd_core1_FJ,
            i_reg2_rd_core1 => w_reg2_rd_core1_FJ,
            i_reg1_wr_core1 => w_reg1_wr_core1_FJ,
            i_pc_core1      => w_pc_core1_FJ,
            --MUX_IM_CTRL     => ,
            ---- SINGAL PROTECTION CONTROL -------
            o_RST_RV        => w_RST_RV,
            o_MUX_IM_CTRL   => w_MUX_IM_CTRL
        );
    
        rst_cores <= not(i_rst_n) or w_RST_RV;

        u_RV_0 : entity work.microcontroller
            port map (
                clock                                   => i_clk,
                reset                                   => rst_cores,
                debug_pc_output                         => w_pc_core0,
                debug_regfile_x31_output                => open,
                debug_regfile_x1_output                 => open,
                debug_regfile_x2_output                 => open,
                debug_ALU_output                        => open,
                debug_regfile_write                     => open,
                debug_ALU_input_0                       => open,
                debug_ALU_input_1                       => open,
                debug_reg_file_read_address_0           => open,
                debug_reg_file_read_address_1           => open,
                debug_mux0_sel                          => open,
                debug_immediate                         => open,
                debug_ALU_operation                     => open,
                debug_forward_mux_0                     => open,
                debug_forward_mux_1                     => open,
                debug_reg_file_read_address_0_ID_EXE    => open,
                debug_reg_file_write_address_EX_MEM     => open,
                debug_mux0_sel_MEM_WB                   => open,
                debug_reg_file_write_MEM_WB             => open,
                debug_reg_file_write_address_MEM_WB     => open,
                debug_ALU_output_MEM_WB                 => open,
                debug_ALU_output_EX_MEM                 => open,
                debug_register_file_output_0            => w_reg1_rd_core0,
                debug_register_file_output_1            => w_reg2_rd_core0,
                debug_register_file_output_0_ID_EX      => open,
                debug_register_file_output_1_ID_EX      => open,
                debug_instruction                       => w_im_core0,

                -- NEW NET TO RV_DL
		        debug_datamem_output                   => w_dm_core0,
		        debug_reg_wr_output                    => w_reg1_wr_core0,

		        -- PORTS OF MUX TO USE IM BACKUP
		        progmem_output_backup                  => w_promem_output_bakcup,
		        MUX_IM_CTRL                            => w_MUX_IM_CTRL
            );

        u_RV_01 : entity work.microcontroller
            port map (
                clock                                   => i_clk,
                reset                                   => rst_cores,
                debug_pc_output                         => w_pc_core1,
                debug_regfile_x31_output                => open,
                debug_regfile_x1_output                 => open,
                debug_regfile_x2_output                 => open,
                debug_ALU_output                        => open,
                debug_regfile_write                     => open,
                debug_ALU_input_0                       => open,
                debug_ALU_input_1                       => open,
                debug_reg_file_read_address_0           => open,
                debug_reg_file_read_address_1           => open,
                debug_mux0_sel                          => open,
                debug_immediate                         => open,
                debug_ALU_operation                     => open,
                debug_forward_mux_0                     => open,
                debug_forward_mux_1                     => open,
                debug_reg_file_read_address_0_ID_EXE    => open,
                debug_reg_file_write_address_EX_MEM     => open,
                debug_mux0_sel_MEM_WB                   => open,
                debug_reg_file_write_MEM_WB             => open,
                debug_reg_file_write_address_MEM_WB     => open,
                debug_ALU_output_MEM_WB                 => open,
                debug_ALU_output_EX_MEM                 => open,
                debug_register_file_output_0            => w_reg1_rd_core1,
                debug_register_file_output_1            => w_reg2_rd_core1,
                debug_register_file_output_0_ID_EX      => open,
                debug_register_file_output_1_ID_EX      => open,
                debug_instruction                       => w_im_core1,

                -- NEW NET TO RV_DL
		        debug_datamem_output                   => w_dm_core1,
		        debug_reg_wr_output                    => w_reg1_wr_core1,

		        -- PORTS OF MUX TO USE IM BACKUP
		        progmem_output_backup                  => w_promem_output_bakcup,
		        MUX_IM_CTRL                            => w_MUX_IM_CTRL
            );


        u_IM_BACKUP: entity work.progmem_interface 
            port map(
                clock        => i_clk,
                byte_address => w_im_core0,
                output_data  => w_promem_output_bakcup
            );
        

        o_debug_im_core0_debug      <= w_im_core0     ;
        o_debug_dm_core0_debug      <= w_dm_core0     ;
        o_debug_reg1_rd_core0_debug <= w_reg1_rd_core0;
        o_debug_reg2_rd_core0_debug <= w_reg2_rd_core0;
        o_debug_reg1_wr_core0_debug <= w_reg1_wr_core0;
        o_debug_pc_core0_debug      <= w_pc_core0     ;
        o_debug_im_core1_debug      <= w_im_core1     ;
        o_debug_dm_core1_debug      <= w_dm_core1     ;
        o_debug_reg1_rd_core1_debug <= w_reg1_rd_core1;
        o_debug_reg2_rd_core1_debug <= w_reg2_rd_core1;
        o_debug_reg1_wr_core1_debug <= w_reg1_wr_core1;
        o_debug_pc_core1_debug      <= w_pc_core1     ;
        o_debug_RST_RV_debug        <= w_RST_RV      ;
        o_debug_MUX_IM_CTRL_debug   <= w_MUX_IM_CTRL ;
end architecture Behavioral;