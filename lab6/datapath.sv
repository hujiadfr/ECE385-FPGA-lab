module datapath
(
    input logic Clk,
    input logic Reset,
	input logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED,
	input logic GatePC, GateMDR, GateALU, GateMARMUX,
	input logic [1:0] PCMUX, ADDR2MUX, ALUK,
	input logic DRMUX, SR1MUX, SR2MUX, ADDR1MUX,
	input logic MIO_EN,
	input logic [15:0]MDR_In,
	output logic BEN,
	output logic [15:0]IR,
	output logic [15:0]MAR,
	output logic [15:0]MDR,
	output logic [15:0]PC
);
wire [15:0] Bus, Adder_Out, ALU_Out;	// Bus and the input of Bus
wire [15:0] PC_In, MAR_In;
wire [15:0] SEXT11, SEXT9, SEXT6, SEXT5;// Different SEXT from IR
wire [15:0] Adder1, Adder2;					// Adder input 
wire [15:0] ALUA, ALUB;						// Left and right input of ALU
wire [15:0] SR1_Out, SR2_Out;			// Output from register file
logic [2:0] DR_In, SR1;
logic [2:0] NZP,NZP_val;					// NZP 1 for ture for each
logic BEN_val;								// 1 or 0 for BEN
wire [15:0] PC_Next;						// next pc
logic [15:0] MDR_val;

// sext

//determine NZP

NZP u_NZP(
	//ports
	.Bus     		( Bus     		),
	.NZP_val 		( NZP_val 		)
);

reg_1 Reg_NZP(
	//ports
	.Clk       		( Clk       		),
	.Reset     		( Reset     		),
	.Load      		( LD_CC      		),
	.Din       		( NZP_val       	),
	.Dout      		( NZP         		)
);


always_comb
begin
    Adder_Out = Adder1 + Adder2;
    PC_Next = PC + 1;
    BEN_val = (IR[11]&NZP[2]) + (IR[10]&NZP[1])+(IR[9]&NZP[0])
end

//SEXT

SEXT u_SEXT(
	//ports
	.IR     		( IR     		),
	.SEXT11 		( SEXT11 		),
	.SEXT9  		( SEXT9  		),
	.SEXT6  		( SEXT6  		),
	.SEXT5  		( SEXT5  		)
);

/*--------------------------Mux-----------------------------*/

Mux_Bus u_Mux_Bus(
	//请从右往左看
	.Select 		({GatePC, GateMDR, GateALU, GateMARMUX}),
	.A      		( Adder_Out     ),
	.B      		( ALU_out      	),
	.C      		( MDR      		),
	.D      		( PC      		),
	.Out    		( Bus    		)
);

Mux4 u_Mux4_PC(
	//ports
	.Select 		( PCMUX 		),
	.A      		( PC_Next      	),
	.B      		( Bus           ),
	.C      		( Adder_Out     ),
	.D      		( 16'h0000  	), //我懒得写3mux了
	.Out    		( PC_In    		)
);

// adder left and right input


Mux2 u_Mux2_adder1(
	//ports
	.Select 		( ADDR1MUX 		),
	.A      		( PC      		),
	.B      		( SR1_Out      	),
	.Out    		( Adder1    	)
);


Mux4 u_Mux4_adder2(
	//ports
	.Select 		( ADDR2MUX 		),
	.A      		( 16'h0000 		),
	.B      		( SEXT6      	),
	.C      		( SEXT9      	),
	.D      		( SEXT11    	),
	.Out    		( Adder2    	)
);

Mux2 u_Mux2_SR2(
	//ports
	.Select 		( SR2MUX 		),
	.A      		( SR2_Out      	),
	.B      		( SEXT5    		),
	.Out    		( ALUB    		)
);

wire [15:0] 	Out;
//reg file SR1 in
Mux2 u_Mux2_REGSR1_IN(
	//ports
	.Select 		( SR1MUX 		),
	.A      		( IR[11:9]      ),
	.B      		( IR[8:6]       ),
	.Out    		( SR1    		)
);
//reg file DR input
Mux2 u_Mux2_REGDR_IN(
	//ports
	.Select 		( DRMUX 		),
	.A      		( IR[11:9]  	),
	.B      		( 3'b111      	),
	.Out    		( DR_In    		)
);


Mux2 u_Mux2_MDR(
	//ports
	.Select 		( DRMUX 		),
	.A      		( Bus         	),
	.B      		( MDR_In      	),
	.Out    		( MDR_val    	)
);

/*--------------------------other reg-----------------------------*/

// MAR
reg_1 Reg_MAR (.*, .Din(Bus),.load(LD_MAR),.Dout(MAR));
// MDR
reg_1 Reg_MDR (.*, .Din(MDR_Val),.load(LD_MDR),.Dout(MDR));
// PC
reg_1 Reg_PC  (.*, .Din(PC_In),.load(LD_PC),.Dout(PC));
// IR
reg_1 Reg_IR  (.*, .Din(Bus),.load(LD_IR),.Dout(IR));
// BEN
reg_1 Reg_BEN (.*, .Din(BEN_val),.load(LD_BEN),.Dout(BEN));

/*--------------------------  ALU   -----------------------------*/

ALU u_ALU(
	//ports
	.A       		( SR1_Out       ),
	.B       		( ALUB       		),
	.ALUK    		( ALUK    		),
	.ALU_Out 		( ALU_Out 		)
);

/*--------------------------REG FILE -----------------------------*/


reg_file u_reg_file(
	//ports
	.Clk     		( Clk     		),
	.Reset   		( Reset   		),
	.LD_REG  		( LD_REG  		),
	.DR_In   		( DR_In   		),
	.SR2     		( IR[2:0]     	),
	.SR1     		( SR1     		),
	.Bus_In  		( Bus     		),
	.SR1_Out 		( SR1_Out 		),
	.SR2_Out 		( SR2_Out 		)
);


endmodule


