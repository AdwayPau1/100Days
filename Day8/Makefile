MODULE=b2g_converter

.PHONY:sim
sim: waveform.vcd

.PHONY:waves
waves: waveform.vcd
	@echo
	@echo "### WAVES ###"
	gtkwave waveform.vcd

waveform.vcd: vvp$(MODULE)
	@echo
	@echo "### BUILDING SIM ###"
	vvp vvp$(MODULE)

vvp$(MODULE): $(MODULE).sv $(MODULE)_tb.sv
	@echo
	@echo "### COMPILING ###"
	iverilog -Wall -g2012 -o vvp$(MODULE) $(MODULE).sv $(MODULE)_tb.sv

.PHONY: rtl
rtl: $(MODULE).sh
	@echo
	@echo "### RUNNING YOSYS ###"
	sh $(MODULE).sh
$(MODULE).sh: 
	echo "#!/bin/bash" > $(MODULE).sh
	echo "yosys -p \"" >> $(MODULE).sh
	echo "read_verilog $(MODULE).sv" >> $(MODULE).sh
	echo "synth -top $(MODULE)" >> $(MODULE).sh
	echo "abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib" >> $(MODULE).sh
	echo "show $(MODULE)" >> $(MODULE).sh
	echo "\"" >> $(MODULE).sh
# write synthesized design
#write_verilog -assert synth_ripple_carry_adder.v

.PHONY: clean
clean:
	rm -rf vvp$(MODULE)
	rm -rf waveform.vcd
	rm -rf $(MODULE).sh


