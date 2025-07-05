module priority_arbiter (
    input clk,
    input reset,
    input [3:0] req,      // Request inputs from X3 (lowest) to X0 (highest)
    output reg [3:0] grant  // One-hot encoded grant output
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            grant <= 4'b0000;  // Reset all grants
        end else begin
            casez (req)
                4'b1??? : grant <= 4'b1000;  // X0 has the highest priority
                4'b01?? : grant <= 4'b0100;  // X1 has the next priority
                4'b001? : grant <= 4'b0010;  // X2 has lower priority
                4'b0001 : grant <= 4'b0001;  // X3 has the lowest priority
                default : grant <= 4'b0000;  // No requests
            endcase
        end
    end

endmodule

