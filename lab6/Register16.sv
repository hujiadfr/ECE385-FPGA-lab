module reg_16 (
        input logic Clk, Reset, Load
        input logic [15:0] Din,
        output logic Shift_Out,
        output logic [15:0] Dout
    );
    always_ff @ (posedge Clk or posedge Reset) begin
        if (Reset) // Asynchronous Reset
            Dout <= 16'h0;
        else if (Load)
            Dout <= Din[7:0];
    end
endmodule