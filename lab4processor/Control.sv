//Two-always example for state machine

module control (input  logic Clk, Reset, LoadA, LoadB, Execute,
                output logic Shift_En, Ld_A, Ld_B );

    // Declare signals curr_state, next_state of type enum
    // with enum values of A, B, ..., I, Z as the state values
	 // Note that the length implies a max of 8 states, so you will need to bump this up for 8-bits
    enum logic [4:0] {A, B, C, D, E, F, G, H, I, Z}   curr_state, next_state; 

	//updates flip flop, current state is the only one
    always_ff @ (posedge Clk)  
    begin
        if (Reset)
            curr_state <= A;
        else 
            curr_state <= next_state;
    end

    // Assign outputs based on state
	always_comb
    begin
        
		  next_state  = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 

            A :    if (Execute)		// rest/start state
                       next_state = B;
							  
				// Each time starts execute, 8 bits are processed. So we need 8 execute states	  
            B :    next_state = C;	// 1
            C :    next_state = D;	// 2
            D :    next_state = E;	// 3
            E :    next_state = F;	// 4
				F :	 next_state = G;	// 5
				G : 	 next_state = H;	// 6
				H : 	 next_state = I;	// 7
				I : 	 next_state = Z;	// 8
				
				// end execute, wait for ~Execute
            Z :    if (~Execute) 
                       next_state = A;
        endcase
   
		  // Assign outputs based on ‘state’
        case (curr_state) 
	   	   A: 
	         begin
                Ld_A = LoadA;
                Ld_B = LoadB;
                Shift_En = 1'b0;
		      end
	   	   Z: 
		      begin
                Ld_A = 1'b0;
                Ld_B = 1'b0;
                Shift_En = 1'b0;
		      end
	   	   default:  //default case, can also have default assignments for Ld_A and Ld_B before case
		      begin 
                Ld_A = 1'b0;
                Ld_B = 1'b0;
                Shift_En = 1'b1;
		      end
        endcase
    end

endmodule
