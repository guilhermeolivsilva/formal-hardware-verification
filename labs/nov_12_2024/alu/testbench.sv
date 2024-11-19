module testbench;
  integer error_count = 0;
  parameter WIDTH = 8;

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

  reg [WIDTH-1:0] in_a, in_b;
  reg [2:0] opcode;
  wire [WIDTH-1:0] alu_out;
  wire a_is_zero;

  alu #(
    .WIDTH(WIDTH)
  ) uut_alu (
    .in_a(in_a),
    .in_b(in_b),
    .opcode(opcode),
    .alu_out(alu_out),
    .a_is_zero(a_is_zero)
  );

  initial begin
    $display("Testing ALU:\n");
    $display("Time\t|\topcode\t|\tin_a\t\t|\tin_b\t\t|\talu_out\t\t|\ta_is_zero");
    $display("-------------------------------------------------------------------------------------------------------------------");

    in_a = 8'b00000000; in_b = 8'b00000001; opcode = 3'b000;
    #1;
    check_equal(8'b00000000, alu_out);
    check_equal(1'b1, a_is_zero);

    in_a = 8'b00000101; in_b = 8'b00000011; opcode = 3'b010;
    #1;
    check_equal(8'b00001000, alu_out);
    check_equal(1'b0, a_is_zero);
    check_equal(1'b0, a_is_zero);

    in_a = 8'b00001100; in_b = 8'b00000111; opcode = 3'b011;
    #1;
    check_equal(8'b00000100, alu_out);
    check_equal(1'b0, a_is_zero);

    in_a = 8'b11110000; in_b = 8'b10101010; opcode = 3'b100;
    #1;
    check_equal(8'b01011010, alu_out);
    check_equal(1'b0, a_is_zero);

    in_a = 8'b11111111; in_b = 8'b00001111; opcode = 3'b101;
    #1;
    check_equal(8'b00001111, alu_out);
    check_equal(1'b0, a_is_zero);

    $display("-------------------------------------------------------------------------------------------------------------------");
    if (error_count > 0) begin
      $display("There were %0d errors.", error_count);
    end else begin
      $display("Test passed with no errors.");
    end

    $stop;
  end

  initial begin
    $monitor("%4t\t|\t%b\t|\t%b\t|\t%b\t|\t%b\t|\t%b", 
             $time, opcode, in_a, in_b, alu_out, a_is_zero);
  end

endmodule
