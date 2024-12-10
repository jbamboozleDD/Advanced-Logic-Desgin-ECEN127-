module Phase_Register(PhaseIn, Load, Clk, Phase);
    input [15:0] PhaseIn;
    input Load, Clk;
    output reg [15:0] Phase;

    always @(posedge Clk) begin
      	if (Load) begin
            Phase <= PhaseIn; // Load new phase value
	end
    end
endmodule



module Phase_Accumulator(Clk, Rst, PhaseIncrement, Phase);
	input Clk;
	input Rst;
	input [15:0] PhaseIncrement;
	output reg [15:0] Phase;
	
	always @(posedge Clk or negedge Rst) begin
		if (!Rst) begin
			Phase <= 0;
		end
		else begin
			Phase <= Phase + PhaseIncrement;
		end
	end
endmodule


module Rounder (Phase, RoundedPhase, FractionalPhase);
	input [15:0] Phase;
	output [6:0] RoundedPhase;
	output [8:0] FractionalPhase;
	assign RoundedPhase = Phase[15:9]; //7 bits upwards
	assign FractionalPhase = Phase[8:0]; //9 bits lower

endmodule


module WavetableROM1 (Address, Sample1);
    input [6:0] Address;             // 7-bit address (from RoundedPhase)
    output reg [7:0] Sample1;        // 8-bit output (ROM data)
    reg [7:0] ROM [0:127];           // 128-entry ROM (8-bit values)

    initial begin
        $readmemh("rom_data.txt", ROM); // Initialize with precomputed sine values
    end

    always @(*) begin
        Sample1 = ROM[Address]; // Fetch current sample
    end
endmodule



module WavetableROM2 (Address, Sample2);
    input [6:0] Address;             // 7-bit address (from RoundedPhase + 1)
    output reg [7:0] Sample2;        // 8-bit output (ROM data)
    reg [7:0] ROM [0:127];           // 128-entry ROM (8-bit values)

    initial begin
        $readmemh("rom_data.txt", ROM); // Initialize with shifted sine values
    end

    always @(*) begin
        Sample2 = ROM[(Address+1) % 128]; // Fetch next sample
    end
endmodule



module Interpolator(Sample1, Sample2, FractionalPhase, Output);
    input [7:0] Sample1;    
    input [7:0] Sample2;   
    input [8:0] FractionalPhase;  
    output [11:0] Output;  

    parameter PHASE_FRAC_BITS = 9; 
    parameter WAVETABLE_OUTPUT_BITS = 8; 
    parameter INTERP_OUTPUT_BITS = 12;  

    wire [16:0] split1;
    wire [16:0] split2;
    wire [16:0] result;


    assign split1 = ((1 << PHASE_FRAC_BITS) - FractionalPhase) * Sample1; // (PHASE_UNIT - frac) * s1
    assign split2 = FractionalPhase * Sample2;                            // frac * s2


    assign result = split1 + split2;


    assign Output = result >> (WAVETABLE_OUTPUT_BITS + PHASE_FRAC_BITS - INTERP_OUTPUT_BITS);
endmodule

module WavetableROM (Address, CP_increment, Sample);
	input [6:0] Address;
	input CP_increment;
	output reg [7:0] Sample;
	
	reg [7:0] ROM [0:127];

	initial begin
		$readmemh("rom_data.txt", ROM);
	end

	always @(*) begin
		Sample = ROM[(Address + CP_increment) % 128];
	end
endmodule

module ControlPath (Clk, Rst, Sample, Interpolator_en, CP_increment, En);
	input Clk, Rst;
	output reg Sample;
	output reg Interpolator_en;
	output reg CP_increment;
	output reg En;

	always @(posedge Clk or negedge Rst) begin
		if (!Rst) begin
			Sample <= 0;
			Interpolator_en <= 0;
			En <= 0;
			CP_increment <= 0;
		end
		else begin
			    En <= ~En;  // Toggles enable signal every clock
			    Sample <= En;  // Use En to control toggling of Sample
			    Interpolator_en <= En;
			    CP_increment <= En;  // Increment based on En
		end
	end
endmodule

module Interpolator2(Sample, FractionalPhase, Enable, Output);
    input [7:0] Sample;     
    input [8:0] FractionalPhase;   
    input Enable;            
    output reg [11:0] Output;

    parameter PHASE_FRAC_BITS = 9;        
    parameter WAVETABLE_OUTPUT_BITS = 8;  
    parameter INTERP_OUTPUT_BITS = 12;   

    wire [16:0] split1;        
    wire [16:0] split2;           
    wire [16:0] result;           

    reg [7:0] s1;

    
    assign split1 = ((1 << PHASE_FRAC_BITS) - FractionalPhase) * s1; // (PHASE_UNIT - frac) * s1
    assign split2 = FractionalPhase * Sample;                            // frac * s2


    assign result = split1 + split2;


    always @(posedge Enable or negedge Enable) begin
	if (!Enable) begin
	    s1 <= Sample;
	end
        else begin
            Output <= result >> (WAVETABLE_OUTPUT_BITS + PHASE_FRAC_BITS - INTERP_OUTPUT_BITS);
	end
    end
endmodule

module Phase_Accumulator2(Clk, Rst, PhaseIncrement, en, Phase);
	input Clk;
	input Rst;
	input [15:0] PhaseIncrement;
	input en;
	output reg [15:0] Phase;


	
	always @(posedge Clk or negedge Rst) begin
		if (!Rst) begin
			Phase <= 0;
		end
		else if (en) begin
			Phase <= Phase + PhaseIncrement;
		end

	end
endmodule







