module palette (
               input logic [7:0] code,
               output logic [7:0] R, G, B
               );
					
//logic [23:0] out;
// assign R = out[23:16];
// assign G = out[15:8];
// assign B = out[7:0];

always_comb
begin
		case(code)
            8'b00000000:
            begin
                R = 8'h80;
                B = 8'h00;
                G = 8'h80;
            end
            8'b00000001:
            begin
                R = 8'h00;
                B = 8'h00;
                G = 8'h00;
            end
            8'b00000010:
            begin
                R = 8'hf8;
                B = 8'h38;
                G = 8'h00;
            end
            8'b00000011:
            begin
                R = 8'hf0;
                B = 8'hd0;
                G = 8'hb0;
            end
            8'b00000100:
            begin
                R = 8'h50;
                B = 8'h30;
                G = 8'h00;
            end
            8'b00000101:
            begin
                R = 8'hff;
                B = 8'he0;
                G = 8'ha8;
            end
            8'b00000110:
            begin
                R = 8'h00;
                B = 8'h58;
                G = 8'hf8;
            end
            8'b00000111:
            begin
                R = 8'hfc;
                B = 8'hfc;
                G = 8'hfc;
            end
            8'b00001000:
            begin
                R = 8'hbc;
                B = 8'hbc;
                G = 8'hbc;
            end
            8'b00001001:
            begin
                R = 8'ha4;
                B = 8'h00;
                G = 8'h00;
            end
            8'b00010000:
            begin
                R = 8'hd8;
                B = 8'h28;
                G = 8'h00;
            end
            8'b00010001:
            begin
                R = 8'hfc;
                B = 8'h74;
                G = 8'h60;
            end
            8'b00010010:
            begin
                R = 8'hfc;
                B = 8'hbc;
                G = 8'hb0;
            end
            8'b00010011:
            begin
                R = 8'hf0;
                B = 8'hbc;
                G = 8'h3c;
            end
            8'b00010010:
            begin
                R = 8'hae;
                B = 8'hac;
                G = 8'hae;
            end
            8'b00010101:
            begin
                R = 8'h36;
                B = 8'h33;
                G = 8'h01;
            end
            8'b00010110:
            begin
                R = 8'h6c;
                B = 8'h6c;
                G = 8'h01;
            end
            8'b00010111:
            begin
                R = 8'hbb;
                B = 8'hbd;
                G = 8'h00;
            end
            8'b00011000:
            begin
                R = 8'h88;
                B = 8'hd5;
                G = 8'h00;
            end
            8'b00011001:
            begin
                R = 8'h39;
                B = 8'h88;
                G = 8'h02;
            end
            8'b00100000:
            begin
                R = 8'h65;
                B = 8'hb0;
                G = 8'hff;
            end
            8'b00010001:
            begin
                R = 8'h15;
                B = 8'h5e;
                G = 8'hd8;
            end
            8'b00100010:
            begin
                R = 8'h24;
                B = 8'h18;
                G = 8'h8a;
            end
				default:
				begin
					R = 8'h00;
					B = 8'h00;
					G = 8'h00;
				end
        endcase
end
endmodule