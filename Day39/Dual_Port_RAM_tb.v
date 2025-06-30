`timescale 1ns/1ps

module Dual_Port_RAM_tb;

    // Parameters for the test
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 4;

    // Signals
    reg clk;
    reg [ADDR_WIDTH-1:0] addr_a, addr_b;
    reg [DATA_WIDTH-1:0] data_in_a;
    reg we_a, en_a, en_b;
    wire [DATA_WIDTH-1:0] data_out_b;

    // Instantiate the Dual_Port_RAM module
    Dual_Port_RAM #(DATA_WIDTH, ADDR_WIDTH) dut (
        .clk(clk),
        .addr_a(addr_a),
        .addr_b(addr_b),
        .data_in_a(data_in_a),
        .we_a(we_a),
        .en_a(en_a),
        .en_b(en_b),
        .data_out_b(data_out_b)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns period, 100MHz clock
    end

    // Test procedure
    initial begin
        // Initialize signals
        addr_a = 4'bx;
        addr_b = 4'bx;
        data_in_a = 8'bx;
        we_a = 1'bx;
        en_a = 0;
        en_b = 0;

        // Test write operation on Port A with enable
        #10;
        addr_a = 4; data_in_a = 8'hAA; we_a = 1; en_a = 1;  // Write AA to address 4 on Port A
        #10;
        we_a = 0; en_a = 0;                                 // Disable write on Port A

        // Read back from Port B with enable
        addr_b = 4; en_b = 1;                               // Read from address 4 on Port B
        #10;
        en_b = 0;                                           // Disable read on Port B

        // Write to Port A and Port B simultaneously
        addr_a = 3; data_in_a = 8'h55; we_a = 1; en_a = 1;  // Write 55 to address 3 on Port A
        addr_b = 3; en_b = 1;            // Enable Port B for read at address 3
        #10;

        // Simultaneous write to the same address with both ports enabled
        addr_a = 2; data_in_a = 8'hCC; we_a = 1; en_a = 1;  // Write CC to address 2 on Port A
        addr_b = 2;                                         // Set Port B to read from address 2
        #10;

        // Disable both ports
        we_a = 0; en_a = 0; en_b = 0;
        addr_a = 1; addr_b = 1;                             // Set different addresses to check no actions occur
        #10;

        // Final read from both ports
        addr_a = 4; en_a = 1;
        addr_b = 3; en_b = 1;
        #10;

        // End of test
        $finish;
    end

    // Waveform dump for GTKWaves
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, Dual_Port_RAM_tb);
    end

endmodule

