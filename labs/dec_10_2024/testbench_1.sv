module fv_mux();
    reg [4:0] i0, i1;
    reg sel;
    wire out;

    multiplexor uu_mux(i0, i1, sel, out);

    assert property(!sel -> out == i0);
    assert property(sel -> out == i1);

endmodule
