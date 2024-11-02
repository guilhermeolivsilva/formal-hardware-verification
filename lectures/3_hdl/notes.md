# Hardware Description Languages (HDL)

# HDL in Verification

- Verilog stands for *verification and logic*.
- One can verify not only the hardware, but also how to test it.
    - Test bench: generate stimuli on the hardware and check if it generates the expected output.
- Hardware verification is, essentially, a Boolean Satisfability Problem (SAT).
    - So… encode the circuit in such manner that a SAT Solver can check it.
    - If it can generate a proof that it works, it works!

# What is a HDL?

- Language used to model hardware by describing its functionality.
    - Inherently parallel!
    - Structural modeling (data flow).
    - Expresses clocks, sequencing and delays.
- Multiple levels of abstraction:
    - Behavioral → good for simulation
    - RTL → good for system overview
    - Gate level → good for arch optimizatio
    - Switch level

# Introduction to Verilog

## Describing design modules

- Basic steps:
    1. Start with the `module` keyword.
    2. Describe the module interface.
    3. Describe the module behavior.
    4. End with the `endmodule` keyword.

```verilog
module halfadd(
	input a, b,
	output sum, carry
);
	assign sum = a ^ b;
	assign carry = a & b;
endmodule
```

```verilog
module fulladd (
	input a,
	input b,
	input cin,
	
	output sum,
	output carry
);

	wire n_sum, n_carry1, n_carry2;
	
	halfadd U1(
		.a(a),
		.b(b),
		.sum(n_sum),
		.carry(n_carry)
	);
	
	halfadd U2(
		.a(n_sum),
		.b(cin),
		.sum(sum),
		.carry(n_carry2)
	);
	
	or U3(carry, n_carry_2, n_carry1);
endmodule
```

## Procedural blocks

- `always` block:
    - Synthesizable: can become a circuit.
    - Execution loops back.
    - `@` defines events to trigger block.

```verilog
// (a, b, sel) is the list of events to listen to
always @(a, b, sel)
begin
	if (sel == 1)
		op = b;
	else
		op = a;
end
```

- `initial` block:
    - Not synthesizable: used for simulation.
    - Executes only once.

```verilog
initial
	begin
		a = 1;
		b = 0;
	end
```

- Everything inside procedural blocks is processed **sequentially**.
- Everything outside procedural blocks is processed in **parallel**.
    - Including multiple procedural blocks!

## Data types

- Nets
    - Represents physical connection between structures.
    - Wires!
- Variables
    - Abstractions to hold value.
    - Can be synthesized to to wires, registers, or not be synthesizable at all.

## Logic values

- Nets in simulation:
    - All nets initialized as Z in simulation.
    - HiZ means disabled driver.
    - X means driver clash.
- Variables in simulation:
    - All variables initialized to X in simulation.
    - HiZ means variable represents a bus net driver.
    - X means simulation could not resolve the value.

## Using vectors

- A vector is a net or reg with a range specification.
- The vector range is specified when declaring the variable:
    - `[msb_constant_expression : lsb_constant_expression]`

```verilog
reg a [7 : 0] a; // 8 bits
```

## Defining literal values

- A literal can be defined with `<size>'<base><value>`.
    - `size`: optional positive decimal number of bits.
    - `base`: set the base of reference (binary, octal, decimal, hexadecimal).
    - `value`:

```verilog
wire a;

a = 4'b0010; // 0010
```