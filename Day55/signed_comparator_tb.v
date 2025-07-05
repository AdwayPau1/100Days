module signed_comparator_tb;

    // Testbench variables
    reg [3:0] A, B;        // 4-bit signed inputs A and B
    reg clk, reset;        // Clock and reset signals
    wire A_greater, A_equal, A_lesser, conflict; // Output wires

    // Instantiate the signed comparator
    signed_comparator uut (
        .A(A),
        .B(B),
        .clk(clk),
        .reset(reset),
        .A_greater(A_greater),
        .A_equal(A_equal),
        .A_lesser(A_lesser),
        .conflict(conflict)
    );

    // Clock generation
    always #5 clk = ~clk; // 10 time units clock period

    // Test procedure
    initial begin
        // Initialize inputs
        $dumpfile("signed_comparator_tb.vcd");
    	$dumpvars;
        clk = 0;
        reset = 1;
        A = 4'b0000;
        B = 4'b0000;

        // Apply reset
        #10;
        reset = 0;

        // Test case 1: A = 4'b0100 (4), B = 4'b0011 (3) -> A > B
        A = 4'b0100;  // +4
        B = 4'b0011;  // +3
        #10;
        $display("Test case 1: A = %d, B = %d, A_greater = %b, A_equal = %b, A_lesser = %b, conflict = %b", 
                 $signed(A), $signed(B), A_greater, A_equal, A_lesser, conflict);

        // Test case 2: A = 4'b1001 (-7), B = 4'b1000 (-8) -> A > B
        A = 4'b1001;  // -7
        B = 4'b1000;  // -8
        #10;
        $display("Test case 2: A = %d, B = %d, A_greater = %b, A_equal = %b, A_lesser = %b, conflict = %b", 
                 $signed(A), $signed(B), A_greater, A_equal, A_lesser, conflict);

        // Test case 3: A = 4'b1100 (-4), B = 4'b0100 (4) -> A < B
        A = 4'b1100;  // -4
        B = 4'b0100;  // +4
        #10;
        $display("Test case 3: A = %d, B = %d, A_greater = %b, A_equal = %b, A_lesser = %b, conflict = %b", 
                 $signed(A), $signed(B), A_greater, A_equal, A_lesser, conflict);

        // Test case 4: A = 4'b0111 (7), B = 4'b1000 (-8) -> Conflict
        A = 4'b0111;  // +7
        B = 4'b1000;  // -8
        #10;
        $display("Test case 4: A = %d, B = %d, A_greater = %b, A_equal = %b, A_lesser = %b, conflict = %b", 
                 $signed(A), $signed(B), A_greater, A_equal, A_lesser, conflict);

        // Test case 5: A = 4'b1000 (-8), B = 4'b1000 (-8) -> A == B
        A = 4'b1000;  // -8
        B = 4'b1000;  // -8
        #10;
        $display("Test case 5: A = %d, B = %d, A_greater = %b, A_equal = %b, A_lesser = %b, conflict = %b", 
                 $signed(A), $signed(B), A_greater, A_equal, A_lesser, conflict);

        // End simulation
        $finish;
    end

endmodule

