module tb();
	reg csb, sck, si;
	wire so;
	reg [15:0] address;
	reg [7:0] dataout;
	
	SPI DUT(csb, so, sck, si);
	
	always #5 sck = ~sck;
	
	initial begin
		sck = 1'b0; csb = 1'b1; si = 1'b0; #20
		
		csb = 1'b0; #80
		//write
		si = 1'b1; #10
		si = 1'b0; #10
		//address
		si = 1'b1; #40
		si = 1'b0; #40
		si = 1'b1; #40
		si = 1'b0; #40
		//data
		#10 si = 1'b1; #10
		si = 1'b0; #60
		
		#32
		//read
		si = 1'b1; #20
		//address
		si = 1'b0; #40
		si = 1'b1; #40
		si = 1'b0; #40
		si = 1'b1; #50
		csb = 1;#40
		
	//write(16'h0001, 8'h01);
	address = 16'h0001;
	dataout = 8'h01;
	//Dr. Wolfe's tests
  	//write
    csb = 0;				// Start Transaction
    si = 0; #5 sck = 1; 		// Send write instruction 0000 0010
    #5 si = 0; sck = 0; #5 sck = 1;
    #5 si = 0; sck = 0; #5 sck = 1;
    #5 si = 0; sck = 0; #5 sck = 1;
    #5 si = 0; sck = 0; #5 sck = 1;
    #5 si = 0; sck = 0; #5 sck = 1;
    #5 si = 1; sck = 0; #5 sck = 1;
    #5 si = 0; sck = 0; #5 sck = 1;

    #5 si = address[15]; sck = 0; #5 sck = 1;	// Send address MSB first
    #5 si = address[14]; sck = 0; #5 sck = 1;
    #5 si = address[13]; sck = 0; #5 sck = 1;
    #5 si = address[12]; sck = 0; #5 sck = 1;
    #5 si = address[11]; sck = 0; #5 sck = 1;
    #5 si = address[10]; sck = 0; #5 sck = 1;
    #5 si = address[9]; sck = 0; #5 sck = 1;
    #5 si = address[8]; sck = 0; #5 sck = 1;
    #5 si = address[7]; sck = 0; #5 sck = 1;
    #5 si = address[6]; sck = 0; #5 sck = 1;
    #5 si = address[5]; sck = 0; #5 sck = 1;
    #5 si = address[4]; sck = 0; #5 sck = 1;
    #5 si = address[3]; sck = 0; #5 sck = 1;
    #5 si = address[2]; sck = 0; #5 sck = 1;
    #5 si = address[1]; sck = 0; #5 sck = 1;
    #5 si = address[0]; sck = 0; #5 sck = 1;


    #5 si = dataout[7]; sck = 0; #5 sck = 1;	// Send data MSB first
    #5 si = dataout[6]; sck = 0; #5 sck = 1;
    #5 si = dataout[5]; sck = 0; #5 sck = 1;
    #5 si = dataout[4]; sck = 0; #5 sck = 1;
    #5 si = dataout[3]; sck = 0; #5 sck = 1;
    #5 si = dataout[2]; sck = 0; #5 sck = 1;
    #5 si = dataout[1]; sck = 0; #5 sck = 1;
    #5 si = dataout[0]; sck = 0; #5 sck = 1;
    #5 sck = 0; #5 csb = 1; #5;
	
	
	
	//read(16'h0001, dreg);
	address = 16'h0001;
	dataout = 8'h00;
	//read
	csb = 0;				// Start Transaction
    si = 0; #5 sck = 1; 		// Send read instruction 0000 0011
    #5 si = 0; sck = 0; #5 sck = 1;
    #5 si = 0; sck = 0; #5 sck = 1;
    #5 si = 0; sck = 0; #5 sck = 1;
    #5 si = 0; sck = 0; #5 sck = 1;
    #5 si = 0; sck = 0; #5 sck = 1;
    #5 si = 1; sck = 0; #5 sck = 1;
    #5 si = 1; sck = 0; #5 sck = 1;

    #5 si = address[15]; sck = 0; #5 sck = 1;	// Send address MSB first
    #5 si = address[14]; sck = 0; #5 sck = 1;
    #5 si = address[13]; sck = 0; #5 sck = 1;
    #5 si = address[12]; sck = 0; #5 sck = 1;
    #5 si = address[11]; sck = 0; #5 sck = 1;
    #5 si = address[10]; sck = 0; #5 sck = 1;
    #5 si = address[9]; sck = 0; #5 sck = 1;
    #5 si = address[8]; sck = 0; #5 sck = 1;
    #5 si = address[7]; sck = 0; #5 sck = 1;
    #5 si = address[6]; sck = 0; #5 sck = 1;
    #5 si = address[5]; sck = 0; #5 sck = 1;
    #5 si = address[4]; sck = 0; #5 sck = 1;
    #5 si = address[3]; sck = 0; #5 sck = 1;
    #5 si = address[2]; sck = 0; #5 sck = 1;
    #5 si = address[1]; sck = 0; #5 sck = 1;
    #5 si = address[0]; sck = 0; #5 sck = 1;


    #5 sck = 0; #5 dataout[7] = so; sck = 1;	// Receive data MSB first
    #5 sck = 0; #5 dataout[6] = so; sck = 1;
    #5 sck = 0; #5 dataout[5] = so; sck = 1;
    #5 sck = 0; #5 dataout[4] = so; sck = 1;
    #5 sck = 0; #5 dataout[3] = so; sck = 1;
    #5 sck = 0; #5 dataout[2] = so; sck = 1;
    #5 sck = 0; #5 dataout[1] = so; sck = 1;
    #5 sck = 0; #5 dataout[0] = so; sck = 1;
    #5 sck = 0; #5 csb = 1; #5;



	address = 16'h03aa;
	dataout = 8'b10101010;
	//Dr. Wolfe's tests
  	//write
    csb = 0;				// Start Transaction
    si = 0; #5 sck = 1; 		// Send write instruction 0000 0010
    #5 si = 0; sck = 0; #5 sck = 1;
    #5 si = 0; sck = 0; #5 sck = 1;
    #5 si = 0; sck = 0; #5 sck = 1;
    #5 si = 0; sck = 0; #5 sck = 1;
    #5 si = 0; sck = 0; #5 sck = 1;
    #5 si = 1; sck = 0; #5 sck = 1;
    #5 si = 0; sck = 0; #5 sck = 1;

    #5 si = address[15]; sck = 0; #5 sck = 1;	// Send address MSB first
    #5 si = address[14]; sck = 0; #5 sck = 1;
    #5 si = address[13]; sck = 0; #5 sck = 1;
    #5 si = address[12]; sck = 0; #5 sck = 1;
    #5 si = address[11]; sck = 0; #5 sck = 1;
    #5 si = address[10]; sck = 0; #5 sck = 1;
    #5 si = address[9]; sck = 0; #5 sck = 1;
    #5 si = address[8]; sck = 0; #5 sck = 1;
    #5 si = address[7]; sck = 0; #5 sck = 1;
    #5 si = address[6]; sck = 0; #5 sck = 1;
    #5 si = address[5]; sck = 0; #5 sck = 1;
    #5 si = address[4]; sck = 0; #5 sck = 1;
    #5 si = address[3]; sck = 0; #5 sck = 1;
    #5 si = address[2]; sck = 0; #5 sck = 1;
    #5 si = address[1]; sck = 0; #5 sck = 1;
    #5 si = address[0]; sck = 0; #5 sck = 1;


    #5 si = dataout[7]; sck = 0; #5 sck = 1;	// Send data MSB first
    #5 si = dataout[6]; sck = 0; #5 sck = 1;
    #5 si = dataout[5]; sck = 0; #5 sck = 1;
    #5 si = dataout[4]; sck = 0; #5 sck = 1;
    #5 si = dataout[3]; sck = 0; #5 sck = 1;
    #5 si = dataout[2]; sck = 0; #5 sck = 1;
    #5 si = dataout[1]; sck = 0; #5 sck = 1;
    #5 si = dataout[0]; sck = 0; #5 sck = 1;
    #5 sck = 0; #5 csb = 1; #5;


	address = 16'h03aa;
	dataout = 8'h00;
	//read
	csb = 0;				// Start Transaction
    si = 0; #5 sck = 1; 		// Send read instruction 0000 0011
    #5 si = 0; sck = 0; #5 sck = 1;
    #5 si = 0; sck = 0; #5 sck = 1;
    #5 si = 0; sck = 0; #5 sck = 1;
    #5 si = 0; sck = 0; #5 sck = 1;
    #5 si = 0; sck = 0; #5 sck = 1;
    #5 si = 1; sck = 0; #5 sck = 1;
    #5 si = 1; sck = 0; #5 sck = 1;

    #5 si = address[15]; sck = 0; #5 sck = 1;	// Send address MSB first
    #5 si = address[14]; sck = 0; #5 sck = 1;
    #5 si = address[13]; sck = 0; #5 sck = 1;
    #5 si = address[12]; sck = 0; #5 sck = 1;
    #5 si = address[11]; sck = 0; #5 sck = 1;
    #5 si = address[10]; sck = 0; #5 sck = 1;
    #5 si = address[9]; sck = 0; #5 sck = 1;
    #5 si = address[8]; sck = 0; #5 sck = 1;
    #5 si = address[7]; sck = 0; #5 sck = 1;
    #5 si = address[6]; sck = 0; #5 sck = 1;
    #5 si = address[5]; sck = 0; #5 sck = 1;
    #5 si = address[4]; sck = 0; #5 sck = 1;
    #5 si = address[3]; sck = 0; #5 sck = 1;
    #5 si = address[2]; sck = 0; #5 sck = 1;
    #5 si = address[1]; sck = 0; #5 sck = 1;
    #5 si = address[0]; sck = 0; #5 sck = 1;


    #5 sck = 0; #5 dataout[7] = so; sck = 1;	// Receive data MSB first
    #5 sck = 0; #5 dataout[6] = so; sck = 1;
    #5 sck = 0; #5 dataout[5] = so; sck = 1;
    #5 sck = 0; #5 dataout[4] = so; sck = 1;
    #5 sck = 0; #5 dataout[3] = so; sck = 1;
    #5 sck = 0; #5 dataout[2] = so; sck = 1;
    #5 sck = 0; #5 dataout[1] = so; sck = 1;
    #5 sck = 0; #5 dataout[0] = so; sck = 1;
    #5 sck = 0; #5 csb = 1; #5;
		$finish;
	end

endmodule
