module binary_divider(
    input [7:0] dividend,
    input [7:0] divisor,
    output reg [7:0] quotient,
    output reg [7:0] remainder
);
    reg [15:0] temp_remainder;
    integer i;

    always @(*) begin
        quotient = 8'b0;            // Initialize quotient
        remainder = 8'b0;           // Initialize remainder
        temp_remainder = {8'b0, dividend}; // Concatenate dividend with leading zeros
        
        for (i = 7; i >= 0; i = i - 1) begin
            temp_remainder = temp_remainder << 1;         // Left shift remainder and quotient
            temp_remainder[0] = dividend[i];              // Bring in MSB of dividend to temp_remainder
            
            if (temp_remainder[15:8] >= divisor) begin    // If the remainder is greater than divisor
                temp_remainder[15:8] = temp_remainder[15:8] - divisor; // Subtract divisor from remainder
                quotient[i] = 1;                          // Set quotient bit to 1
            end
            else begin
                quotient[i] = 0;                          // Set quotient bit to 0
            end
        end
        
        remainder = temp_remainder[15:8];                 // Assign final remainder
    end
endmodule

