module testbench;
  integer error_count = 0;

  task check_equal;
    input expected, observed;

    begin
      if (expected !== observed) begin
        $display("Error at time %t:", $time);
        $display("Expected = %b", expected);
        $display("Observed = %b", observed);
        error_count = error_count + 1;
      end

    end
  endtask

  reg in0, in1, sel;
  wire mux_out;

  multiplexor #(
    .WIDTH(1)
  ) uu_mux (
    .in0(in0),
    .in1(in1),
    .sel(sel),
    .mux_out(mux_out)
  );

  initial begin
    $display("Testing multiplexor:\n");
    $display("Time\t|\tsel\t|\tin0\t|\tin1\t|\tmux_out");
    $display("------------------------------------------------------------------------");

    sel = 0; in0 = 0; in1 = 1;
    #1;
    check_equal(0, mux_out);

    sel = 1;
    #1;
    check_equal(1, mux_out);

    sel = 0; in0 = 1; in1 = 0;
    #1;
    check_equal(1, mux_out);

    sel = 1;
    #1;
    check_equal(0, mux_out);

    $display("------------------------------------------------------------------------");
    if (error_count > 0) begin
      $display("There were %0d errors.", error_count);
    end else begin
      $display("Test passed with no errors.");
    end

    $stop;
  end

  initial begin
    $monitor("%4t\t|\t%b\t|\t%b\t|\t%b\t|\t%b", $time, sel, in0, in1, mux_out);
  end

endmodule
