module tb;
reg [3:0] A, B;
wire A_grt_B, A_less_B, A_eq_B;
comparator comp(A, B, A_grt_B, A_less_B, A_eq_B);
initial begin
$dumpfile("waveform.vcd");
$dumpvars;
$monitor("A = %0h, B = %0h -> A_grt_B = %0b, A_less_B = %0b, A_eq_B =%0b", A, B, A_grt_B, A_less_B, A_eq_B);
repeat(5) begin
A=$random; B=$random; #1;
end
end
endmodule
