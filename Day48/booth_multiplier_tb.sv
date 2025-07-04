module booth_multiplier_tb;
    reg signed [3:0] multiplicand, multiplier;
    wire signed [7:0] product;
    
    booth_multiplier uut (
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .product(product)
    );
    
    initial begin
    	$dumpfile("booth_multiplier_tb.vcd");
    	$dumpvars;
        // Test case 1: 3 * -3 = -9
        multiplicand = 4'b0011;  // 3 in decimal
        multiplier = 4'b1101;    // -3 in decimal
        #10;
        
        // Test case 2: -2 * 2 = -4
        multiplicand = 4'b1110;  // -2 in decimal
        multiplier = 4'b0010;    // 2 in decimal
        #10;
        
        // Test case 3: -4 * -4 = 16
        multiplicand = 4'b1100;  // -4 in decimal
        multiplier = 4'b1100;    // -4 in decimal
        #10;
        
        // Test case 4: 7 * 1 = 7
        multiplicand = 4'b0111;  // 7 in decimal
        multiplier = 4'b0001;    // 1 in decimal
        #10;
        $finish;
        
    end
    
    initial begin
        $monitor("Time = %0d, multiplicand = %b, multiplier = %b, product = %b", $time, multiplicand, multiplier, product);
    end
endmodule

