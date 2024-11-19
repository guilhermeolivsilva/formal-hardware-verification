module testbench;
  integer error_count = 0;
  parameter WIDTH = 8, PERIOD = 5;

  task check_equal;
    input [WIDTH-1:0] expected;
    input [WIDTH-1:0] observed;

    begin
      if (expected !== observed) begin
        $display("Error at time %t:", $time);
        $display("Expected = %b", expected);
        $display("Observed = %b", observed);
        error_count = error_count + 1;
      end
    end
  endtask

  reg [WIDTH-1:0] data_in;
  reg load, clk, rst;
  wire [WIDTH-1:0] data_out;

  register #(
    .WIDTH(WIDTH)
  ) uut_register (
    .data_in(data_in),
    .load(load),
    .clk(clk),
    .rst(rst),
    .data_out(data_out)
  );

  initial begin
    clk = 0;
    forever #(PERIOD / 2) clk = ~clk;
  end

  initial begin
    rst = 1; load = 0; data_in = 0;
    @(posedge clk);
    rst = 0;

    load = 1;
    repeat (PERIOD) begin
      data_in = $random;
      @(posedge clk);
      check_equal(data_in, data_out);
    end

    $display("-----------------------------------------------------------------------------------------------------------------------------");
    if (error_count > 0) begin
      $display("There were %0d errors.", error_count);
    end else begin
      $display("Test passed with no errors.");
    end

    $stop;
  end

  initial begin
    $monitor("Time: %t\t|\trst: %b\t|\tload: %b\t|\tdata_in: %b\t|\tdata_out: %b", 
             $time, rst, load, data_in, data_out);
  end

endmodule
