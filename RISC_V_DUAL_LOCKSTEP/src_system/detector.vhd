library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity detector is
    generic (
        NUMBER_FAULTS : natural := 7
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
        i_pc_core1 : in std_logic_vector(31 downto 0);

        ---- SINGAL PROTECTION CONTROL -------
        i_COUNTER_COUNT_FAULTS      : in  std_logic_vector(3 downto 0); 
        o_RST_RV                    : out std_logic;
        o_ENA_REG_MUX_IM_CTRL       : out std_logic;
        o_ENA_COUNTER_COUNT_FAULTS  : out std_logic;
	);
end entity detector;

architecture Behavioral of detector is
	type operational_states is (start, detection, diff_detetction, im_detection, set_im_backup);
	signal current_state, next_state : operational_states := start;

begin

	p_actual_state : process (i_clk, i_rst_n)
	begin
		if (i_rst_n = '0') then
			current_state <= start;
		elsif rising_edge(i_clk) then
			current_state <= next_state;
		end if;
	end process;

	p_next_state : process (current_state, i_reg1_rd_core0, i_reg2_rd_core0, i_reg1_wr_core0, i_pc_core0,
                                           i_reg1_rd_core1, i_reg2_rd_core1, i_reg1_wr_core1, i_pc_core1,
                                           i_im_core0, i_im_core1, i_dm_core0, i_dm_core1)
	begin
		case (current_state) is
			when start =>
                next_state <= detection;


            when detection =>
                if i_reg1_rd_core0 = i_reg1_rd_core1 or 
                   i_reg2_rd_core0 = i_reg2_rd_core1 or
                   i_reg1_wr_core0 = i_reg1_wr_core1 or
                   i_dm_core0 = i_im_core1 or
                   i_pc_core0 = i_pc_core1) then
                    next_state <= diff_detection;
                elsif i_im_core0 = i_im_core1 then
                    next_state <= im_detection;
                else
                    next_state <= detection;
                end if;


            when diff_detection =>
                next_state <= detection;

            when im_detection =>
                if i_COUNTER_COUNT_FAULTS < NUMBER_FAULTS then
                    next_state <= detection;
                else
                    next_state <= set_im_backup;
                end if;

            when set_im_backup =>
                next_state <= detection;

            when others =>
                next_state <= start;
		end case;
	end process;
	
    o_RST_RV <= '1' when (current_state = diff_detection or 
                          current_state = im_detection or 
                          current_state = set_im_backup) else '0';         

    o_ENA_REG_MUX_IM_CTRL <= '1' when current_state = set_im_backup else '0';

    o_ENA_COUNTER_COUNT_FAULTS <= '1' when current_state = im_detection else '0';


end architecture Behavioral;