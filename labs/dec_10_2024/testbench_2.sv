module fv_alu();
    reg [7:0] in_a, in_b;
    reg [2:0] op;
    wire a_zero, out;

    alu uu_alu(in_a, in_b, op, out, a_zero);

    p1_and: assert property(
        (op == 3'b011 && in_a == 3'b101 && in_b == 3'b010)
        -> (out == 3'b000)
    );

endmodule
