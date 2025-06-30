module tb_top;
reg a, b;
wire D, B;
half_subtractor hs(a, b, D, B);
initial begin
$dumpfile("waveform.vcd");
$dumpvars(0, tb_top);
$monitor("At time %0t:", $time, a,b,D,B);
a = 0; b = 0;
#1;
a = 0; b = 1;
#1;
a = 1; b = 0;
#1;
a = 1; b = 1;
#3;
$finish();
end
endmodule
