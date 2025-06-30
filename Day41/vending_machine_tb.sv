`timescale 1ns/1ps

module tb_vending_machine;

    logic clk, reset, confirm;
    logic [2:0] note_in;
    logic [2:0] select_item;
    logic       vend;
    logic [9:0] change;
    logic [1:0] status;
    
    logic set_confirm = 1;
    
    vending_machine uut (
        .clk(clk), .reset(reset), .note_in(note_in),
        .select_item(select_item), .confirm(confirm),
        .vend(vend), .change(change), .status(status)
    );

    // Clock generation
    always #5 clk = ~clk;

    task reset_dut();
        clk = 0; reset = 1; confirm = 0;
        note_in = 0; select_item = 0;
        #10 reset = 0;
    endtask

    task insert_note(input [2:0] note);
        note_in = note;
        #10 note_in = 3'b111; // invalid note to stop insertion
    endtask

    task test_case(
        input [2:0] item, input [2:0] notes [$], input [9:0] expected_change,
        input expect_vend, string desc
    );
        reset_dut();
        foreach (notes[i]) begin
            insert_note(notes[i]);
        end
        select_item = item;
        if (set_confirm == 1) confirm = 1; #10;
        confirm = 0;

        if (vend === expect_vend && change === expected_change)
            $display("[PASS] %s: VEND=%b, CHANGE=%0d, STATUS=%b", desc, vend, change, status);
        else
            $display("[FAIL] %s: VEND=%b (expected %b), CHANGE=%0d (expected %0d), STATUS=%b", 
                desc, vend, expect_vend, change, expected_change, status);
        #20;
    endtask

    initial begin
    	$dumpfile("vending_machine_tb.vcd");
    	$dumpvars(0, tb_vending_machine);
        $display("==== VENDING MACHINE TEST CASES ====");

        // Exact change: buy ₹10 item with ₹10
        test_case(3'b000, '{3'b000}, 0, 1, "Exact change - ₹10 item with ₹10");

        // Excess cash: buy ₹10 item with ₹20
        test_case(3'b000, '{3'b001}, 10, 1, "Excess cash - ₹10 item with ₹20");

        // Multiple notes: ₹50 item with ₹20 + ₹20 + ₹10
        test_case(3'b100, '{3'b001, 3'b001, 3'b000}, 0, 1, "₹50 item with ₹20+₹20+₹10");

        // Insufficient funds: ₹30 item with ₹10
        test_case(3'b011, '{3'b000}, 0, 0, "Insufficient funds - ₹30 item with ₹10");

        // Invalid item selection
        test_case(3'b111, '{3'b011}, 0, 0, "Invalid item selection");

        // Large note with change: ₹25 item with ₹100
        test_case(3'b010, '{3'b011}, 75, 1, "₹25 item with ₹100");

	// No confirmation given
	set_confirm = 0;
	test_case(3'b001, '{3'b001}, 0, 0, "No confirm signal - ₹20 item with ₹20, but no confirm");
	set_confirm = 1;
	// Insert invalid note (e.g., 3'b110)
	reset_dut();
	note_in = 3'b110; #10;
	note_in = 3'b111; // stop input
	select_item = 3'b000; confirm = 1; #10;
	confirm = 0;
	if (!vend)
 	   	$display("[PASS] Invalid note rejected correctly");
	else
    		$display("[FAIL] Invalid note not rejected");
	// Buy ₹100 item with ₹500 (expect ₹400 change)
	test_case(3'b101, '{3'b101}, 400, 1, "₹100 item with ₹500 note");

	// Buy ₹200 item with multiple small notes
	test_case(3'b101, '{3'b000, 3'b000, 3'b000, 3'b000, 3'b000, 3'b000, 3'b000, 3'b000, 3'b000, 3'b000}, 0, 1,"₹100 item with ten ₹10 notes");

	// Try to buy with ₹5 (invalid note, simulate using 3'b110 again)
	reset_dut();
	note_in = 3'b110; #10;
	note_in = 3'b111;
	select_item = 3'b010; confirm = 1; #10; confirm = 0;
	if (!vend && status == 2'b01)
    		$display("[PASS] Reject ₹5 note - not in currency list");
	else
    		$display("[FAIL] ₹5 note accepted incorrectly");
	
	// Buy ₹25 item with ₹10 + ₹10 + ₹10 (expect ₹5 change)
	test_case(3'b010, '{3'b000, 3'b000, 3'b000}, 5, 1, "₹25 item with three ₹10 notes");

        $display("==== END OF TEST ====");
        $finish;
    end

endmodule

