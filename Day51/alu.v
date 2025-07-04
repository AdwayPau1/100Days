module alu (
    input [3:0] A,         // 4-bit input A
    input [3:0] B,         // 4-bit input B
    input [2:0] opcode,    // 3-bit opcode for operation selection
    output reg [3:0] result, // 4-bit output result
    output reg carry_out,    // Carry out for addition/subtraction
    output zero              // Zero flag (1 if result is zero)
);
    wire [4:0] sum, diff;   // Wires for storing sum and difference
    wire [3:0] and_res, or_res, not_res; // Wires for logical operations

    // Arithmetic operations
    assign sum = A + B;      // Addition
    assign diff = A - B;     // Subtraction

    // Logical operations
    assign and_res = A & B;  // AND
    assign or_res = A | B;   // OR
    assign not_res = ~A;     // NOT (only applied to A)

    // Zero flag logic (set if result is zero)
    assign zero = (result == 4'b0000);

    always @(*) begin
        carry_out = 0;       // Default carry out
        case (opcode)
            3'b000: begin    // Addition
                result = sum[3:0];
                carry_out = sum[4]; // Carry out is the 5th bit of sum
            end
            3'b001: begin    // Subtraction
                result = diff[3:0];
                carry_out = diff[4]; // Carry out for subtraction
            end
            3'b010: result = and_res; // AND
            3'b011: result = or_res;  // OR
            3'b100: result = not_res; // NOT (only on A)
            default: result = 4'b0000; // Default to zero for invalid opcode
        endcase
    end
endmodule

