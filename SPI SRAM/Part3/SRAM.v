module sram(address, IO, RE, WE);
	input [12:0] address;
	input RE, WE;
	inout [7:0] IO;
	
	reg [7:0] mem [8191:0];
	
	assign IO = (RE & ~WE)? mem[address]:8'hzz;
	
	always @(posedge WE) begin
		mem[address] <= IO;
	end
endmodule
