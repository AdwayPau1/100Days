module TB;
reg clk, rst;
wire [3:0]op;
LFSR lfsr1(clk, rst, op);
initial begin
$monitor("op=%b",op);
clk = 0; rst = 1;
#5 rst = 0;
#50; $finish;
end
always #2 clk=~clk;
initial begin
$dumpfile("waveform.vcd"); 
$dumpvars;
end
endmodule
