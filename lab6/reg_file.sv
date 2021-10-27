
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

		reg_16 u_reg_16(
			//ports
			.Clk       		( Clk       		),
			.Reset     		( Reset     		),
			.Load			( LD_REG			),
			.Din       		( Bus_In       		),
			.Dout      		( SR1_Out      		)
		);
		reg_16 u2_reg_16(
			//ports
			.Clk       		( Clk       		),
			.Reset     		( Reset     		),
			.Load			( LD_REG			),
			.Din       		( Bus_In       		),
			.Dout      		( SR2_Out      		)
		);
endmodule
