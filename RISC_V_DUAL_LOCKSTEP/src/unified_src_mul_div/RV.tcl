#quit -sim
#project close
#project open /home/desktop/Desktop/RV_DL-RNS/RVDL_RNS
project compileall
vsim work.tb_rv
add wave -divider TB_SIGNALS
add wave -divider CLK_RST
add wave -color "light blue" -group "CLK_RST" -position end  sim:/tb_rv/clk
add wave -color "light blue" -group "CLK_RST" -position end  sim:/tb_rv/rst
add wave -divider BASIC_RV_INSTRUCTIONS
add wave -hex -color "yellow" -group "OUT_REGISTERS" -position end  sim:/tb_rv/w_debug_pc_output
add wave -hex -color "yellow" -group "OUT_REGISTERS" -position end  sim:/tb_rv/w_debug_instruction 
add wave -hex -color "yellow" -group "OUT_REGISTERS" -position end  sim:/tb_rv/w_debug_regfile_x31_output
add wave -hex -color "yellow" -group "OUT_REGISTERS" -position end  sim:/tb_rv/w_debug_regfile_x1_output
add wave -hex -color "yellow" -group "OUT_REGISTERS" -position end  sim:/tb_rv/w_debug_regfile_x2_output
add wave -color "aqua" -divider BASIC_RV_ALU_OP
add wave -hex -color "aqua" -group "ALU" -position end  sim:/tb_rv/w_debug_ALU_operation
add wave -hex -color "aqua" -group "ALU" -position end  sim:/tb_rv/w_debug_immediate
add wave -hex -color "aqua" -group "ALU" -position end  sim:/tb_rv/w_debug_ALU_input_0
add wave -hex -color "aqua" -group "ALU" -position end  sim:/tb_rv/w_debug_ALU_input_1
add wave -hex -color "aqua" -group "ALU" -position end  sim:/tb_rv/w_debug_ALU_output
add wave -hex -color "aqua" -group "ALU" -position end  sim:/tb_rv/w_debug_ALU_output_MEM_WB
add wave -hex -color "aqua" -group "ALU" -position end  sim:/tb_rv/w_debug_ALU_output_EX_MEM
add wave -color "blueviolet" -divider BASIC_RV_REG
add wave -hex -color "blueviolet" -group "REG" -position end  sim:/tb_rv/w_debug_regfile_write
add wave -hex -color "blueviolet" -group "REG" -position end  sim:/tb_rv/w_debug_reg_file_read_address_0
add wave -hex -color "blueviolet" -group "REG" -position end  sim:/tb_rv/w_debug_reg_file_read_address_1
add wave -hex -color "blueviolet" -group "REG" -position end  sim:/tb_rv/w_debug_register_file_output_0
add wave -hex -color "blueviolet" -group "REG" -position end  sim:/tb_rv/w_debug_register_file_output_1
add wave -hex -color "blueviolet" -group "REG" -position end  sim:/tb_rv/w_debug_reg_file_write_MEM_WB
add wave -hex -color "blueviolet" -group "REG" -position end  sim:/tb_rv/w_debug_reg_file_write_address_MEM_WB
add wave -hex -color "blueviolet" -group "REG" -position end  sim:/tb_rv/w_debug_reg_file_read_address_0_ID_EXE
add wave -hex -color "blueviolet" -group "REG" -position end  sim:/tb_rv/w_debug_reg_file_write_address_EX_MEM
add wave -hex -color "blueviolet" -group "REG" -position end  sim:/tb_rv/w_debug_register_file_output_0_ID_EX
add wave -hex -color "blueviolet" -group "REG" -position end  sim:/tb_rv/w_debug_register_file_output_1_ID_EX
config wave -signalnamewidth 1
run 1000 ns
wave zoom full
