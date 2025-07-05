module barrel_shifter_tb;
    reg [3:0] data_in;
    reg [1:0] shift_amt;
    reg dir;
    reg rotate;
    wire [3:0] data_out;

    // Instantiate the barrel shifter
    barrel_shifter uut (
        .data_in(data_in),
        .shift_amt(shift_amt),
        .dir(dir),
        .rotate(rotate),
        .data_out(data_out)
    );

    initial begin
    	$dumpfile("barrel_shifter_tb.vcd");
    	$dumpvars;
        // Test left shift
        data_in = 4'b1011; shift_amt = 2; dir = 0; rotate = 0;
        #10;
        
        // Test right shift
        data_in = 4'b1011; shift_amt = 2; dir = 1; rotate = 0;
        #10;

        // Test left rotate
        data_in = 4'b1011; shift_amt = 2; dir = 0; rotate = 1;
        #10;

        // Test right rotate
        data_in = 4'b1011; shift_amt = 2; dir = 1; rotate = 1;
        #10;

        $finish;
    end
endmodule


