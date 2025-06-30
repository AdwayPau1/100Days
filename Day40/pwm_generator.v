
module pwm_generator (
    input wire clk,          // System clock
    input wire reset,        // Active high reset
    input wire [7:0] duty,   // Duty cycle (0-255 for 8-bit resolution)
    output reg pwm_out       // PWM output
);

    reg [7:0] counter;       // Counter for PWM timing

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            pwm_out <= 0;
        end else begin
            if (counter < duty)
                pwm_out <= 1; // High for 'duty' cycles
            else
                pwm_out <= 0; // Low for remaining cycles
            
            // Increment and reset counter for PWM period
            if (counter == 8'd255) 
                counter <= 0;
            else
                counter <= counter + 1;
        end
    end
endmodule

