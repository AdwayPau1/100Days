module tb_top;
reg a, b, c;
wire s, c_out;
full_adder fa(a, b, c, s, c_out);
initial begin
$dumpfile("waveform.vcd");
$dumpvars(0, tb_top);
$monitor("At time %0t:",$time,a,b,c,s,c_out);
a = 0; b = 0; c = 0; #1;
a = 0; b = 0; c = 1; #1;
a = 0; b = 1; c = 0; #1;
a = 0; b = 1; c = 1; #1;
a = 1; b = 0; c = 0; #1;
a = 1; b = 0; c = 1; #1;
a = 1; b = 1; c = 0; #1;
a = 1; b = 1; c = 1; #3;
$finish();
end
endmodule
