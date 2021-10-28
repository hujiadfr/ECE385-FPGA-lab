module Control_Unit (
    input logic Clk, ClearA_LoadB, Run, Reset,
                M,  // Right most significant digit of B.
                    // for first 7 digits, do A+S->A, (ADD)
                    // for the 8th digits, do A-S->A. (SUB)
                    // S == A

    output logic SHIFT_XAB,     // when high, shift XAB
                 fn,            // 0 when ADD, 1 when SUB.
                 LoadA, LoadB, LoadX, Clear_XA,control_add //control add is signal to control status o f9bit_adder
);
    enum logic [4:0] {REST,ADD1,SHIFT1,ADD2,SHIFT2,ADD3,SHIFT3,ADD4,SHIFT4,ADD5,SHIFT5,ADD6,SHIFT6,ADD7,SHIFT7,SUB,SHIFT8,END} curr_state, next_state;

	//updates flip flop, current state is the only one
    always_ff @( posedge Clk ) 
    begin
        if (~Reset)
            curr_state <= REST;
        else begin
            curr_state <= next_state;
        end
    end

    // Assign next_state based on curr_state
    always_comb
    begin
			next_state = curr_state;
        unique case (curr_state)
            REST :   if (~Run)     // rest/start state
                            next_state = ADD1;
            // Each time starts execute, 8 bits are processed. So we need 8 execute states.	  
            // Note that, we need 'count' to help determine the next_state of 'SHIFT' state.
            // See detailed next_state of SHIFT in next 'case' block.
            ADD1 :   next_state = SHIFT1;
            SHIFT1: next_state = ADD2;

            ADD2 :   next_state = SHIFT2;
            SHIFT2: next_state = ADD3;

            ADD3 :   next_state = SHIFT3;
            SHIFT3: next_state = ADD4;

            ADD4 :   next_state = SHIFT4;
            SHIFT4: next_state = ADD5;

            ADD5 :   next_state = SHIFT5;
            SHIFT5: next_state = ADD6;

            ADD6 :   next_state = SHIFT6;
            SHIFT6: next_state = ADD7;

            ADD7 :   next_state = SHIFT7;
            SHIFT7: next_state = SUB;

            SUB :   next_state = SHIFT8;
            SHIFT8: next_state = END;

            // end execute, wait for ~Run
            END :   if (Run)
                        next_state = REST;
            default:         next_state = curr_state;

        endcase
