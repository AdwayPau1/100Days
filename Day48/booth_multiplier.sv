module booth_multiplier(
    input signed [3:0] multiplicand,  // 4-bit signed multiplicand
    input signed [3:0] multiplier,    // 4-bit signed multiplier
    output signed [7:0] product       // 8-bit signed product
);
    reg signed [7:0] product_reg;
    reg signed [4:0] acc;   // 5-bit accumulator (to hold the result)
    reg signed [4:0] mdr;   // 5-bit multiplicand register
    reg [3:0] q;            // 4-bit multiplier register
    reg q_1;                // 1-bit q-1 register
    integer count;          // loop counter

    always @(multiplicand, multiplier) begin
        acc = 5'b0;                     // initialize accumulator
        mdr = {multiplicand[3], multiplicand};  // extend the multiplicand sign bit
        q = multiplier;                 // load the multiplier
        q_1 = 1'b0;                     // initialize q-1 to 0
        count = 4;                      // number of iterations

        while (count > 0) begin
            case ({q[0], q_1})
                2'b01: acc = acc + mdr;  // add multiplicand if q0=1 and q-1=0
                2'b10: acc = acc - mdr;  // subtract multiplicand if q0=0 and q-1=1
            endcase

            // Arithmetic right shift
            q_1 = q[0];                  // shift q0 to q-1
            {acc, q} = {acc[4], acc, q} >> 1;  // shift acc and q together
            count = count - 1;
        end

        product_reg = {acc[3:0], q};  // concatenate acc and q to form the final product
    end

    assign product = product_reg;

endmodule

