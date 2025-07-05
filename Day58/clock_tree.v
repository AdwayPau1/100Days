module clock_tree (
    input wire clk_in,              // Clock input from the source
    input wire reset_n,             // Asynchronous reset
    output wire [15:0] clk_out      // Clock outputs for 16 flip-flops (sinks)
);

    // Internal clock signals at different tree stages
    wire clk_stage1;
    wire [1:0] clk_stage2;
    wire [3:0] clk_stage3;
    wire [15:0] clk_stage4;

    // Stage 1: Root buffer stage
    buffer buf_root (
        .clk_in(clk_in),
        .clk_out(clk_stage1)
    );

    // Stage 2: Two intermediate buffers
    buffer buf_stage2_0 (
        .clk_in(clk_stage1),
        .clk_out(clk_stage2[0])
    );
    buffer buf_stage2_1 (
        .clk_in(clk_stage1),
        .clk_out(clk_stage2[1])
    );

    // Stage 3: Four intermediate buffers
    buffer buf_stage3_0 (
        .clk_in(clk_stage2[0]),
        .clk_out(clk_stage3[0])
    );
    buffer buf_stage3_1 (
        .clk_in(clk_stage2[0]),
        .clk_out(clk_stage3[1])
    );
    buffer buf_stage3_2 (
        .clk_in(clk_stage2[1]),
        .clk_out(clk_stage3[2])
    );
    buffer buf_stage3_3 (
        .clk_in(clk_stage2[1]),
        .clk_out(clk_stage3[3])
    );

    // Stage 4: Final buffers driving each flip-flop (sink)
    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : stage4
            buffer buf_stage4_0 (
                .clk_in(clk_stage3[i]),
                .clk_out(clk_stage4[i*4])
            );
            buffer buf_stage4_1 (
                .clk_in(clk_stage3[i]),
                .clk_out(clk_stage4[i*4+1])
            );
            buffer buf_stage4_2 (
                .clk_in(clk_stage3[i]),
                .clk_out(clk_stage4[i*4+2])
            );
            buffer buf_stage4_3 (
                .clk_in(clk_stage3[i]),
                .clk_out(clk_stage4[i*4+3])
            );
        end
    endgenerate

    // Assign final clock signals to output ports
    assign clk_out = clk_stage4;

endmodule

// Basic buffer model with a propagation delay
module buffer (
    input wire clk_in,
    output wire clk_out
);
    assign #1 clk_out = clk_in;  // Add 1 time unit delay to model buffering delay
endmodule

