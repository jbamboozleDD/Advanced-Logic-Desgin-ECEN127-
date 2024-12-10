module sine_generator2(Clk, Rst, Load, PhaseIn, Sample, Output);
    input Clk, Rst, Load;
    input [15:0] PhaseIn;
    output Sample;     
    output [11:0] Output;     

    wire [15:0] PhaseAccumOut;
    wire [15:0] PhaseIncrement;
    wire [6:0] RoundedPhase;
    wire [8:0] FractionalPhase;
    wire [7:0] Sample;
    wire en;

    Phase_Register u1 (PhaseIn, Load, Clk, PhaseIncrement);
    Phase_Accumulator2 u2 (Clk, Rst, PhaseIncrement, en, PhaseAccumOut);
    Rounder u3 (PhaseAccumOut, RoundedPhase, FractionalPhase);
    ControlPath u4 (Clk, Rst, en);
    WavetableROM u5 (RoundedPhase, en, Sample);
    Interpolator2 u6 (Sample, FractionalPhase, en, Output);
endmodule
