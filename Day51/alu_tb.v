module alu_tb;
    reg [3:0] A, B;        // 4-bit inputs
    reg [2:0] opcode;      // 3-bit opcode
    wire [3:0] result;     // 4-bit result
    wire carry_out, zero;  // carry-out and zero flags

    // Instantiate the ALU
    alu uut (
        .A(A),
        .B(B),
        .opcode(opcode),
        .result(result),
        .carry_out(carry_out),
        .zero(zero)
    );

    integer i;  // Loop variable

    initial begin
    	$dumpfile("alu_tb.vcd");
    	$dumpvars;
        // Randomly generate test cases for a certain number of cycles
        for (i = 0; i < 20; i = i + 1) begin
            A = $random % 16;        // Random 4-bit value for A (0 to 15)
            B = $random % 16;        // Random 4-bit value for B (0 to 15)
            opcode = $random % 5;    // Random 3-bit opcode (0 to 4, as we have 5 operations)

            // Display the test case details and the ALU output
            #10 $display("Test case %d: A = %b, B = %b, Opcode = %b, Result = %b, Carry = %b, Zero = %b", 
                        i+1, A, B, opcode, result, carry_out, zero);
        end

        $finish; // Stop the simulation
    end
endmodule

