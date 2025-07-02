module odd_parity_check_tb();
reg[3:0]in;
reg p;
wire error;
odd_parity_check uut(in,p,error);
initial
begin
    	$dumpfile("odd_parity_check_tb.vcd");
    	$dumpvars(0, odd_parity_check_tb);
in=4'b0101; p=1'b0; #10
in=4'b1101; p=1'b1; #10
in=4'b0111; p=1'b0; #10
in=4'b1001; p=1'b1; #10
$finish;
end
endmodule
