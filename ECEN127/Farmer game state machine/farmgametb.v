module tb();
	reg clk, rst, en;
	reg [1:0] M;
	wire W, L, I;

	game DUT(.clk(clk), .rst(rst), .en(en), .M(M), .W(W), .L(L), .I(I));
	
	always begin
		#5 clk = ~clk;
		$display("clk=%b, rst =%b, en=%b, M=%b, W=%b, L=%b,  I=%b,@ %d",clk, rst, en, M, W, L, I, $time);
		#5 clk = ~clk;
	end
	
	initial begin
		$display("Start of the farm game test");
		$display("test reset");
		clk <= 0; rst = 1'b1;#10
		$display("testing enable and lose state");
		rst = 1'b0; en = 1'b0; M = 2'b00; #10
		en = 1'b1; M = 2'b00; #10
		rst = 1'b1; #10
		$display("testing if all states work on the way to win state");
		rst = 1'b0; M = 2'b10; #10
		$display("testing what happens when we put in impossible move");
		M = 2'b11; #10
		$display("continuing to win state");
		M = 2'b00; #10
		M = 2'b11; #10
		M = 2'b10; #10
		M = 2'b01; #10
		M = 2'b00; #10
		$display("testing if we can go to previous state and then back");
		M = 2'b00; #10
		M = 2'b00; #10
		$display("continues to win state");
		M = 2'b10; #10
		$display("try to move states while locked in win/lose state");
		M = 2'b00; #10
		#10		
		$finish;
	end
endmodule
