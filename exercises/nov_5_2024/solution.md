## Exercise 1: Flip-flop

```verilog
module dff (clk, reset,
 d, q, qb);
 input clk;
 input reset;
 input d;
 output q;
 output qb;
 reg q;
 assign qb = ~q;
 always @(posedge clk or posedge reset)
 begin
 if (reset) begin
 // Asynchronous reset when reset goes high
 q <= 1'b0;
 end else begin
 // Assign D to Q on positive clock edge
 q <= d;
 end
 end
endmodule

module test;
 reg clk;
 reg reset;
 reg d;
 wire q;
 wire qb;

 // Instantiate design under test
 dff DFF(.clk(clk), .reset(reset),
 .d(d), .q(q), .qb(qb));

 initial begin

 $display("Reset flop.");
 clk = 0;
 reset = 1;
 d = 1'bx;
 display;

 $display("Release reset.");
 d = 1;
 reset = 0;
 display;
 
 $display("Toggle clk.");
 clk = 1;
 display;
 
 $display("Generate bit sequence:");
 
 d = 1;
 display;
 
 d = 0;
 clk = 0;
 clk = 1;
 display;
 
 d = 1;
 clk = 0;
 clk = 1;
 display;
 
 display;
 
 d = 0;
 clk = 0;
 clk = 1;
 display;
 
 end

 task display;
 #1 $display("d:%0h, q:%0h, qb:%0h",
 d, q, qb);
 endtask
endmodule
```

## Exercise 2: Handshake

I had multiple syntax errors with the base code: (running at JDoodle)

```verilog
jdoodle.v:32: syntax error
jdoodle.v:32: error: Invalid module instantiation
jdoodle.v:33: error: Invalid module item.
jdoodle.v:38: syntax error
jdoodle.v:34: error: Invalid module instantiation
jdoodle.v:42: error: Invalid module item.
jdoodle.v:43: syntax error
jdoodle.v:55: error: Invalid module item.
jdoodle.v:63: syntax error
jdoodle.v:63: error: Malformed statement
jdoodle.v:63: syntax error
jdoodle.v:64: error: Malformed statement
```

## Exercise 3: RAM

```verilog
/*
* Random Access Memory (RAM) with
* 1 read port and 1 write port
*/
module ram (
    clk_write,
    address_write,
    data_write,
    write_enable,
    clk_read,
    address_read,
    data_read
);

    parameter D_WIDTH = 16;
    parameter A_WIDTH = 4;
    parameter A_MAX = 16; // 2^A_WIDTH
    // Write port
    input clk_write;
    input [A_WIDTH-1:0] address_write;
    input [D_WIDTH-1:0] data_write;
    input write_enable;
    // Read port
    input clk_read;
    input [A_WIDTH-1:0] address_read;
    output [D_WIDTH-1:0] data_read;

    reg [D_WIDTH-1:0] data_read;

    // Memory as multi-dimensional array
    reg [D_WIDTH-1:0] memory [A_MAX-1:0];

    // Write data to memory
    always @(posedge clk_write) begin
        if (write_enable) begin
            memory[address_write] <= data_write;
        end
    end

    // Read data from memory
    always @(posedge clk_read) begin
        data_read <= memory[address_read];
    end
endmodule

// Testbench
module test;
    reg clk_write;
    reg [4:0] address_write;
    reg [7:0] data_write;
    reg write_enable;
    reg clk_read;
    reg [4:0] address_read;
    wire [7:0] data_read;

    // Instantiate design under test (DUT)
    // D_WIDTH = 8, A_WIDTH = 5, A_MAX = 32
    ram #(8, 5, 32) RAM (
        .clk_write(clk_write),
        .address_write(address_write),
        .data_write(data_write),
        .write_enable(write_enable),
        .clk_read(clk_read),
        .address_read(address_read),
        .data_read(data_read)
    );

    always begin
        #5 clk_write = ~clk_write;  
    end

    always begin
        #5 clk_read = ~clk_read;
    end

    initial begin
        clk_write = 0;
        clk_read = 0;
        address_write = 5'b0;
        data_write = 8'b0;
        write_enable = 0;
        address_read = 5'b0;
        
        address_write = 5'h1B;
        data_write = 8'hC5;
        write_enable = 1;
        #10;

        write_enable = 0;
        #10;

        address_read = 5'h1B;
        #10;

        $display("Data @ address 0x1B: 0x%h", data_read);
        $finish;
    end
endmodule
```