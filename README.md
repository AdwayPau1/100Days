# 100 Days of RTL – Simulation and Synthesis

This project implements and tests various simple SystemVerilog modules using simulation tools (Icarus Verilog and GTKWave) and performs RTL synthesis using Yosys.

---

## 🔧 Makefile Targets

### 🧪 `make sim`
Runs the simulation by compiling and executing the testbench:
- Compiles `module.sv` and `module_tb.sv` into a binary `vvpmodule`
- Executes the binary to generate `waveform.vcd`

```bash
make sim
```

---

### 🌊 `make waves`
Opens the generated waveform file (`waveform.vcd`) in GTKWave.

```bash
make waves
```

---

### 🛠 `make rtl`
Generates and runs a Yosys script to perform RTL synthesis on `module.sv`.

- The script includes:
  - Reading the Verilog file
  - Synthesizing with `-top module`
  - Using a custom Liberty file for mapping
  - Running `show` to visualize the synthesized design

```bash
make rtl
```

> 📝 Note: The Liberty file path is hardcoded as:
> `../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib`

---

### 🧼 `make clean`
Cleans up generated files:
- `vvpmodule`
- `waveform.vcd`
- `ripple_carry.sh`

```bash
make clean
```

---

## 📦 Dependencies

- [Icarus Verilog](https://github.com/steveicarus/iverilog)
- [GTKWave](http://gtkwave.sourceforge.net/)
- [Yosys](https://yosyshq.net/yosys/)

Make sure these tools are installed and available in your system `PATH`.

---

## 📁 File Structure

```
.
├── Makefile
├── module.sv             # RTL module
├── module_tb.sv          # Testbench
├── waveform.vcd          # (Generated) Waveform output
├── vvpmodule             # (Generated) Simulation output
└── module.sh             # (Generated) YOSYS Synthesis Script
```

---


## 🙋‍♂️ Author

Adway Paul
