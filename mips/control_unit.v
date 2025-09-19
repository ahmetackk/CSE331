module control_unit(input [5:0] opcode, output reg_dst, output reg_write,
                    output alu_src, output mem_read, output mem_write, output branch);
    always @(*) begin
        case (opcode)
            6'b000000: begin // R-Type
                reg_dst = 1; alu_src = 0; reg_write = 1; mem_read = 0; mem_write = 0; branch = 0;
            end
            6'b100011: begin // lw
                reg_dst = 0; alu_src = 1; reg_write = 1; mem_read = 1; mem_write = 0; branch = 0;
            end
            6'b101011: begin // sw
                reg_dst = 0; alu_src = 1; reg_write = 0; mem_read = 0; mem_write = 1; branch = 0;
            end
            // Diğer talimatlar eklenebilir.
            default: begin
                reg_dst = 0; alu_src = 0; reg_write = 0; mem_read = 0; mem_write = 0; branch = 0;
            end
        endcase
    end
endmodule