//		end
//		
//		always_ff @(posedge Clk)
//		begin
        
        // In common case, we don't load anything parallelly, or clean XA, or shift XAB. 
        // i.e. Do nothing, until we are in calculation or receive ~ClearA_LoadB = 1'b1.

	    // Assign outputs based on curr_state
        fn = 1'b0;
        LoadA = 1'b0;
        LoadB = 1'b0;
        LoadX = 1'b0;
        Clear_XA = 1'b0;
        SHIFT_XAB = 1'b0;//default case, can also have default assignments for Ld_A and Ld_B before case
        case (curr_state)
            REST:
                begin
                    // In Rest state, we need always clean Reg_A and Reg_X. Load B when need.
                    LoadB = ~ClearA_LoadB;
                    Clear_XA = (~ClearA_LoadB)|(~Run);
                    LoadA = 1'b0;
                    LoadX = 1'b0;
                    SHIFT_XAB = 1'b0;
					control_add = 1'b0;
                    fn = 1'b0;
                end
            ADD1:  
                begin                  
                    LoadA = 1'b1;
                    LoadX = 1'b1;
                    LoadB = 1'b0;
                    Clear_XA = 1'b0;
                    SHIFT_XAB = 1'b0;
					control_add = M;
                    fn = 1'b0;  // A+S->XA
                end
            SHIFT1:
                begin
                    SHIFT_XAB = 1'b1;
                    LoadA = 1'b0;
                    LoadX = 1'b0;
                    LoadB = 1'b0;
                    Clear_XA = 1'b0;
                    control_add = 1'b0;
                    fn = 1'b0;
                end
            ADD2:  
                begin                  
                    LoadA = 1'b1;
                    LoadX = 1'b1;
                    LoadB = 1'b0;
                    Clear_XA = 1'b0;
                    SHIFT_XAB = 1'b0;
					control_add = M;
                    fn = 1'b0;  // A+S->XA
                end
            SHIFT2:
                begin
                    SHIFT_XAB = 1'b1;
                    LoadA = 1'b0;
                    LoadX = 1'b0;
                    LoadB = 1'b0;
                    Clear_XA = 1'b0;
                    control_add = 1'b0;
                    fn = 1'b0;
                end
            ADD3:  
                begin                  
                    LoadA = 1'b1;
                    LoadX = 1'b1;
                    LoadB = 1'b0;
                    Clear_XA = 1'b0;
                    SHIFT_XAB = 1'b0;
					control_add = M;
                    fn = 1'b0;  // A+S->XA
                end
            SHIFT3:
                begin
                    SHIFT_XAB = 1'b1;
                    LoadA = 1'b0;
                    LoadX = 1'b0;
                    LoadB = 1'b0;
                    Clear_XA = 1'b0;
                    control_add = 1'b0;
                    fn = 1'b0;
                end
            ADD4:  
                begin                  
                    LoadA = 1'b1;
                    LoadX = 1'b1;
                    LoadB = 1'b0;
                    Clear_XA = 1'b0;
                    SHIFT_XAB = 1'b0;
					control_add = M;
                    fn = 1'b0;  // A+S->XA
                end
            SHIFT4:
                begin
                    SHIFT_XAB = 1'b1;
                    LoadA = 1'b0;
                    LoadX = 1'b0;
                    LoadB = 1'b0;
                    Clear_XA = 1'b0;
                    control_add = 1'b0;
                    fn = 1'b0;
                end
            ADD5:  
                begin                  
                    LoadA = 1'b1;
                    LoadX = 1'b1;
                    LoadB = 1'b0;
                    Clear_XA = 1'b0;
                    SHIFT_XAB = 1'b0;
					control_add = M;
                    fn = 1'b0;  // A+S->XA
                end
            SHIFT5:
                begin
                    SHIFT_XAB = 1'b1;
                    LoadA = 1'b0;
                    LoadX = 1'b0;
                    LoadB = 1'b0;
                    Clear_XA = 1'b0;
                    control_add = 1'b0;
                    fn = 1'b0;
                end
            ADD6:  
                begin                  
                    LoadA = 1'b1;
                    LoadX = 1'b1;
                    LoadB = 1'b0;
                    Clear_XA = 1'b0;
                    SHIFT_XAB = 1'b0;
                    control_add = M;
                    fn = 1'b0;  // A+S->XA
                end
            SHIFT6:
                begin
                    SHIFT_XAB = 1'b1;
                    LoadA = 1'b0;
                    LoadX = 1'b0;
                    LoadB = 1'b0;
                    Clear_XA = 1'b0;
                    control_add = 1'b0;
                    fn = 1'b0;
                end
            ADD7:  
                begin                  
                    LoadA = 1'b1;
                    LoadX = 1'b1;
                    LoadB = 1'b0;
                    Clear_XA = 1'b0;
                    SHIFT_XAB = 1'b0;
                    control_add = M;
                    fn = 1'b0;  // A+S->XA
                end
            SHIFT7:
                begin
                    SHIFT_XAB = 1'b1;
                    LoadA = 1'b0;
                    LoadX = 1'b0;
                    LoadB = 1'b0;
                    Clear_XA = 1'b0;
                    control_add = 1'b0;
                    fn = 1'b0;
                end
            SUB:
                begin
                    LoadA = 1'b1;
                    LoadX = 1'b1;
                    LoadB = 1'b0;
                    Clear_XA = 1'b0;
                    SHIFT_XAB = 1'b0;
                    control_add = M;
                    fn = 1'b1; // A-S->XA
                end
            SHIFT8:
                begin
                    SHIFT_XAB = 1'b1;
                    LoadA = 1'b0;
                    LoadX = 1'b0;
                    LoadB = 1'b0;
                    Clear_XA = 1'b0;
                    control_add = 1'b0;
                    fn = 1'b0;
                end
			END: 
				begin
                    LoadA = 1'b0;
                    LoadB = 1'b0;
                    LoadX = 1'b0;
                    Clear_XA = 1'b0;
                    control_add = 1'b0;
                    SHIFT_XAB = 1'b0;//default case, can also have default assignments for Ld_A and Ld_B before case
				end
            default: 
                begin
                    LoadA = 1'b0;
                    LoadB = 1'b0;
                    LoadX = 1'b0;
                    Clear_XA = 1'b0;
                    control_add = 1'b0;
                    SHIFT_XAB = 1'b0;//default case, can also have default assignments for Ld_A and Ld_B before case
				end
        endcase
    end
endmodule
