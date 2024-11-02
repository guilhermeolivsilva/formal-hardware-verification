# Lab #1 (22/10/2024)

**Guilherme de Oliveira Silva**

1. **Multiplexor**

```verilog
// Guilherme de Oliveira Silva

module multiplexor
# (
    parameter WIDTH = 5
)
(
    input [WIDTH - 1:0] in0,
    input [WIDTH - 1:0] in1,
    input sel,
    output reg [WIDTH - 1:0] mux_out
);
	always @(in0 or in1 or sel)
		begin
			if (sel == 1'b0)
			  mux_out = in0;
			else
			  mux_out = in1;
		end
endmodule
```

1. **Arithmetic Logic Unit**

```verilog
// Guilherme de Oliveira Silva

module alu
# (
		parameter WIDTH = 8
)
(
		input [2:0] opcode,
		input [WIDTH - 1:0] in_a,
		input [WIDTH - 1:0] in_b,
		
		output reg a_is_zero,
		output reg [WIDTH - 1:0] alu_out
);

	always @(opcode or in_a or in_b)
		begin
			case(opcode)
				3'b000,
				3'b001,
				3'b110,
				3'b111   :    alu_out <= in_a;
				3'b010   :    alu_out <= in_a + in_b;
				3'b011   :    alu_out <= in_a & in_b;
				3'b100   :    alu_out <= in_a ^ in_b;
				3'b101   :    alu_out <= in_b;
			endcase

			a_is_zero = ~| in_a;

		end
endmodule
```

1. **Register**

```verilog
// Guilherme de Oliveira Silva

module register (
    input [7:0] data_in,
    input load,
    input clk,
    input rst,
    output reg [7:0] data_out
);

  always @(posedge clk)
    begin
      if (rst)
        begin
          data_out <= 8'b0;
        end
      else if (load)
        begin
          data_out <= data_in;
        end
    end

endmodule
```