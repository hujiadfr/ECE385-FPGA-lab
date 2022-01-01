module choose_state (
    input Clk, 
	input logic [9:0] DrawX, DrawY,
    input logic [2:0] choose_ship1, choose_ship2,
    input logic ship1_choose_ready, ship2_choose_ready,
    output logic is_choose_state_data,
	output logic [3:0] choose_state_data
);
    parameter player1_X = 10'd160;
    parameter player1_Y = 10'd240;
    parameter player2_X = 10'd480;
    parameter player2_Y = 10'd240;
    parameter RESHAPE_LENGTH = 10'd80;
    parameter HALF_LENGTH = 10'd40;

    logic [18:0] read_address1, read_address2;
    assign read_address1 = (DrawX-player1_X) + HALF_LENGTH + (DrawY-player1_Y+HALF_LENGTH)*RESHAPE_LENGTH;
    assign read_address2 = (DrawX-player2_X) + HALF_LENGTH + (DrawY-player2_Y+HALF_LENGTH)*RESHAPE_LENGTH;

    int Size;
    assign Size = HALF_LENGTH;

    logic is_player1, is_player2;
    always_comb begin
        if ( 
                (DrawX - player1_X <= Size || player1_X-DrawX <= Size) && 
                (DrawY - player1_Y <= Size || player1_Y-DrawY <= Size)
            ) 
            is_player1 = 1'b1;
        else
            is_player1 = 1'b0;

        if ( 
                (DrawX - player2_X <= Size || player2_X-DrawX <= Size) && 
                (DrawY - player2_Y <= Size || player2_Y-DrawY <= Size)
            ) 
            is_player2 = 1'b1;
        else
            is_player2 = 1'b0;
    end

    always_ff @ (posedge Clk) begin
        if (is_player1 || is_player2)
            is_choose_state_data <= 1'b1;
        else
            is_choose_state_data <= 1'b0;
    end

    
endmodule

module  ship_choose_RAM
(
    input Clk,
    input [18:0] read_address1, read_address2,
    input [2:0]  choose_ship1, choose_ship2,
    input        is_player1, is_player2,
    output logic [3:0] choose_state_data
);
    parameter RESHAPE_LENGTH = 10'd80;

    logic [3:0] mem0 [0:RESHAPE_LENGTH*RESHAPE_LENGTH];
    logic [3:0] mem1 [0:RESHAPE_LENGTH*RESHAPE_LENGTH];
    logic [3:0] mem2 [0:RESHAPE_LENGTH*RESHAPE_LENGTH];
    // logic [3:0] mem3 [0:RESHAPE_LENGTH*RESHAPE_LENGTH];
    // logic [3:0] mem4 [0:RESHAPE_LENGTH*RESHAPE_LENGTH];

    initial
    begin
        $readmemh("sources/bisimai.txt",    mem0);
        $readmemh("sources/gelunbiya.txt",  mem1);
        $readmemh("sources/lafei.txt",      mem2);
        // $readmemh("sources/dujiaoshou.txt", mem3);
        // $readmemh("sources/diye.txt",       mem4);
    end

    always_ff @ (posedge Clk) begin
        if (is_player1) begin
            case(choose_ship1)
                6'd0:   choose_state_data<= mem0[read_address1];
                6'd1:   choose_state_data<= mem1[read_address1];
                6'd2:   choose_state_data<= mem2[read_address1];
                // 6'd3:   choose_state_data<= mem3[read_address1];
                // 6'd4:   choose_state_data<= mem4[read_address1];
                // 6'd5:   choose_state_data<= mem5[read_address1];
                default:   choose_state_data<= mem0[read_address1];
            endcase
        end
        else if (is_player2) begin
            case(choose_ship2)
                6'd0:   choose_state_data<= mem0[read_address2];
                6'd1:   choose_state_data<= mem1[read_address2];
                6'd2:   choose_state_data<= mem2[read_address2];
                // 6'd3:   choose_state_data<= mem3[read_address2];
                // 6'd4:   choose_state_data<= mem4[read_address2];
                // 6'd5:   choose_state_data<= mem5[read_address2];
                default:   choose_state_data<= mem0[read_address2];
            endcase
        end
        else
            choose_state_data<= mem0[0];    // background
    end
endmodule