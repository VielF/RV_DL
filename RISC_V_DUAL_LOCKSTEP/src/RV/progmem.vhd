library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity progmem is
	port (
		address : in std_logic_vector(15 downto 0);
		clock : in std_logic;
		output_data : out std_logic_vector(31 downto 0)
	);
end entity progmem;


-- architecture behavioural_all_not_jump of progmem is
-- 	begin
-- 		myROM: process(clock,address) is
-- 		begin
-- 			if (rising_edge(clock)) then
-- 				case address is
-- 					--addi x11, zero, 5 #Addition immediate
--                     --addi x16, zero, 5 #Addition immediate
--                     --addi x20, zero, 2 #Addition immediate
--                     --andi x12, x11, 5 #AND immediate
--                     --xori x13, x11, 5 #XOR immediate
--                     --ori  x14, x11, 5 #OR immediate – 
--                     --sb x11, 4(zero) #Store byte
--                     --sw x11, 8(zero) #Store word
--                     --lui x11, 5 #Load immediate
--                     --lb x15, 4(zero) #Load byte
--                     --lw x16, 8(zero) #Load word
--                     --add x16, x11, x16 #Addition
--                     --sub x16, x11, x16 #Subtract
--                     --and x12, x12, x11 #AND
--                     --xor x13, x13, x11 #XOR – 
--                     --or x14, x14, x11 #OR – 
--                     --sll x21, x11, x20 #Shift left logical – 
--                     --sll x22, x11, x20 #Shift right logical – 
--                     --slt x23, x11, x20 #Set less than
-- 					when x"0000"   => output_data <= "00000000010100000000010110010011";  
-- 					when x"0004"   => output_data <= "00000000010100000000100000010011"; 
-- 					when x"0008"   => output_data <= "00000000001000000000101000010011"; 
-- 					when x"000C"   => output_data <= "00000000010101011111011000010011"; 
-- 					when x"0010"   => output_data <= "00000000010101011100011010010011"; 
-- 					when x"0014"   => output_data <= "00000000010101011110011100010011"; 
-- 					when x"0018"   => output_data <= "00000000101100000000001000100011";  
-- 					when x"001C"   => output_data <= "00000000101100000010010000100011"; 
-- 					when x"0020"   => output_data <= "00000000000000000101010110110111"; 
-- 					when x"0024"   => output_data <= "00000000010000000000011110000011"; 
-- 					when x"0028"   => output_data <= "00000000100000000010100000000011"; 
-- 					when x"002C"   => output_data <= "00000001000001011000100000110011"; 
-- 					when x"0030"   => output_data <= "01000001000001011000100000110011";  
-- 					when x"0034"   => output_data <= "00000000101101100111011000110011"; 
-- 					when x"0038"   => output_data <= "00000000101101101100011010110011"; 
-- 					when x"003C"   => output_data <= "00000000101101110110011100110011"; 
-- 					when x"0040"   => output_data <= "00000001010001011001101010110011"; 
-- 					when x"0044"   => output_data <= "00000001010001011001101100110011"; 
-- 					when x"0048"   => output_data <= "00000000101110100010101110110011"; 
-- 					when others => output_data <= x"00000000"; -- 0
-- 				end case;
-- 			end if;
-- 	end process myROM;
	
-- end architecture behavioural_all_not_jump;

-- architecture behavioural_beq of progmem is
-- begin
-- 	myROM: process(clock,address) is
-- 	begin
--    	if (rising_edge(clock)) then
--        	case address is
-- 					--addi      	x11, zero, 3
-- 					--loop_head:
-- 					--addi      	x12, x12, 3
-- 					--beq      	x11, x12, loop_head
-- 					--addi      	x12, x12, 3
-- 					when x"0000"   => output_data <= "00000000001100000000010110010011"; --0: 
-- 					when x"0004"   => output_data <= "00000000001101100000011000010011"; --4:
-- 					when x"0008"   => output_data <= "11111110110001011000111011100011"; --8:
-- 					when x"000C"   => output_data <= "00000000001101100000011000010011"; --C:
--            		when others => output_data <= x"00000000"; -- 0
--        	end case;
--    	end if;
-- 	end process myROM;

