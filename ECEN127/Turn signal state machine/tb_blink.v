module tb();
	reg clk, rst;
	reg [1:0] dir;
	wire [2:0] L, R;

	turnsignals DUT(.clk(clk), .rst(rst), .dir(dir), .L(L), .R(R));
	
	always begin
		#5 clk = ~clk;
		$display("clk=%b, rst =%b, dir=%b, L=%b, R=%b, @ %d",clk, rst, dir, L, R, $time);
		#5 clk = ~clk;
	end
	
	initial begin
		$display("Start of the blinker test");
		clk <= 0;
		#1
		//testing reset and straight signal
		rst <= 1'b1; #10
		rst <= 1'b0; #10
		dir <= 00; #10
		dir <= 00; #10
		//testing looping through right signal
		dir <= 01; #10
		dir <= 01; #10
		dir <= 01; #10
		dir <= 01; #10
		dir <= 00; #10	
		//testing looping through left signal
		dir <= 11; #10
		dir <= 11; #10
		dir <= 11; #10
		dir <= 11; #10
		dir <= 00; #10
		//changing signal direction mid signal
		dir <= 01; #10
		dir <= 01; #10
		dir <= 11; #10
		dir <= 11; #10
		dir <= 11; #10
		dir <= 00; #10
		//go from either turn signal to straight mid signal
		dir <= 11; #10
		dir <= 11; #10
		dir <= 00; #10
		dir <= 01; #10
		dir <= 01; #10
		dir <= 00; #10
		//reset during turn signals
		dir <= 11; #10
		dir <= 11; rst <= 1'b1; #10
		dir <= 00; rst <= 1'b0; #10
		$finish;
	end
endmodule
