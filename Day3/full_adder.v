module half_addr(input a, b, output s, c);
assign s = a^b;
assign c = a & b;
endmodule
module full_adder(input a, b, cin, output s_out, c_out);
wire s, c0, c1;
half_addr HA1 (a, b, s, c0);
half_addr HA2 (s, cin, s_out, c1);
assign c_out = c0 | c1;
endmodule
