module fv_reg(input clk, input rst);
    reg [7:0] data;
    wire out;

    register uu_reg(data, en, clk, rst, out);

    p1_reg: assert property(rst |=> out == 0);

endmodule
