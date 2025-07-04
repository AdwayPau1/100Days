module unsigned_multiplier(
    input [3:0] multiplicand,  // 4-bit unsigned multiplicand
    input [3:0] multiplier,    // 4-bit unsigned multiplier
    output [7:0] product       // 8-bit unsigned product
);
    reg [7:0] product_reg;      // register to store the product
    reg [3:0] mdr;              // multiplicand register
    reg [3:0] q;                // multiplier register
    integer i;                  // loop counter

    always @(multiplicand, multiplier) begin
        product_reg = 8'b0;  // initialize product
        mdr = multiplicand;  // load multiplicand
        q = multiplier;      // load multiplier

        for (i = 0; i < 4; i = i + 1) begin
            if (q[0] == 1) begin
                product_reg = product_reg + (mdr << i);
            end
            q = q >> 1;  // right shift the multiplier
        end
    end

    assign product = product_reg;

endmodule

