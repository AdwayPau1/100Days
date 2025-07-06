module wallace_multiplier (
    input  logic [3:0] a, b,
    output logic [7:0] product
);
    // Partial products (aligned properly)
    logic [7:0] pp0, pp1, pp2, pp3;

    assign pp0 = {4'b0000, a & {4{b[0]}}};
    assign pp1 = {3'b000,  a & {4{b[1]}}, 1'b0};
    assign pp2 = {2'b00,   a & {4{b[2]}}, 2'b00};
    assign pp3 = {1'b0,    a & {4{b[3]}}, 3'b000};

    // Stage 1: add pp0, pp1, pp2
    logic [7:0] s1, c1;
    assign s1 = pp0 ^ pp1 ^ pp2;
    assign c1 = ((pp0 & pp1) | (pp1 & pp2) | (pp2 & pp0)) << 1;

    // Stage 2: add s1, c1, pp3
    logic [7:0] s2, c2;
    assign s2 = s1 ^ c1 ^ pp3;
    assign c2 = ((s1 & c1) | (c1 & pp3) | (pp3 & s1)) << 1;

    // Final addition
    assign product = s2 + c2;

endmodule

