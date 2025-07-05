module signed_comparator (
    input [3:0] A,       // 4-bit signed input A
    input [3:0] B,       // 4-bit signed input B
    input clk,
    input reset,
    output reg A_greater, // A > B
    output reg A_equal,   // A == B
    output reg A_lesser,  // A < B
    output reg conflict   // Conflict detection
);

    wire sign_A, sign_B;   // Sign bits of A and B
    wire [2:0] mag_A, mag_B; // Magnitude bits (excluding sign bit)
    wire mag_compare;      // Intermediate magnitude comparison

    // Extract sign and magnitude bits
    assign sign_A = A[3];
    assign sign_B = B[3];
    assign mag_A = A[2:0];
    assign mag_B = B[2:0];

    // Core comparison logic using sign and magnitude bits
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            A_greater <= 0;
            A_equal <= 0;
            A_lesser <= 0;
            conflict <= 0;
        end else begin
            if (A == B) begin
                A_equal <= 1;
                A_greater <= 0;
                A_lesser <= 0;
            end else if (sign_A == 0 && sign_B == 1) begin
                // A is positive, B is negative => A > B
                A_greater <= 1;
                A_lesser <= 0;
                A_equal <= 0;
            end else if (sign_A == 1 && sign_B == 0) begin
                // A is negative, B is positive => A < B
                A_greater <= 0;
                A_lesser <= 1;
                A_equal <= 0;
            end else if (sign_A == 0 && sign_B == 0) begin
                // Both are positive, compare magnitudes
                if (mag_A > mag_B) begin
                    A_greater <= 1;
                    A_lesser <= 0;
                    A_equal <= 0;
                end else begin
                    A_greater <= 0;
                    A_lesser <= 1;
                    A_equal <= 0;
                end
            end else if (sign_A == 1 && sign_B == 1) begin
                // Both are negative, compare magnitudes (inverted comparison)
                if (mag_A < mag_B) begin
                    A_greater <= 1;
                    A_lesser <= 0;
                    A_equal <= 0;
                end else begin
                    A_greater <= 0;
                    A_lesser <= 1;
                    A_equal <= 0;
                end
            end

            // Conflict detection logic
            // Check if A and B are very close in value (e.g., A = 0111 and B = 1000)
            if ((A == 4'b0111 && B == 4'b1000) || (A == 4'b1000 && B == 4'b0111)) begin
                conflict <= 1;
            end else begin
                conflict <= 0;
            end
        end
    end

endmodule

