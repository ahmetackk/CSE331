
// Top-Level Single Cycle MIPS Processor
module SingleCycleMIPS(
    input clk,
    input rst
);
    wire [31:0] pc, next_pc, alu_src_mux_out, instruction, write_data, read_data1, read_data2, alu_result, read_data_mem, sign_ext_imm;
    wire [4:0] write_reg;
    wire [2:0] alu_control;
    wire reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, zero;
	 
	 
    // Modules
    PcModule pc_module(.clk(clk), .rst(rst), .next_pc(next_pc), .pc(pc));
    InstructionFetch if_module(.pc(pc), .instruction(instruction));
    RegisterFile rf_module(.clk(clk), .we(reg_write), .rs(instruction[25:21]), .rt(instruction[20:16]), .rd(write_reg), .write_data(write_data), .read_data1(read_data1), .read_data2(read_data2));
    AluModule alu_module(.src1(read_data1), .src2(alu_src_mux_out), .alu_control(alu_control), .result(alu_result), .zero(zero));
    DataMemory dm_module(.clk(clk), .we(mem_write), .address(alu_result), .write_data(read_data2), .read_data(read_data_mem));
    ControlUnit cu_module(.opcode(instruction[31:26]), .funct(instruction[5:0]), .reg_dst(reg_dst), .alu_src(alu_src), .mem_to_reg(mem_to_reg), .reg_write(reg_write), .mem_read(mem_read), .mem_write(mem_write), .branch(branch), .alu_control(alu_control));
	 
	 assign sign_ext_imm			= {(instruction[15] ? 16'hFFFF : 16'h0000), instruction[15:0]};
	 
	 //Additional logic here (e.g., branch calculations, muxes, etc.)
	 
	 // Select along to alu_src to which output 
	 assign alu_src_mux_out 	= alu_src ? sign_ext_imm : read_data2;
	 
	 // Write data
	 assign write_data 			= mem_to_reg ? read_data_mem : alu_result;
	 
	 // Select register to write
	 assign write_reg 			= reg_dst ? instruction[15:11] : instruction[20:16]; 
	 
	 // If branch is enabled from control unit add beq address from sign_ext_imm to jump label
	 assign next_pc = (branch && zero) ? pc + 4 + (sign_ext_imm << 2) : 
                     pc + 4;
	 
endmodule
