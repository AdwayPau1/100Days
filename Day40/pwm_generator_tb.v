`timescale 1ns / 1ps

module pwm_generator_tb;

    reg clk;                // Testbench clock
    reg reset;              // Testbench reset
    reg [7:0] duty;         // Duty cycle control for the PWM generator
    wire pwm_out;           // PWM output signal

    // Instantiate the PWM generator
    pwm_generator uut (
        .clk(clk),
        .reset(reset),
        .duty(duty),
        .pwm_out(pwm_out)
    );

    // Clock generation (50 MHz)
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // 20ns period
    end

    // Test sequence
    initial begin
        // Open a waveform dump file for GTKWave or ModelSim visualization
        $dumpfile("pwm_generator_tb.vcd");
        $dumpvars(0, pwm_generator_tb);

        // Initialize inputs
        reset = 1;
        duty = 8'd0;
        
        // Apply reset
        #20 reset = 0;
        
        // Test different duty cycles
        duty = 8'd64;     // 25% duty cycle
        #5120 duty = 8'd128;   // 50% duty cycle
        #5120 duty = 8'd192;   // 75% duty cycle
        #5120 duty = 8'd255;   // 100% duty cycle (always high)
        #5120 duty = 8'd0;     // 0% duty cycle (always low)
        
        // End simulation
        #100 $finish;
    end

endmodule