-- end architecture behavioural_beq;


-- architecture behavioural_bne of progmem is
-- 	begin
-- 		myROM: process(clock,address) is
-- 		begin
-- 			if (rising_edge(clock)) then
-- 				case address is
-- 					--addi      	x11, zero, 4
-- 					--loop_head:
-- 					--addi      	x12, x12, 2
-- 					--bne      	x11, x12, loop_head
-- 					--addi      	x12, x12, 4
-- 					when x"0000"   => output_data <= "00000000010000000000010110010011"; --0: 
-- 					when x"0004"   => output_data <= "00000000001001100000011000010011"; --4:
-- 					when x"0008"   => output_data <= "11111110110001011001111011100011"; --8:
-- 					when x"000C"   => output_data <= "00000000010001100000011000010011"; --c:
-- 					when others => output_data <= x"00000000"; -- 0
-- 				end case;
-- 			end if;
-- 	end process myROM;
	
-- end architecture behavioural_bne;

-- architecture behavioural_blt of progmem is
-- 	begin
-- 		myROM: process(clock,address) is
-- 		begin
-- 			if (rising_edge(clock)) then
-- 				case address is
-- 					--addi      	x11, zero, 4
-- 					--loop_blt:
-- 					--addi      	x12, x12, 2
-- 					--blt      	x12,x11 , loop_blt
-- 					--addi      	x12, x12, 4
-- 					when x"0000"   => output_data <= "00000000010000000000010110010011"; --0: 
-- 					when x"0004"   => output_data <= "00000000001001100000011000010011"; --4:
-- 					when x"0008"   => output_data <= "11111110101101100100111011100011"; --8:
-- 					when x"000C"   => output_data <= "00000000010001100000011000010011"; --c:
-- 					when others => output_data <= x"00000000"; -- 0
-- 				end case;
-- 			end if;
-- 	end process myROM;
	
-- end architecture behavioural_blt;

-- architecture behavioural_bge of progmem is
-- 	begin
-- 		myROM: process(clock,address) is
-- 		begin
-- 			if (rising_edge(clock)) then
-- 				case address is
-- 					--addi      	x11, zero, 4
-- 					--loop_bge:
-- 					--addi      	x12, x12, 4
-- 					--bge      	x11, x12, loop_bge
-- 					--addi      	x12, x12, 4
-- 					when x"0000"   => output_data <= "00000000010000000000010110010011"; --0: 
-- 					when x"0004"   => output_data <= "00000000010001100000011000010011"; --4:
-- 					when x"0008"   => output_data <= "11111110110001011101111011100011"; --8:
-- 					when x"000C"   => output_data <= "00000000010001100000011000010011"; --c:
-- 					when others => output_data <= x"00000000"; -- 0
-- 				end case;
-- 			end if;
-- 	end process myROM;
	
-- end architecture behavioural_bge;

-- architecture behavioural_jal of progmem is
-- 	begin
-- 		myROM: process(clock,address) is
-- 		begin
-- 			if (rising_edge(clock)) then
-- 				case address is
-- 					    --  li x4, 1
-- 						--    li x5, 1
-- 						--    li x6, 5
-- 						--    li x7, 0
-- 						--func:
-- 						--    addi x7, x7, 1
-- 						--    beq x7, x6, end
-- 						--    jal x1,func
-- 						--end:
-- 						--    addi x7, x7, 1
-- 					when x"0000"   => output_data <= "00000000000100000000001000010011"; --0: 
-- 					when x"0004"   => output_data <= "00000000000100000000001010010011"; --4:
-- 					when x"0008"   => output_data <= "00000000010100000000001100010011"; --8:
-- 					when x"000C"   => output_data <= "00000000000000000000001110010011"; --c:
-- 					when x"0010"   => output_data <= "00000000000100111000001110010011"; --c:
-- 					when x"0014"   => output_data <= "00000000011000111000010001100011"; --c:
-- 					when x"0018"   => output_data <= "11111111100111111111000011101111"; --c:
-- 					when x"001C"   => output_data <= "00000000000100111000001110010011"; --c:
-- 					when others => output_data <= x"00000000"; -- 0
-- 				end case;
-- 			end if;
-- 	end process myROM;
	
