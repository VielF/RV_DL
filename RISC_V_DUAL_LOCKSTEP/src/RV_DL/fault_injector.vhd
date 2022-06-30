library ieee;
use ieee.std_logic_1164.all;

entity fault_injector is
	port (
		--i_data      : in std_logic_vector(31 downto 0);
		i_ena_fault     : in std_logic_vector(2 downto 0);
		
		i_im_core       : in std_logic_vector(31 downto 0); 
		i_dm_core       : in std_logic_vector(31 downto 0); 
		i_reg1_rd_core  : in std_logic_vector(31 downto 0); 
		i_reg2_rd_core  : in std_logic_vector(31 downto 0); 
		i_reg1_wr_core  : in std_logic_vector(31 downto 0); 
		i_pc_core       : in std_logic_vector(31 downto 0);
		
		--o_data        : out std_logic_vector(31 downto 0);
		o_im_core       : out std_logic_vector(31 downto 0); 
		o_dm_core       : out std_logic_vector(31 downto 0); 
		o_reg1_rd_core  : out std_logic_vector(31 downto 0); 
		o_reg2_rd_core  : out std_logic_vector(31 downto 0); 
		o_reg1_wr_core  : out std_logic_vector(31 downto 0); 
		o_pc_core       : out std_logic_vector(31 downto 0)
	);
end fault_injector;

architecture description of fault_injector is

begin
	
    --o_data <= i_data when i_ena_fault = '0' else (i_data(31 downto 20) & not(i_data(19 downto 0)));
	o_im_core      <= (i_im_core(31 downto 20) &  not(i_im_core(19 downto 0))) when i_ena_fault = "001" else i_im_core; 
	o_dm_core      <= (i_dm_core(31 downto 20)  &  not(i_dm_core(19 downto 0))) when i_ena_fault = "010" else i_dm_core; 
	o_reg1_rd_core <= (i_reg1_rd_core(31 downto 20)  &  not(i_reg1_rd_core(19 downto 0))) when i_ena_fault = "011" else i_reg1_rd_core; 
	o_reg2_rd_core <= (i_reg2_rd_core(31 downto 20)  &  not(i_reg2_rd_core(19 downto 0))) when i_ena_fault = "100" else i_reg2_rd_core; 
	o_reg1_wr_core <= (i_reg1_wr_core(31 downto 20)  &  not(i_reg1_wr_core(19 downto 0))) when i_ena_fault = "101" else i_reg1_wr_core; 
	o_pc_core      <= (i_pc_core(31 downto 20)  &  not(i_pc_core(19 downto 0))) when i_ena_fault = "110" else i_pc_core; 

end description;