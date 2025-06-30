MODULE=synchronous_fifo

.PHONY:sim
sim: waveform.vcd waveform2.vcd

.PHONY:waves
waves: waveform.vcd
	@echo
	@echo "### WAVES ###"
	gtkwave waveform.vcd 
	gtkwave waveform2.vcd

waveform.vcd: vvp1$(MODULE) vvp2$(MODULE)
	@echo
	@echo "### BUILDING SIM ###"
	vvp vvp1$(MODULE)
	vvp vvp2$(MODULE)

vvp1$(MODULE) vvp2$(MODULE): $(MODULE).sv $(MODULE)_tb1.sv $(MODULE)_tb2.sv
	@echo
	@echo "### COMPILING ###"
	iverilog -Wall -g2012 -o vvp1$(MODULE) $(MODULE).sv $(MODULE)_tb1.sv
	iverilog -Wall -g2012 -o vvp2$(MODULE) $(MODULE).sv $(MODULE)_tb2.sv
.PHONY: rtl
rtl: $(MODULE).sh
	@echo
	@echo "### RUNNING YOSYS ###"
	sh $(MODULE).sh
$(MODULE).sh: 
	echo "#!/bin/bash" > $(MODULE).sh
	echo "yosys -p \"" >> $(MODULE).sh
	echo "read_verilog -sv $(MODULE).sv" >> $(MODULE).sh
	echo "synth -top $(MODULE)" >> $(MODULE).sh
	echo "abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib" >> $(MODULE).sh
	echo "show $(MODULE)" >> $(MODULE).sh
	echo "\"" >> $(MODULE).sh
# write synthesized design
#write_verilog -assert synth_ripple_carry_adder.v

.PHONY: clean
clean:
	rm -rf vvp1$(MODULE) vvp2$(MODULE)
	rm -rf waveform.vcd waveform2.vcd
	rm -rf $(MODULE).sh


