module shifter(SW, LEDR, KEY);
	input[9:0] SW;
	input[3:0] KEY;
	output[7:0] LEDR;

	ShifterInner u0(
		.LoadVal(SW[7:0]),
		.Load_n(KEY[1]),
		.ShiftRight(KEY[2]),
		.ASR(KEY[3]),
		.clk(KEY[0]),
		.reset_n(SW[9]),
		.Q(LEDR)	
	);

endmodule


module ShifterInner(LoadVal, Load_n, ShiftRight, ASR, clk, reset_n, Q);
	input[7:0] LoadVal;
	input Load_n, ShiftRight, ASR, clk, reset_n;
	output wire [7:0] Q;

	reg leftMost;
	
	always @(ASR)
	begin
		if (ASR == 0)
			leftMost <= 0;
		else
			leftMost <= Q[0];
	end

	ShifterBit u0(
		.load_val(LoadVal[0]),
		.in(leftMost),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(Q[0])
	);

	ShifterBit u1(
		.load_val(LoadVal[1]),
		.in(Q[0]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(Q[1])
	);

	ShifterBit u2(
		.load_val(LoadVal[2]),
		.in(Q[1]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(Q[2])
	);

	ShifterBit u3(
		.load_val(LoadVal[3]),
		.in(Q[2]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(Q[3])
	);

	ShifterBit u4(
		.load_val(LoadVal[4]),
		.in(Q[3]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(Q[4])
	);

	ShifterBit u5(
		.load_val(LoadVal[5]),
		.in(Q[4]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(Q[5])
	);

	ShifterBit u6(
		.load_val(LoadVal[6]),
		.in(Q[5]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(Q[6])
	);

	ShifterBit u7(
		.load_val(LoadVal[7]),
		.in(Q[6]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(Q[7])
	);

endmodule





module ShifterBit(load_val, in, shift, load_n, clk, reset_n, out);
	input load_val, in, shift, load_n, clk, reset_n;
	output wire out;
	wire u0u1;
	wire u1u2;

	mux2to1 u0(
		.x(out),
		.y(in),
		.s(shift),
		.m(u0u1)
	);

	mux2to1 u1(
		.x(load_val),
		.y(u0u1),
		.s(shift),
		.m(u1u2)
	);

	flipflop u2(
		.d(u1u2),
		.clock(clk),
		.reset_n(reset_n),
		.q(out)	
	);
endmodule



module flipflop(d, clock, reset_n, q);
	input d;
	input clock;
	input reset_n;
	
	output reg q;

	always @(posedge clock) // Triggered every time clock rises
				// Note that clock is not a keyword
	begin
		if(reset_n == 1'b0) // When reset n is 0
				// Note this is tested on every rising
				// clock edge
			q <= 0; // Set q to 0
				// Note that the assignment uses <=
				// instead of =
		else		// When reset_n is not 0
			q <= d; //Store the value of d in q
	end
endmodule

module mux2to1(x, y, s, m);
	input x; //selected when s is 0
	input y; //selected when s is 1
	input s; // select signal
	output m; // output

	assign m = s & y | ~s & x;
endmodule
