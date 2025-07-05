module clock_tree_tb;

    // Testbench signals
    reg clk_in;                     // Clock input
    reg reset_n;                    // Asynchronous reset
    wire [15:0] clk_out;            // Clock outputs for 16 flip-flops (sinks)

    // Instantiate the clock_tree module
    clock_tree uut (
        .clk_in(clk_in),
        .reset_n(reset_n),
        .clk_out(clk_out)
    );

    // Clock generation: Toggle clock every 5 time units
    always #5 clk_in = ~clk_in;

    // Test sequence
    initial begin
        // Initialize signals
        $dumpfile("clock_tree_tb.vcd");
        $dumpvars;
        clk_in = 0;
        reset_n = 0;               // Hold reset initially

        // Release reset after some time
        #10 reset_n = 1;

        // Run simulation for a certain time
        #100;

        // Finish the simulation
        $finish;
    end

    // Monitor clock outputs
    initial begin
        $monitor("Time=%0t | clk_in=%b | clk_out[15:0]=%b", $time, clk_in, clk_out);
    end
endmodule

