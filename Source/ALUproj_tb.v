module ALUproj_tb();
	reg [15:0] a_sig;
	reg [15:0] b_sig;
	reg [1:0] opcode_sig;
	reg ci_sig;
	wire [15:0] out_sig;
	wire carryout_sig;

initial
	begin
		
		opcode_sig = 2'b00;
		a_sig = 16'b1100000010001101;
		b_sig = 16'b1000000000000010;
		ci_sig = 1'b0;

		#10;

		opcode_sig = 2'b01;
		a_sig = 16'b101010;
		b_sig = 16'b010101;
		ci_sig = 1'b0;

		#10;

		opcode_sig = 2'b10;
		a_sig = 16'b100101;
		b_sig = 16'b100101;
		ci_sig = 1'b0;

		#10;

		opcode_sig = 2'b11;
		a_sig = 16'b0101110010101011;
		b_sig = 16'b1110101101010111;
		ci_sig = 1'b0;

		#10;
	

		
		
		

		
	end

ALUproj ALUproj_inst
(
	.a(a_sig) ,	// input [15:0] a_sig
	.b(b_sig) ,	// input [15:0] b_sig
	.opcode(opcode_sig) ,	// input [1:0] opcode_sig
	.ci(ci_sig) ,	// input  ci_sig
	.out(out_sig) ,	// output [15:0] out_sig
	.carryout(carryout_sig) 	// output  carryout_sig
);

endmodule