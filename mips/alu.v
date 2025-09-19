module alu(input [31:0] operand1, input [31:0] operand2, input [3:0] alu_control,
           output reg [31:0] result, output zero);
    always @(*) begin
        case (alu_control)
            4'b0010: result = operand1 + operand2; // Add
            4'b0110: result = operand1 - operand2; // Sub
            4'b0000: result = operand1 & operand2; // And
            4'b0001: result = operand1 | operand2; // Or
            4'b0111: result = (operand1 < operand2) ? 1 : 0; // Slt
            default: result = 0;
        endcase
    end
    assign zero = (result == 0);
endmodule
