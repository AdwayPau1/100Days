module priority_arbiter_tb;

    // Testbench signals
    reg clk, reset;
    reg [3:0] req;          // Request inputs
    wire [3:0] grant;       // Grant outputs

    // Instantiate the priority arbiter
    priority_arbiter uut (
        .clk(clk),
        .reset(reset),
        .req(req),
        .grant(grant)
    );

    // Clock generation
    always #5 clk = ~clk;  // Toggle clock every 5 time units

    // Test procedure
    initial begin
        $dumpfile("priority_arbiter_tb.vcd");
    	$dumpvars;
        // Initialize signals
        clk = 0;
        reset = 1;
        req = 4'b0000;

        // Apply reset
        #10 reset = 0;

        // Test Case 1: No requests
        req = 4'b0000;
        #10;
        $display("Test Case 1: req = %b, grant = %b", req, grant);

        // Test Case 2: Request from X3 (lowest priority)
        req = 4'b0001;
        #10;
        $display("Test Case 2: req = %b, grant = %b", req, grant);

        // Test Case 3: Request from X1 and X3 (higher priority to X1)
        req = 4'b0011;
        #10;
        $display("Test Case 3: req = %b, grant = %b", req, grant);

        // Test Case 4: Request from X0 (highest priority)
        req = 4'b1000;
        #10;
        $display("Test Case 4: req = %b, grant = %b", req, grant);

        // Test Case 5: All requests active, priority should go to X0
        req = 4'b1111;
        #10;
        $display("Test Case 5: req = %b, grant = %b", req, grant);

        // End simulation
        $finish;
    end

endmodule

