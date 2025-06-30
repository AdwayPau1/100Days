module Dual_Port_RAM #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
)(
    input  clk,              // Clock signal
    input  [ADDR_WIDTH-1:0] addr_a, // Address for Port A
    input  [ADDR_WIDTH-1:0] addr_b, // Address for Port B
    input  [DATA_WIDTH-1:0] data_in_a, // Data input for Port A
    input  we_a,             // Write enable for Port A
    input  en_a, en_b,             // Enable for Port A, B
    output reg [DATA_WIDTH-1:0] data_out_b  // Data output for Port B
);

    // RAM array
    reg [DATA_WIDTH-1:0] ram [(2**ADDR_WIDTH)-1:0];

    // Port A: Handle Read/Write operations
    always @(posedge clk) begin
    	if (en_a) begin
        	if (we_a) 
            		ram[addr_a] <= data_in_a;  // Write operation
        end
    end

    // Port B: Handle Read/Write operations
    always @(posedge clk) begin
        if (en_b) 
	    data_out_b <= ram[addr_b];      // Read operation
    end

endmodule

