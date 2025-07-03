module crc32_tb;

    logic clk, rst, data_valid;
    logic [7:0] data_in;
    logic [31:0] crc_out;

    crc32 dut (
        .clk(clk), .rst(rst),
        .data_valid(data_valid),
        .data_in(data_in),
        .crc_out(crc_out)
    );

    always #5 clk = ~clk;

    task send_byte(input [7:0] byte_in);
        begin
            data_in = byte_in;
            data_valid = 1;
            #10;
            data_valid = 0;
            #10;
        end
    endtask

    initial begin
    	$dumpfile("crc32_tb.vcd");
    	$dumpvars(0, crc32_tb);
        $display("Starting CRC-32 Testbench...");
        clk = 0; rst = 1; data_valid = 0; data_in = 0;
        #20; rst = 0;

        // Send "123456789" (standard test vector for CRC-32)
        send_byte("1"); send_byte("2"); send_byte("3");
        send_byte("4"); send_byte("5"); send_byte("6");
        send_byte("7"); send_byte("8"); send_byte("9");

        #20;
        $display("Computed CRC = %h (Expected: CBF43926)", crc_out);
        if (crc_out == 32'hCBF43926)
            $display("✅ CRC-32 Test PASSED!");
        else
            $display("❌ CRC-32 Test FAILED!");

        $finish;
    end

endmodule

