module digital_lock (
    input clk,            // Clock signal
    input reset,          // Reset signal
    input [3:0] code_in,  // 4-bit input code
    input enter,          // Signal to enter the code
    output reg unlock,    // Unlock signal
    output reg lockout    // Lockout signal
);

    parameter correct_code = 4'b1010;  // Correct 4-bit code
    reg [1:0] wrong_attempts;          // 2-bit counter for wrong attempts (0 to 3)

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            unlock <= 0;               // Lock the system
            lockout <= 0;              // No lockout initially
            wrong_attempts <= 0;       // Reset wrong attempt counter
        end else if (!lockout) begin    // Only process if not in lockout
            if (enter) begin
                if (code_in == correct_code) begin
                    unlock <= 1;        // Unlock if code is correct
                    wrong_attempts <= 0; // Reset wrong attempts
                end else begin
                    wrong_attempts <= wrong_attempts + 1;  // Increment wrong attempt counter
                    unlock <= 0;       // Remain locked
                    if (wrong_attempts == 2) begin
                        lockout <= 1;  // Lockout after 3 incorrect attempts
                    end
                end
            end
        end
    end

endmodule

