module vending_machine (
    input  logic        clk,
    input  logic        reset,
    input  logic [2:0]  note_in,        // 000=₹10, 001=₹20, ..., 101=₹500
    input  logic [2:0]  select_item,    // Item code
    input  logic        confirm,        // Confirm purchase
    output logic        vend,           // Item dispensed
    output logic [9:0]  change,         // Change in rupees
    output logic [1:0]  status          // 00=idle, 01=waiting, 10=vend, 11=error
);

    // Note values: ₹10, ₹20, ₹50, ₹100, ₹200, ₹500
    logic [9:0] balance;
    logic [9:0] item_price;

    function automatic [9:0] get_note_value(input logic [2:0] code);
        case (code)
            3'b000: get_note_value = 10;
            3'b001: get_note_value = 20;
            3'b010: get_note_value = 50;
            3'b011: get_note_value = 100;
            3'b100: get_note_value = 200;
            3'b101: get_note_value = 500;
            default: get_note_value = 0;
        endcase
    endfunction

    function automatic [9:0] get_item_price(input logic [2:0] code);
        case (code)
            3'b000: get_item_price = 10;
            3'b001: get_item_price = 20;
            3'b010: get_item_price = 25;
            3'b011: get_item_price = 30;
            3'b100: get_item_price = 50;
            3'b101: get_item_price = 100;
            default: get_item_price = 0;
        endcase
    endfunction

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            balance <= 0;
            vend <= 0;
            change <= 0;
            status <= 2'b00; // idle
        end else begin
            vend <= 0;
            change <= 0;

            // Add cash if a valid note is inserted
            if (note_in <= 3'b101)
                balance <= balance + get_note_value(note_in);

            // Load item price based on selected code
            item_price = get_item_price(select_item);

            if (confirm) begin
                if (item_price == 0) begin
                    status <= 2'b11; // error: invalid item
                end else if (balance >= item_price) begin
                    vend <= 1;
                    change <= balance - item_price;
                    balance <= 0;
                    status <= 2'b10; // vend success
                end else begin
                    status <= 2'b01; // waiting for more money
                end
            end else begin
                status <= 2'b00; // idle
            end
        end
    end

endmodule

