`timescale 1ns / 1ps

module crc32_serial_checker_tb;

    reg clk = 0;
    reg rst = 1;
    reg data_bit = 0;
    reg data_valid = 0;
    reg check_enable = 0;
    reg [31:0] received_crc;
    wire crc_match;

    crc32_serial_checker uut (
        .clk(clk),
        .rst(rst),
        .data_bit(data_bit),
        .data_valid(data_valid),
        .check_enable(check_enable),
        .received_crc(received_crc),
        .crc_match(crc_match)
    );

    // Clock generator
    always #5 clk = ~clk;

    // "123456789" in ASCII: 0x31, 0x32, ..., 0x39
    reg [7:0] test_data [0:8];
    integer i, j;

    initial begin
    	$dumpfile("crc32_serial_checker_tb.vcd");
    	$dumpvars(0, crc32_serial_checker_tb);
        // Init test vector
        test_data[0] = 8'h31; // '1'
        test_data[1] = 8'h32; // '2'
        test_data[2] = 8'h33; // '3'
        test_data[3] = 8'h34; // '4'
        test_data[4] = 8'h35; // '5'
        test_data[5] = 8'h36; // '6'
        test_data[6] = 8'h37; // '7'
        test_data[7] = 8'h38; // '8'
        test_data[8] = 8'h39; // '9'

        received_crc = 32'hCBF43926;  // expected CRC-32 for "123456789"

        // Reset
        #10;
        rst = 0;

        // Feed each byte bit by bit (MSB first)
        for (i = 0; i < 9; i = i + 1) begin
            for (j = 7; j >= 0; j = j - 1) begin
                @(posedge clk);
                data_bit = test_data[i][j];
                data_valid = 1;
            end
        end

        // Disable data input
        @(posedge clk);
        data_valid = 0;
        data_bit = 0;

        // Wait for final CRC to settle
        repeat(10) @(posedge clk);

        // Check CRC
        @(posedge clk);
        check_enable = 1;
        @(posedge clk);
        if (crc_match)
            $display("✅ CRC-32 Test PASSED!");
        else
            $display("❌ CRC-32 Test FAILED!");
        check_enable = 0;

        $finish;
    end
endmodule

