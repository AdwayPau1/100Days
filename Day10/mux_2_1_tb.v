module mux_2_1_tb;
reg i0, i1, sel;
wire y;
mux_2_1 mux(sel, i0, i1, y);
initial begin
$dumpfile("waveform.vcd");
$dumpvars(0, mux_2_1_tb);
$monitor("sel = %h: i0 = %h, i1 = %h --> y = %h", sel, i0, i1, y);
i0 = 0; i1 = 1;
sel = 0;
#1;
sel = 1;
end
endmodule
