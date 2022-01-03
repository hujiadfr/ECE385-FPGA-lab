module  ship_RAM3   //bisimai 
(
    input Clk,
    input [18:0] read_address1, read_address2,
    output [3:0] data1_11, data1_12, data1_13, data1_14, data1_15,
    output [3:0] data2_11, data2_12, data2_13, data2_14, data2_15
);
    // mem has width of 4 bits and a total of 6399 addresses for pixels

    logic [3:0] mem1_11 [0:6399];
    logic [3:0] mem1_12 [0:6399];
    logic [3:0] mem1_13 [0:6399];
    logic [3:0] mem1_14 [0:6399];
    logic [3:0] mem1_15 [0:6399];

    logic [3:0] mem2_11 [0:6399];
    logic [3:0] mem2_12 [0:6399];
    logic [3:0] mem2_13 [0:6399];
    logic [3:0] mem2_14 [0:6399];
    logic [3:0] mem2_15 [0:6399];

    initial
    begin
        $readmemh("sources/yingrui.png.txt",            mem1_11);
        $readmemh("sources/yingrui_move_left.png.txt",  mem1_12);
        $readmemh("sources/yingrui_move.png.txt",       mem1_13);
        $readmemh("sources/yingrui_attack.png.txt",     mem1_14);
        $readmemh("sources/yingrui_dead.png.txt",       mem1_15);

        $readmemh("sources/yingrui2.png.txt",            mem2_11);
        $readmemh("sources/yingrui2_move.png.txt",       mem2_13);
        $readmemh("sources/yingrui2_move_left.png.txt",  mem2_12);
        $readmemh("sources/yingrui2_attack.png.txt",     mem2_14);
        $readmemh("sources/yingrui2_dead.png.txt",       mem2_15);
    end
    always_ff@ (posedge Clk)
    begin
        data1_11 <= mem1_11[read_address1];
        data1_12 <= mem1_12[read_address1];
        data1_13 <= mem1_13[read_address1];
        data1_14 <= mem1_14[read_address1];
        data1_15 <= mem1_15[read_address1];

        data2_11 <= mem2_11[read_address2];
        data2_12 <= mem2_12[read_address2];
        data2_13 <= mem2_13[read_address2];
        data2_14 <= mem2_14[read_address2];
        data2_15 <= mem2_15[read_address2];
    end

endmodule
