
//just for test
module reg_file(input logic Clk,
					 input logic Reset,
					 input logic LD_REG,
					 input logic [2:0]DR_In,
					 input logic [2:0]SR2,
					 input logic [2:0]SR1,
					 input logic [15:0]Bus_In,
					 output logic [15:0] SR1_Out,
					 output logic [15:0] SR2_Out);
					 
	logic [7:0][15:0] Reg_unit;
	
//transfer the Correspond register

	case (SR1)
		reg_16 u_reg_16(
			//ports
			.Clk       		( Clk       		),
			.Reset     		( Reset     		),
			.Din       		( Bus_In       		),
			.load			( LD_REG			),
			.Shift_Out 		(  		),
			.Dout      		( SR1_Out      		)
		);
	endcase
	case (SR2)
		reg_16 u_reg_16(
			//ports
			.Clk       		( Clk       		),
			.Reset     		( Reset     		),
			.Din       		( Bus_In       		),
			.load			( LD_REG			),
			.Shift_Out 		(  		),
			.Dout      		( SR2_Out      		)
		);
	endcase
	

endmodule