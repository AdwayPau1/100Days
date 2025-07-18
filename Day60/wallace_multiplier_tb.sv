module wallace_multiplier_tb;
  reg signed [3:0] A;
  reg unsigned [3:0] B;
  wire signed [7:0] P;
  
  wallace_multiplier wta(A,B,P);
  
  initial begin
    $dumpfile("wallace_multiplier_tb.vcd");
    $dumpvars;
    $monitor("A = %d: B = %d --> Product = %d", A, B, P);
    //Note that input A can be signed, but B must be unsigned
    A = 1; B = 0; #3;  // ans = 0
    A = 7; B = 5; #3;  // ans = 35
    A = -5; B = 4; #3; // ans = -20 (Take 2's complement of output)
    A = -3; B = 7; #3; // ans = -21 (Take 2's complement of output)
    A = 9; B = 7; #3;  // (-7)*7 = -49 (Take 2's complement of output)
    A = 7; B = 'hf;    // ans = 105
  end
endmodule
