module Phase_Register(PhaseIn, Load, Clk, Phaseinc);
    input [15:0] PhaseIn;
    input Load, Clk;
    output reg [15:0] Phaseinc;

    always @(posedge Clk) begin
      	if (Load) Phaseinc <= PhaseIn; // Load new phase value
    end
endmodule


module Phase_Accumulator2(Clk, Rst, Phaseinc, en, Phase);
	input Clk;
	input Rst;
	input [15:0] Phaseinc;
	input en;
	output reg [15:0] Phase;

	always @(posedge Clk or negedge Rst) begin
		if (!Rst) Phase <= 0;
		else if(en) Phase <= Phase + Phaseinc;
	end
endmodule


module Rounder (Phase, RoundedPhase, FractionalPhase);
	input [15:0] Phase;
	output [6:0] RoundedPhase;
	output [8:0] FractionalPhase;
	assign RoundedPhase = Phase[15:9]; //7 bits upwards
	assign FractionalPhase = Phase[8:0]; //9 bits lower

endmodule


module WavetableROM (Address, CP_increment, Sample);
	input [6:0] Address;
	input CP_increment;
	output reg [7:0] Sample;
	
	reg [7:0] ROM [0:127];

	initial begin
		$readmemh("rom_data.txt", ROM);
	end

	always @(CP_increment) begin
		Sample = ROM[(Address + CP_increment) % 128];
	end
endmodule


module ControlPath (Clk, Rst, En);
	input Clk, Rst;
	output reg En;

	always @(posedge Clk or negedge Rst) begin
		if (!Rst) En <= 0;
		else begin
			En <= ~En;  // Toggles enable signal every other clock
		end
	end
endmodule


module Interpolator2(Sample, FractionalPhase, Enable, Output);
    input [7:0] Sample;     
    input [8:0] FractionalPhase;   
    input Enable;            
    output [11:0] Output;

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

    always @(Enable) begin
		if (!Enable) begin
			s1 <= Sample;
		end
        /*else begin
            Output <= result >> (WAVETABLE_OUTPUT_BITS + PHASE_FRAC_BITS - INTERP_OUTPUT_BITS);
		end*/
    end
	assign Output = result >> (WAVETABLE_OUTPUT_BITS + PHASE_FRAC_BITS - INTERP_OUTPUT_BITS);
endmodule







