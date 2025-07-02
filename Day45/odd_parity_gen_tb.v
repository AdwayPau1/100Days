module odd_parity_gen_tb();
reg[3:0]in;
wire p;
odd_parity_gen uut(.p(p),.in(in));
initial
begin
    	$dumpfile("odd_parity_gen_tb.vcd");
    	$dumpvars(0, odd_parity_gen_tb);
in=4'b1010; #10
in=4'b1110; #10
in=4'b0101; #10
in=4'b1011; #10
$finish;
end
endmodule
