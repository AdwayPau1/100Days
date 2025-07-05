module clock_gating (
    input clk,       // Input clock signal
    input enable,    // Enable signal to control clock gating
    output reg gated_clk // Gated clock output
);

    always @(posedge clk or negedge enable) begin
        if (!enable) begin
            gated_clk <= 0;  // Disable the clock when enable is low
        end else begin
            gated_clk <= clk; // Pass the clock through when enable is high
        end
    end
endmodule

