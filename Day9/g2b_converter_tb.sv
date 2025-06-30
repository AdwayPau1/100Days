module TB;
reg [3:0] gray, binary;
g2b_converter g2b(gray, binary);
initial begin
$dumpfile("waveform.vcd");
$dumpvars;
$monitor("gray = %b --> binary = %b", gray, binary);
gray = 4'b1110; #1;
gray = 4'b0100; #1;
gray = 4'b0111; #1;
gray = 4'b1010; #1;
gray = 4'b1000;
end
endmodule
