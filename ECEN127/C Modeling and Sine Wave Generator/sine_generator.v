module sine_generator(Clk, Rst, Load, PhaseIn, Output);
    input Clk, Rst, Load;
    input [15:0] PhaseIn;
    output [11:0] Output;

    wire [15:0] PhaseAccumOut;
    wire [15:0] PhaseIncrement;
    wire [6:0] RoundedPhase;
    wire [8:0] FractionalPhase;
    wire [7:0] Sample1, Sample2;



    Phase_Register u1 (PhaseIn, Load, Clk, PhaseIncrement);

    Phase_Accumulator u2 (Clk, Rst, PhaseIncrement, PhaseAccumOut);

    Rounder u3 (PhaseAccumOut, RoundedPhase, FractionalPhase);

    WavetableROM1 u4 (RoundedPhase, Sample1);

    WavetableROM2 u5 (RoundedPhase, Sample2);

    Interpolator u6 (Sample1, Sample2, FractionalPhase, Output);

endmodule
