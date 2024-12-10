module tb_sine_generator();
    reg Clk, Rst, Load;
    reg [15:0] PhaseIn;
    wire [11:0] Output;
    wire Sample;
    integer file;
    integer i;
    reg [15:0] phase;   // current phase

    always begin
        #5 Clk = ~Clk;
    end
    
    sine_generator2 dut (Clk, Rst, Load, PhaseIn, Sample, Output);

    initial begin
        Clk = 1; 
        Rst = 1; 
        Load = 0; 
        PhaseIn = 0;
		phase = 0;
        Load = 1;
        PhaseIn = 16'd819;
		#10;
        Load = 0;

		#10; Rst = 0; #20; Rst = 1; #10;

		file = $fopen("outputwave_verilog.csv", "w");
        for (i = 0; i < 80; i = i + 1) begin
			$fwrite(file, "%0d, %0d\n", phase >> 9, Output);
			#20;
			phase = phase + PhaseIn;
    	end
		$fclose(file);
        $finish;
    end
endmodule