-- end architecture behavioural_jal;


-- architecture behavioural_jalr of progmem is
-- 	begin
-- 		myROM: process(clock,address) is
-- 		begin
-- 			if (rising_edge(clock)) then
-- 				case address is
-- 					--jal x20, main
-- 					--func:    
-- 					--	addi x10, zero, 1
-- 					--	jalr x1
-- 					--main:
-- 					--	li x4, 1
-- 					--	li x5, 1
-- 					--	li x6, 1
-- 					--	li x7, 0
-- 					--	jal x1,func
-- 					--	addi x7, x7, 1
-- 					--	beq x7, x6, end
-- 					--end:
-- 					--	addi x7, x7, 1
-- 					when x"0000"   => output_data <= "00000000110000000000101001101111"; --0: 
-- 					when x"0004"   => output_data <= "00000000000100000000010100010011"; --4:
-- 					when x"0008"   => output_data <= "00000000000000001000000011100111"; --8:
-- 					when x"000C"   => output_data <= "00000000000100000000001000010011"; --c:
-- 					when x"0010"   => output_data <= "00000000000100000000001010010011"; --c:
-- 					when x"0014"   => output_data <= "00000000000100000000001100010011"; --c:
-- 					when x"0018"   => output_data <= "00000000000000000000001110010011"; --c:
-- 					when x"001C"   => output_data <= "11111110100111111111000011101111"; --c:
-- 					when x"0020"   => output_data <= "00000000000100111000001110010011"; --c:
-- 					when x"0024"   => output_data <= "00000000011000111000001001100011"; --c:
-- 					when x"0028"   => output_data <= "00000000000100111000001110010011"; --c:
-- 					when others => output_data <= x"00000000"; -- 0
-- 				end case;
-- 			end if;
-- 	end process myROM;
	
-- end architecture behavioural_jalr;


architecture behavioural_fibo of progmem is
	begin
		myROM: process(clock,address) is
		begin
			if (rising_edge(clock)) then
				case address is
					--#fibonacci code
					--#search the n-interation number of fibonacci sequence
					--				
					--#load values
					--li x7, 0 #value of first number to start
					--li x8, 1 #value of second number to start
					--li x9, 0 #aux to calculate
					--li x10, 10 #iterations
					--li x11, 0 #increment to iterations
					--jump_fib:
					--add x9, x7, x8 # calculate the new number
					--addi x12, x9, 0 #force data hazard, not is necessary
					--add x7,zero,x8 # change calculate next value
					--add x8,zero, x9 # change calculate next value
					--addi x11, x11, 1 #increment
					--bne x11, x10, jump_fib
					when x"0000"   => output_data <= "00000000000000000000001110010011";  
					when x"0004"   => output_data <= "00000000000100000000010000010011"; 
					when x"0008"   => output_data <= "00000000000000000000010010010011"; 
					when x"000C"   => output_data <= "00000000101000000000010100010011"; 
					when x"0010"   => output_data <= "00000000000000000000010110010011"; 
					when x"0014"   => output_data <= "00000000100000111000010010110011"; 
					when x"0018"   => output_data <= "00000000000001001000011000010011";  
					when x"001C"   => output_data <= "00000000100000000000001110110011"; 
					when x"0020"   => output_data <= "00000000100100000000010000110011"; 
					when x"0024"   => output_data <= "00000000000101011000010110010011"; 
					when x"0028"   => output_data <= "11111110101001011001011011100011"; 
					when others => output_data <= x"00000000"; -- 0
				end case;
			end if;
	end process myROM;
	
end architecture behavioural_fibo;

configuration config_mem of progmem is
    for behavioural_fibo
    end for;
end configuration config_mem;