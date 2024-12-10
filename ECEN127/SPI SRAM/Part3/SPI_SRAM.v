module M23A640(csb, so, holdb, sck, si);
	input csb, sck, si, holdb;
	output so;
	
	wire [12:0] address;
	wire RE, WE;
	wire [7:0] IO;
	
	SPI SPI1(.csb(csb), .so(so), .sck(sck), .si(si), .address(address), .RE(RE), .WE(WE), .IO(IO));
	sram SRAM1(.address(address), .IO(IO), .RE(RE), .WE(WE));
endmodule
