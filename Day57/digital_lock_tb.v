module digital_lock_tb;

    // Testbench signals
    reg clk;
    reg reset;
    reg [3:0] code_in;
    reg enter;
    wire unlock;
    wire lockout;

    // Instantiate the digital lock module
    digital_lock uut (
        .clk(clk),
        .reset(reset),
        .code_in(code_in),
        .enter(enter),
        .unlock(unlock),
        .lockout(lockout)
    );

    // Clock generation
    always #5 clk = ~clk;  // Toggle clock every 5 time units

    // Test procedure
    initial begin
        // Initialize signals
        $dumpfile("digital_lock_tb.vcd");
    	$dumpvars;
        clk = 0;
        reset = 1;
        code_in = 4'b0000;
        enter = 0;

        // Apply reset
        #10 reset = 0;

        // Test Case 1: Correct code, should unlock
        code_in = 4'b1010;  // Correct code
        enter = 1;
        #10 enter = 0;
        #10;
        $display("Test Case 1: Correct code, unlock = %b, lockout = %b", unlock, lockout);

        // Test Case 2: Wrong code, no unlock, 1st wrong attempt
        code_in = 4'b1111;  // Wrong code
        enter = 1;
        #10 enter = 0;
        #10;
        $display("Test Case 2: Wrong code, unlock = %b, lockout = %b", unlock, lockout);

        // Test Case 3: Wrong code, no unlock, 2nd wrong attempt
        code_in = 4'b0001;  // Another wrong code
        enter = 1;
        #10 enter = 0;
        #10;
        $display("Test Case 3: 2nd wrong attempt, unlock = %b, lockout = %b", unlock, lockout);

        // Test Case 4: Wrong code, lockout after 3rd wrong attempt
        code_in = 4'b0010;  // Another wrong code
        enter = 1;
        #10 enter = 0;
        #10;
        $display("Test Case 4: 3rd wrong attempt, unlock = %b, lockout = %b", unlock, lockout);

        // Test Case 5: Correct code, but lockout is active
        code_in = 4'b1010;  // Correct code
        enter = 1;
        #10 enter = 0;
        #10;
        $display("Test Case 5: Correct code after lockout, unlock = %b, lockout = %b", unlock, lockout);

        // Test Case 6: Reset the system and try correct code again
        reset = 1;
        #10 reset = 0;
        code_in = 4'b1010;  // Correct code
        enter = 1;
        #10 enter = 0;
        #10;
        $display("Test Case 6: Reset system, correct code, unlock = %b, lockout = %b", unlock, lockout);

        // End simulation
        $finish;
    end
endmodule

