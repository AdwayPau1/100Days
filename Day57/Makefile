MODULE=digital_lock

.PHONY:sim
sim: digital_lock_tb.vcd

.PHONY:waves
waves: digital_lock_tb.vcd
	@echo
	@echo "### WAVES ###"
	gtkwave digital_lock_tb.vcd

digital_lock_tb.vcd: vvp$(MODULE)
	@echo
	@echo "### BUILDING SIM ###"
	vvp vvp$(MODULE)

vvp$(MODULE): $(MODULE).v $(MODULE)_tb.v
	@echo
	@echo "### COMPILING ###"
	iverilog -g2012 -Wall -o vvp$(MODULE) $(MODULE).v $(MODULE)_tb.v

.PHONY: rtl
rtl: $(MODULE).sh
	@echo
	@echo "### RUNNING YOSYS ###"
	sh $(MODULE).sh
$(MODULE).sh: 
	echo "#!/bin/bash" > $(MODULE).sh
	echo "yosys -p \"" >> $(MODULE).sh
	echo "read_verilog $(MODULE).v" >> $(MODULE).sh
	echo "synth -top $(MODULE)" >> $(MODULE).sh
	echo "abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib" >> $(MODULE).sh
	echo "show $(MODULE)" >> $(MODULE).sh
	echo "\"" >> $(MODULE).sh
# write synthesized design
#write_verilog -assert synth_ripple_carry_adder.v

.PHONY: clean
clean:
	rm -rf vvp$(MODULE)
	rm -rf digital_lock_tb.vcd
	rm -rf $(MODULE).sh


