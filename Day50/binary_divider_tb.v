module binary_divider_tb;
    reg [7:0] dividend;
    reg [7:0] divisor;
    wire [7:0] quotient;
    wire [7:0] remainder;
    
    binary_divider uut (
        .dividend(dividend),
        .divisor(divisor),
        .quotient(quotient),
        .remainder(remainder)
    );
    
    initial begin
    	$dumpfile("binary_divider_tb.vcd");
    	$dumpvars;
        // Test 1: 15 / 3
        dividend = 8'd15;
        divisor = 8'd3;
        #10;
        
        // Test 2: 28 / 5
        dividend = 8'd28;
        divisor = 8'd5;
        #10;
        
        // Test 3: 100 / 20
        dividend = 8'd100;
        divisor = 8'd20;
        #10;
        
        // Test 4: 123 / 6
        dividend = 8'd123;
        divisor = 8'd6;
        #10;
        
        // Add more test cases if needed
        $finish;
    end
    initial begin
        $monitor("Time = %0d, dividend = %b, divisor = %b, quotient = %b, remainder =%b", $time, dividend, divisor, quotient, remainder);
    end
endmodule

