module tb_sine_generator();
    reg Clk, Rst, Load;
    reg [15:0] PhaseIn;
    wire [11:0] Output;

    integer file;

    integer i;
    reg [15:0] phase;   // current phase


    always begin
        #5 Clk = ~Clk;
    end


    sine_generator dut (Clk, Rst, Load, PhaseIn, Output);

    initial begin
        Clk = 0; 
        Rst = 1; 
        Load = 0; 
        PhaseIn = 0;
	phase = 0;


        Load = 1;
        PhaseIn = 16'd873;
	#10;
        Load = 0;

	#10; Rst = 0; #20; Rst = 1;

	file = $fopen("outputwave_verilog.csv", "w");
        for (i = 0; i < 75; i = i + 1) begin
            
            $fwrite(file, "%0d, %0d\n", phase >> 9, Output);
	    #10;


            phase = phase + PhaseIn;
        end
	
	$fclose(file);


        $finish;
    end
endmodule

