module clock_gating_tb;

    // Testbench signals
    reg clk;
    reg enable;
    wire gated_clk;

    // Instantiate the clock gating module
    clock_gating uut (
        .clk(clk),
        .enable(enable),
        .gated_clk(gated_clk)
    );

    // Clock generation
    always #5 clk = ~clk;  // Toggle clock every 5 time units

    // Test procedure
    initial begin
        // Initialize signals
        $dumpfile("clock_gating_tb.vcd");
    	$dumpvars;
        clk = 0;
        enable = 0;

        // Test Case 1: Enable is low, clock should be gated (gated_clk = 0)
        #20;
        $display("Test Case 1: enable = %b, gated_clk = %b", enable, gated_clk);

        // Test Case 2: Enable is high, clock should pass through (gated_clk = clk)
        enable = 1;
        #40;
        $display("Test Case 2: enable = %b, gated_clk = %b", enable, gated_clk);

        // Test Case 3: Toggle enable during clock high
        enable = 0;
        #10;
        $display("Test Case 3: enable = %b, gated_clk = %b", enable, gated_clk);

        // Test Case 4: Enable goes high again, clock should resume
        enable = 1;
        #40;
        $display("Test Case 4: enable = %b, gated_clk = %b", enable, gated_clk);

        // End simulation
        $finish;
    end
endmodule

