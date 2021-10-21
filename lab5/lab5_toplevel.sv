module lab5_toplevel
(
    input logic             Clk,
    input logic             Reset,
    input logic             ClearA_LoadB,   // control to load.
    input logic             Run,
    input logic[7:0]        S,         // Data in from switch, load to reg_B and reg_S.
      // Hex drivers display both inputs to the adder.
    output logic[6:0]       AhexU,
    output logic[6:0]       AhexL,
    output logic[6:0]       BhexU,
    output logic[6:0]       BhexL,
    output logic[7:0]       Aval,
    output logic[7:0]       Bval,
    output logic            X
);

    /* Declare Internal Wires
     * Wheather an internal logic signal becomes a register or wire depends
     * on if it is written inside an always_ff or always_comb block respectivly */
    logic[6:0]      AhexU_comb;
    logic[6:0]      AhexL_comb;
    logic[6:0]      BhexU_comb;
    logic[6:0]      BhexL_comb;
    logic[7:0]      Aval_comb;
    logic[7:0]      Bval_comb;

    /* Module instantiation
	  * You can think of the lines below as instantiating objects (analogy to C++).
     * The things with names like Ahex0_inst, Ahex1_inst... are like a objects
     * The thing called HexDriver is like a class
     * Each time you instantate an "object", you consume physical hardware on the FPGA
     * in the same way that you'd place a 74-series hex driver chip on your protoboard 
     * Make sure only *one* adder module (out of the three types) is instantiated*/

    wire  [7:0] Sout;    // data from reg_S. The Multiplicand.
    logic [7:0] A;       // data from reg_A, to adder and Aval.
    logic [7:0] B;       // data from reg_B, to adder and Bval.
    logic Xval;             // register store X

    logic [7:0]  ADDout;     // Sum of Adder, we need contain the data in reg_A.
    wire        AB_shift;   // connect shift port A to B. Used when shift_XAB.
    wire        M;          // Right Most Significant Digit of reg_B. The Multiplier.
    wire    control_add; // connect control
    wire  	SHIFT_XAB;
    wire  	fn;
    wire  	LoadA;
    wire  	LoadB;
    wire  	LoadX;
    wire    Clear_XA;
	logic[7:0] reg_A_in;
    logic    RESET_A;
    logic    RESET_B;

    /* Decoders for HEX drivers and output registers
     * Note that the hex drivers are calculated one cycle after Sum so
     * that they have minimal interfere with timing (fmax) analysis.
     * The human eye can't see this one-cycle latency so it's OK. */
    always_ff @(posedge Clk) begin
        AhexU <= AhexU_comb;
        AhexL <= AhexL_comb;
        BhexU <= BhexU_comb;
        BhexL <= BhexL_comb;
        Aval <= A;
        Bval <= B;
        //X <= Xval;

        //Xval <= Xval;
//        if (Clear_XA)
//            Xval <= 1'b0;
//        else if (LoadX)
//            Xval <= ADDout[8]; // In always_ff, work as reg_1
    end

    always_comb
    begin
        RESET_A = (~Reset) | Clear_XA;
        RESET_B = ~Reset;
		  
		if(M)   reg_A_in = ADDout;
        else    reg_A_in = A;
    end
    

        //assign X = 1'b0;
        Control_Unit u_Control_Unit(
            //ports
            .Clk             		( Clk             		),
            .ClearA_LoadB    		( ClearA_LoadB    		),
            .Run             		( Run             		),
            .Reset           		( Reset           		),
            .M               		( M               		),
            // Output
            .SHIFT_XAB       		( SHIFT_XAB       		),
            .fn              		( fn              		),
            .LoadA           		( LoadA           		),
            .LoadB           		( LoadB           		),
            .LoadX           		( LoadX           		),
            .Clear_XA               ( Clear_XA              ),
            .control_add            ( control_add           )
        );

        nine_bit_adder u_nine_bit_adder
        (
            //ports
            .A  		( {A[7],A} 	),
            .B  		( {S[7],S}	),
			.control_add  (control_add ),
			.x1		    (X          ),
            .fn 		( fn 		),
            .S  		( ADDout[7:0] ),
			.x2		    (X           )
        );


        //RegA
        reg_8 reg_A(
            //ports
            .Clk       		( Clk       		),
            .Reset     		( RESET_A   	    ),
            .Load      		( LoadA             ),
            .Shift_En  		( SHIFT_XAB  		),
            .Shift_In  		( X        ),
            .Shift_Out 		( AB_shift 		    ),
            .Din         	( reg_A_in[7:0]     ),
            .Dout  		    ( A[7:0]      	    )
        );

        //RegB
        reg_8 reg_B
        (
            //ports
            .Clk       		( Clk       		),
            .Reset     		( RESET_B     		),
            .Load      		( LoadB          	),
            .Shift_En  		( SHIFT_XAB         ),
            .Shift_In  		( AB_shift  		),
            .Shift_Out 		( M   		        ),
            .Din         	( S[7:0]       	    ),
            .Dout  		    ( B[7:0]  		    )
        );

        // Directly use input S, no need to use a register store it

        // //Reg S
        // reg_8 reg_S(
        //     //ports
        //     .Clk       		( Clk       		),
        //     .Reset     		( ~Reset            ),
        //     .Load      		( LoadS      		),
        //     .Shift_En  		(             		),
        //     .Shift_In  		(             		),
        //     .Shift_Out 		(            		),
        //     .Din            ( S[7:0]      	    ),
        //     .Dout  		    ( Sout[7:0]    	)
        // );


    HexDriver AhexU_inst
    (
        .In0(A[7:4]),
        .Out0(AhexU_comb)
    );
    
    HexDriver AhexL_inst
    (
        .In0(A[3:0]),
        .Out0(AhexL_comb)
    );
    
    HexDriver BhexU_inst
    (
        .In0(B[7:4]),
        .Out0(BhexU_comb)
    );
    
    HexDriver BhexL_inst
    (       
        .In0(B[3:0]),
        .Out0(BhexL_comb)
    );

endmodule