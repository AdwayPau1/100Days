//x^32 + x^26 + x^23 + x^22 + x^16 + x^12 + x^11 + x^10 + x^8 + x^7 + x^5 + x^4 + x^2 + x + 1

//→ Represented as 0x04C11DB7

module crc32 (
    input  logic        clk,
    input  logic        rst,
    input  logic        data_valid,
    input  logic [7:0]  data_in,
    output logic [31:0] crc_out
);
    
    parameter [31:0] POLY = 32'hEDB88320;  // Bit-reversed 0x04C11DB7


    logic [31:0] crc;

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            crc <= 32'hFFFFFFFF;  // Initial CRC value
        else if (data_valid) begin
            crc = crc ^ data_in;
	    for (int i = 0; i < 8; i++) begin
    	    	if (crc[0])
        		crc = (crc >> 1) ^ POLY;
    		else
        		crc = crc >> 1;
	    end
        end
    end

    assign crc_out = ~crc;  // Final XOR

endmodule

