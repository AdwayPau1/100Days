module tb;
reg [1:0] sel;
reg i;
wire y0,y1,y2,y3;
demux_1_4 demux(sel, i, y0, y1, y2, y3);
initial begin
$dumpfile("waveform.vcd");
$dumpvars;
$monitor("sel = %b, i = %b -> y0 = %0b, y1 = %0b ,y2 = %0b, y3 = %0b",sel,i, y0,y1,y2,y3);
sel=2'b00; i=0; #1;
sel=2'b00; i=1; #1;
sel=2'b01; i=0; #1;
sel=2'b01; i=1; #1;
sel=2'b10; i=0; #1;
sel=2'b10; i=1; #1;
sel=2'b11; i=0; #1;
sel=2'b11; i=1; #1;
end
endmodule
