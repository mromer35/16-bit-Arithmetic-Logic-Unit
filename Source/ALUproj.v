module ALUproj(
	input [15:0] a,
	input [15:0] b,
	input [1:0] opcode,
	input ci,
	output reg [15:0] out,
	output reg carryout
);

wire [15:0] addout, subout, bitwiseXORout, complementout;
wire cout, cout1, cout2, cout3;

//ALU operations
add16 add1(.out(addout), .carry_out(cout), .a(a), .b(b), .ci(ci));
sub sub1(subout, cout1, a, b, ci);
bitwiseXOR16 bitwise1(a,b,bitwiseXORout);
twoscomplement comp1(b,complementout, cout3);

//Body
always@(opcode or addout or subout or complementout or bitwiseXORout or cout or cout1 or cout2 or cout3)
	begin
	
		//'MUX'
		if(opcode == 2'b00)//add 16bit
		begin
			out[15:0] <= addout;
			carryout <= cout;
		end
		else if(opcode == 2'b01)//sub 16bit
		begin
			out[15:0] <= subout;
			carryout <= cout1;
		end
		else if(opcode == 2'b10)//2sComplement 16bit
		begin
			out[15:0] <= complementout;
			carryout <= cout3;
			
		end
		else//bitwise XOR 16bit
		begin
			out[15:0] <= bitwiseXORout;
			carryout <= cout2;
		end
		

	end
endmodule

module add16(out, carry_out, a, b, ci);
			input [15:0] a;
			input [15:0] b;
			input ci;
			output [15:0] out;
			output carry_out;
			wire [14:0] co;
			
			//perform bit addition at each bit location for 'a' and 'b'
			add a0(co[0],out[0],a[0],b[0],ci);
			add a1(co[1],out[1],a[1],b[1],co[0]);
			add a2(co[2],out[2],a[2],b[2],co[1]);
			add a3(co[3],out[3],a[3],b[3],co[2]);
			add a4(co[4],out[4],a[4],b[4],co[3]);
			add a5(co[5],out[5],a[5],b[5],co[4]);
			add a6(co[6],out[6],a[6],b[6],co[5]);
			add a7(co[7],out[7],a[7],b[7],co[6]);
			add a8(co[8],out[8],a[8],b[8],co[7]);
			add a9(co[9],out[9],a[9],b[9],co[8]);
			add a10(co[10],out[10],a[10],b[10],co[9]);
			add a11(co[11],out[11],a[11],b[11],co[10]);
			add a12(co[12],out[12],a[12],b[12],co[11]);
			add a13(co[13],out[13],a[13],b[13],co[12]);
			add a14(co[14],out[14],a[14],b[14],co[13]);
			add a15(carry_out,out[15],a[15],b[15],co[14]);
endmodule

//1-bit adder
module add(out, sum, a, b, ci);
	input a,b,ci;
	output  sum, out;
	reg sum, out;
	
	always @(a or b or ci)
	begin
		sum <= a^b^ci;
		out <= (a&b)|(b&ci)|(ci&a);
	end
endmodule

//Subtraction module
//
module sub(out, carry_out, a, b, ci);
	input [15:0] a;
	input [15:0] b;
	input ci;
	
	output [15:0] out;
	output wire carry_out;
	
	wire [15:0] w1;

	//perform negation at each bit location
	negate neg0(b[0],w1[0]);
	negate neg1(b[1],w1[1]);
	negate neg2(b[2],w1[2]);
	negate neg3(b[3],w1[3]);
	negate neg4(b[4],w1[4]);
	negate neg5(b[5],w1[5]);
	negate neg6(b[6],w1[6]);
	negate neg7(b[7],w1[7]);
	negate neg8(b[8],w1[8]);
	negate neg9(b[9],w1[9]);
	negate neg10(b[10],w1[10]);
	negate neg11(b[11],w1[11]);
	negate neg12(b[12],w1[12]);
	negate neg13(b[13],w1[13]);
	negate neg14(b[14],w1[14]);
	negate neg15(b[15],w1[15]);
	
	//add 'b' by '1' to get 2's complement
	add16 add_2(out, carry_out, a, w1, 1'b1);
	
endmodule

//Single bit negation
module negate(b,out);
	input b;
	output reg out;

	
	always @(b)
	begin
		out<=~b;
	end

endmodule


//BitwiseXOR
//-Both input signals are XOR'ed in each bit location
module bitwiseXOR16(a,b,out);
	input [15:0] a,b;
	output [15:0] out;
	
	//perform bitwise XOR at each bit location
	bitwiseXOR bit0(a[0],b[0],out[0]);
	bitwiseXOR bit1(a[1],b[1],out[1]);
	bitwiseXOR bit2(a[2],b[2],out[2]);
	bitwiseXOR bit3(a[3],b[3],out[3]);
	bitwiseXOR bit4(a[4],b[4],out[4]);
	bitwiseXOR bit5(a[5],b[5],out[5]);
	bitwiseXOR bit6(a[6],b[6],out[6]);
	bitwiseXOR bit7(a[7],b[7],out[7]);
	bitwiseXOR bit8(a[8],b[8],out[8]);
	bitwiseXOR bit9(a[9],b[9],out[9]);
	bitwiseXOR bit10(a[10],b[10],out[10]);
	bitwiseXOR bit11(a[11],b[11],out[11]);
	bitwiseXOR bit12(a[12],b[12],out[12]);
	bitwiseXOR bit13(a[13],b[13],out[13]);
	bitwiseXOR bit14(a[14],b[14],out[14]);
	bitwiseXOR bit15(a[15],b[15],out[15]);
	
endmodule

//Single bit XOR
module bitwiseXOR(a,b,out);
	input a,b;
	output out;
	reg out;

	always @(a or b) begin
		out <= a^b;
	end

endmodule

//2's complement
//-input b' 2's complement is taken by taking 1's comp. and adding by 1
module twoscomplement(b, out, cout3);
	input [15:0] b;
	output [15:0] out;
	output cout3;
	wire [15:0] w1;
	
	//perform negation at each bit location
	negate n0(b[0],w1[0]);
	negate n1(b[1],w1[1]);
	negate n2(b[2],w1[2]);
	negate n3(b[3],w1[3]);
	negate n4(b[4],w1[4]);
	negate n5(b[5],w1[5]);
	negate n6(b[6],w1[6]);
	negate n7(b[7],w1[7]);
	negate n8(b[8],w1[8]);
	negate n9(b[9],w1[9]);
	negate n10(b[10],w1[10]);
	negate n11(b[11],w1[11]);
	negate n12(b[12],w1[12]);
	negate n13(b[13],w1[13]);
	negate n14(b[14],w1[14]);
	negate n15(b[15],w1[15]);
	
	add16 addby1(out, cout3, 16'b00, w1, 1'b1);


endmodule
