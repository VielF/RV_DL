library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.TEXTIO.all;
use work.all;

entity tb_ALU_RV is
end tb_ALU_RV; 

architecture behaviour of tb_ALU_RV is

    signal w_input_0             : std_logic_vector(31 downto 0) := x"00000000";
    signal w_input_1             : std_logic_vector(31 downto 0) := x"00000000";
    signal w_operation           : std_logic_vector(3 downto 0)  := "0000";
    signal w_branch              : std_logic := '0';
    signal w_ALU_branch_control  : std_logic_vector(2 downto 0) := "000";
    signal w_ALU_branch_response : std_logic;
    signal w_ALU_output          : std_logic_vector(31 downto 0);
  
begin

-- clock and reset

    DUT_mux: entity work.ALU
	port map(
		input_0             => w_input_0            , --
        input_1             => w_input_1            , --: in std_logic_vector(31 downto 0);
		operation           => w_operation          , --: in std_logic_vector(3 downto 0);
		branch              => w_branch             , --: in std_logic;
		ALU_branch_control  => w_ALU_branch_control , --: in std_logic_vector(2 downto 0);
		ALU_branch_response => w_ALU_branch_response, --: out std_logic;
		ALU_output          => w_ALU_output          -- : out std_logic_vector(31 downto 0)
	);


    tb_process : process 
    begin
       wait for 1 ns;
       w_input_0             <= x"00000100";        
       w_input_1             <= x"00000100";
       w_operation           <= "0000"; 
       w_branch              <= '0';  
       w_ALU_branch_control  <= "000";  
       wait for 1 ns;

       w_input_0             <= x"00000100";        
       w_input_1             <= x"00000100";
       w_operation           <= "0000"; 
       w_branch              <= '1';  
       w_ALU_branch_control  <= "000";
       wait for 1 ns;


    end process;

	

end behaviour;