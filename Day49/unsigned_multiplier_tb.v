module unsigned_multiplier_tb;
    reg [3:0] multiplicand, multiplier;
    wire [7:0] product;
    
    unsigned_multiplier uut (
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .product(product)
    );
    
    initial begin
    	$dumpfile("unsigned_multiplier_tb.vcd");
    	$dumpvars;
        // Test case 1: 3 * 3 = 9
        multiplicand = 4'b0011;  // 3 in decimal
        multiplier = 4'b0011;    // 3 in decimal
        #10;
        
        // Test case 2: 2 * 4 = 8
        multiplicand = 4'b0010;  // 2 in decimal
        multiplier = 4'b0100;    // 4 in decimal
        #10;
        
        // Test case 3: 7 * 5 = 35
        multiplicand = 4'b0111;  // 7 in decimal
        multiplier = 4'b0101;    // 5 in decimal
        #10;
        
        // Test case 4: 15 * 15 = 225
        multiplicand = 4'b1111;  // 15 in decimal
        multiplier = 4'b1111;    // 15 in decimal
        #10;
       $finish; 
       
    end
    
    initial begin
        $monitor("Time = %0d, multiplicand = %b, multiplier = %b, product = %b", $time, multiplicand, multiplier, product);
    end
endmodule

