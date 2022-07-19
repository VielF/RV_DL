#quit -sim
#project close
project open /home/desktop/Desktop/RV_DL-RNS/RVDL_RNS
project compileall
vsim work.tb_rv_dl
add wave -divider TB_SIGNALS
add wave -divider CLK_RST
add wave -color "light blue" -group "CLK_RST" -position end  sim:/tb_rv_dl/w_aclk
add wave -color "light blue" -group "CLK_RST" -position end  sim:/tb_rv_dl/w_rst_n
add wave -divider RVDL_FAULT_INJECTIONS
add wave -hex -color "yellow" -group "RVDL_FAULT_INJECTIONS" -position end  sim:/tb_rv_dl/w_FAULT_INJECTION_SIM_RV0
add wave -hex -color "yellow" -group "RVDL_FAULT_INJECTIONS" -position end  sim:/tb_rv_dl/w_FAULT_INJECTION_SIM_RV1
add wave -color "aqua" -divider CORE_0_SIGNALS
add wave -hex -color "aqua" -group "CORE_0_SIGNALS" -position end  sim:/tb_rv_dl/w_debug_im_core0_debug
add wave -hex -color "aqua" -group "CORE_0_SIGNALS" -position end  sim:/tb_rv_dl/w_debug_dm_core0_debug
add wave -hex -color "aqua" -group "CORE_0_SIGNALS" -position end  sim:/tb_rv_dl/w_debug_pc_core0_debug
add wave -hex -color "aqua" -group "CORE_0_SIGNALS" -position end  sim:/tb_rv_dl/w_debug_reg1_rd_core0_debug
add wave -hex -color "aqua" -group "CORE_0_SIGNALS" -position end  sim:/tb_rv_dl/w_debug_reg2_rd_core0_debug
add wave -hex -color "aqua" -group "CORE_0_SIGNALS" -position end  sim:/tb_rv_dl/w_debug_reg1_wr_core0_debug
add wave -color "aqua" -divider CORE_1_SIGNALS
add wave -hex -color "greenyellow" -group "CORE_1_SIGNALS" -position end  sim:/tb_rv_dl/w_debug_im_core0_debug
add wave -hex -color "greenyellow" -group "CORE_1_SIGNALS" -position end  sim:/tb_rv_dl/w_debug_dm_core0_debug
add wave -hex -color "greenyellow" -group "CORE_1_SIGNALS" -position end  sim:/tb_rv_dl/w_debug_pc_core0_debug
add wave -hex -color "greenyellow" -group "CORE_1_SIGNALS" -position end  sim:/tb_rv_dl/w_debug_reg1_rd_core0_debug
add wave -hex -color "greenyellow" -group "CORE_1_SIGNALS" -position end  sim:/tb_rv_dl/w_debug_reg2_rd_core0_debug
add wave -hex -color "greenyellow" -group "CORE_1_SIGNALS" -position end  sim:/tb_rv_dl/w_debug_reg1_wr_core0_debug
add wave -color "blueviolet" -divider DETECTOR_ACTION
add wave -hex -color "blueviolet" -group "DETECTOR_ACTION" -position end  sim:/tb_rv_dl/w_debug_RST_RV_debug
add wave -hex -color "blueviolet" -group "DETECTOR_ACTION" -position end  sim:/tb_rv_dl/w_debug_MUX_IM_CTRL_debug
config wave -signalnamewidth 1
run 1000 ns
wave zoom full
