module register
#(
	parameter WIDTH = 8
) (
	input [WIDTH-1:0]	data_in,
	input 			load, clk, rst,
	output reg [WIDTH-1:0] 	data_out
);
	always @ (posedge clk) begin
		if (rst) begin
            data_out <= 0;
        end else if (load) begin
			data_out <= data_in;
		end else begin
			data_out <= data_out;
		end

	end
endmodule
