module testbench();

reg [3:0] a,b;
reg c;
wire [3:0] bcd0, bcd1;

bcdadd dut(a, b, c, bcd0, bcd1);

initial begin
	$display("Start of the bcd adder test");
	$monitor("a=%d, b=%d, cin = %d, bcd1=%d, bcd0=%d, @ %d", a, b, c, bcd1, bcd0, $time);
a=4'b0; b=4'b0; c = 0;
#10
a=4'd3; b=4'd5; 
#10
a=4'd9; b=4'd5; 
#10
a=4'd3; b=4'd9; c=1;
#10
a=4'd10; b=4'd5; 
#10
$display("End of the bcd adder test");
$finish;

end

endmodule

