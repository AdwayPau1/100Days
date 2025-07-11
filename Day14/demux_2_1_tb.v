module demux_tb;
reg sel, i;
wire y0, y1;
demux_2_1 demux(sel, i, y0, y1);
initial begin
$dumpfile("waveform.vcd");
$dumpvars;
$monitor("sel = %h: i = %h --> y0 = %h, y1 = %h", sel, i, y0, y1);
sel=0; i=0; #1;
sel=0; i=1; #1;
sel=1; i=0; #1;
sel=1; i=1; #1;
end
endmodule
