module barrel_shifter (
    input [3:0] data_in,        // 4-bit input data
    input [1:0] shift_amt,      // 2-bit shift amount (0 to 3)
    input dir,                  // 0 for left shift/rotate, 1 for right shift/rotate
    input rotate,               // 0 for shift, 1 for rotate
    output reg [3:0] data_out   // 4-bit shifted/rotated output
);

    always @(*) begin
        case ({rotate, dir}) // Combine rotate and dir signals
            2'b00:  // Left shift
                data_out = data_in << shift_amt;
            2'b01:  // Right shift
                data_out = data_in >> shift_amt;
            2'b10:  // Left rotate
                data_out = (data_in << shift_amt) | (data_in >> (4 - shift_amt));
            2'b11:  // Right rotate
                data_out = (data_in >> shift_amt) | (data_in << (4 - shift_amt));
            default:
                data_out = data_in;
        endcase
    end
endmodule
