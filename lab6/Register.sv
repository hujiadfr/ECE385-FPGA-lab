module reg_16 (
        input logic Clk, Reset, Load,
        input logic [15:0] Din,
        output logic [15:0] Dout
    );
    always_ff @ (posedge Clk or posedge Reset) begin
        if (Reset) // Asynchronous Reset
            Dout <= 16'h0;
        else if (Load)
            Dout <= Din;
    end
endmodule
module reg_1 (
        input logic Clk, Reset, Load,
        input logic Din,
        output logic Dout
    );
    always_ff @ (posedge Clk or posedge Reset) begin
        if (Reset) // Asynchronous Reset
            Dout <= 2'b0;
        else if (Load)
            Dout <= Din;
    end
endmodule
module reg_3 (
        input logic Clk, Reset, Load,
        input logic[2:0] Din,
        output logic[2:0] Dout
    );
    always_ff @ (posedge Clk or posedge Reset) begin
        if (Reset) // Asynchronous Reset
            Dout <= 2'b000;
        else if (Load)
            Dout <= Din;
    end
endmodule
module reg_12 (
        input logic Clk, Reset, Load,
        input logic[11:0] Din,
        output logic[11:0] Dout
    );
    always_ff @ (posedge Clk or posedge Reset) begin
        if (Reset) // Asynchronous Reset
            Dout <= 2'b000000000000;
        else if (Load)
            Dout <= Din;
    end
endmodule
