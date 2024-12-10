module tb();
	reg [12:0] address;
	reg RE, WE;
	wire [7:0]  IO;
	reg [7:0] datain;
	
	assign IO = ((RE&~WE) | (WE&RE)) ? 8'hzz : datain;

	sram dut(.address(address), .IO(IO), .RE(RE), .WE(WE));
	
	initial begin
		$display("Beginning of part 1 test");
		$monitor("RE = %b, WE = %b, address = %b, datain = %b, IO = %b, @ %d", RE, WE, address, datain, IO, $time);
		$display("Initailizing values");
		address = 13'b0000000000001;
		RE = 1'b0;
		WE = 1'b0;
		#10 datain = 8'b00000001;
		
		$display("//write IO");
		#10 WE = 1'b1;
		
		$display("//read IO");
		#10 WE = 1'b0; RE = 1'b1; datain = 8'b11110000;
		
		$display("//try to write while read is enabled");
		#10 WE = 1'b1;
		#10 WE = 1'b0;
		
		$display("//reset enables to 0 and test memory array limits");
		#10 WE = 1'b0; RE = 1'b0; address = 13'b1111111111111;
		
		$display("//write to edge of mem array");
		#10 WE = 1'b1;
		
		$display("//read edge of mem array");
		#10 WE = 1'b0; RE = 1'b1; datain = 8'b00001111;
		#10
		$finish;
	end
endmodule
