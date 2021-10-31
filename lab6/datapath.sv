module datapath(
	input logic Clk,
	input logic Reset,
	input logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED,
	input logic GatePC, GateMDR, GateALU, GateMARMUX,
	input logic [1:0] PCMUX, ADDR2MUX, ALUK,
	input logic DRMUX, SR1MUX, SR2MUX, ADDR1MUX,
	input logic MIO_EN,
	input logic [15:0]MDR_In,
	output logic BEN,
	output logic [11:0]LED,
	output logic [15:0]IR,
	output logic [15:0]MAR,
	output logic [15:0]MDR,
	output logic [15:0]PC
);
logic [15:0] Bus,PC_IN,ADD_OUT,MDR_DATA,ALU_OUT,Adder_OUT,MDR_value;
					 
//create registers
reg_16 MDR_reg(.*,.Load(LD_MDR),.Din(MDR_value),.Dout(MDR));//attention!

reg_16 MAR_reg(.*,.Load(LD_MAR),.Din(Bus),.Dout(MAR));

reg_16 PC_reg(.*,.Load(LD_PC),.Din(PC_IN),.Dout(PC));

reg_16 IR_reg(.*,.Load(LD_IR),.Din(Bus),.Dout(IR));


logic[15:0] PC_next;
//create Mux
Mux4 PC_mux(.Select(PCMUX),.A(PC_next),.B(Bus),.C(ADD_OUT),.D(16'h0000),.out(PC_IN));// only first is correct

Mux2 MDR_mux(.Select(MIO_EN),.A(Bus),.B(MDR_In),.out(MDR_value)); 
	 
Mux_bus  bus_mux(.Select({GatePC, GateMDR, GateALU, GateMARMUX}),.A(Adder_OUT),.B(ALU_OUT),.C(MDR),.D(PC),.out(Bus));

	 
	 
	 

always_comb
begin	 
	ADD_OUT=16'b0;
	PC_next=PC+1;
end

endmodule
