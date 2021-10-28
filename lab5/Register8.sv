module reg_8 (
        input logic Clk, Reset, Load, Shift_In, Shift_En, //shift in is bit from last register, and shift_En control the shift status
        input logic [7:0] Din,  //parallel load
        output logic Shift_Out, //output bit for shift
        output logic [7:0] Dout 
    );
    always_ff @ (posedge Clk or posedge Reset) begin
        if (Reset) // Asynchronous Reset
            Dout <= 8'h0;
        else if (Load)
            Dout <= Din[7:0];
        else if (Shift_En)
            Dout <= { Shift_In, Dout[7:1] };
    end
    assign Shift_Out = Dout[0];
endmodule