module wallace_multiplier_tb;

    logic [3:0] a, b;
    logic [7:0] product;
    logic [7:0] expected;

    wallace_multiplier uut (
        .a(a),
        .b(b),
        .product(product)
    );

    initial begin
        $dumpfile("wallace_multiplier_tb.vcd");
    	$dumpvars;
        $display("=== Wallace Tree Multiplier Testbench ===");
        for (int i = 0; i < 16; i++) begin
            for (int j = 0; j < 16; j++) begin
                a = i;
                b = j;
                expected = i * j;
                #1;
                if (product !== expected)
                    $display("❌ FAIL: %0d * %0d = %0d (Got %0d)", a, b, expected, product);
                else
                    $display("✅ PASS: %0d * %0d = %0d", a, b, product);
            end
        end
        $display("=== End of Testbench ===");
        $finish;
    end

endmodule
