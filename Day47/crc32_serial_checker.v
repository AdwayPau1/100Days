module crc32_serial_checker (
    input  wire clk,
    input  wire rst,
    input  wire data_bit,       // 1-bit serial data input
    input  wire data_valid,     // valid bit indicates new data
    input  wire check_enable,   // compare computed CRC with received
    input  wire [31:0] received_crc,
    output wire crc_match
);
    reg [31:0] crc_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            crc_reg <= 32'hFFFFFFFF;
        end else if (data_valid) begin
            crc_reg[0]  <= crc_reg[1];
            crc_reg[1]  <= crc_reg[2];
            crc_reg[2]  <= crc_reg[3];
            crc_reg[3]  <= crc_reg[4] ^ (crc_reg[0] ^ data_bit);
            crc_reg[4]  <= crc_reg[5];
            crc_reg[5]  <= crc_reg[6];
            crc_reg[6]  <= crc_reg[7];
            crc_reg[7]  <= crc_reg[8];
            crc_reg[8]  <= crc_reg[9];
            crc_reg[9]  <= crc_reg[10];
            crc_reg[10] <= crc_reg[11];
            crc_reg[11] <= crc_reg[12];
            crc_reg[12] <= crc_reg[13];
            crc_reg[13] <= crc_reg[14];
            crc_reg[14] <= crc_reg[15];
            crc_reg[15] <= crc_reg[16];
            crc_reg[16] <= crc_reg[17] ^ (crc_reg[0] ^ data_bit);
            crc_reg[17] <= crc_reg[18];
            crc_reg[18] <= crc_reg[19];
            crc_reg[19] <= crc_reg[20];
            crc_reg[20] <= crc_reg[21];
            crc_reg[21] <= crc_reg[22];
            crc_reg[22] <= crc_reg[23];
            crc_reg[23] <= crc_reg[24];
            crc_reg[24] <= crc_reg[25] ^ (crc_reg[0] ^ data_bit);
            crc_reg[25] <= crc_reg[26];
            crc_reg[26] <= crc_reg[27];
            crc_reg[27] <= crc_reg[28];
            crc_reg[28] <= crc_reg[29];
            crc_reg[29] <= crc_reg[30];
            crc_reg[30] <= crc_reg[31];
            crc_reg[31] <= (crc_reg[0] ^ data_bit);
        end
    end

    assign crc_match = check_enable && (crc_reg ~^ received_crc);

endmodule

