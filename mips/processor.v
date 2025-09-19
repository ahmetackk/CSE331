module processor(
    input clk, 
    input reset
);
    // Program Counter (PC) ve ilgili sinyaller
    reg [31:0] pc;          // Program Counter
    wire [31:0] next_pc;    // Bir sonraki PC değeri
    wire [31:0] instruction; // Instruction Memory'den okunan talimat

    // Register File
    wire [31:0] read_data1, read_data2; // Registerlardan okunan veriler
    wire [31:0] write_data;             // Registerlara yazılacak veri
    wire [4:0] write_register;          // Yazılacak register adresi

    // ALU
    wire [31:0] alu_result;             // ALU'dan çıkan sonuç
    wire zero_flag;                     // ALU'nun "sıfır" bayrağı

    // Control Unit Sinyalleri
    wire reg_dst, alu_src, mem_read, mem_write, reg_write, mem_to_reg, branch, jump;
    wire [3:0] alu_op;

    // Sign Extender
    wire [31:0] sign_extended;

    // Data Memory
    wire [31:0] mem_read_data;

    // PC Güncellemesi
    assign next_pc = (jump) ? {pc[31:28], instruction[25:0], 2'b00} : 
                     (branch && zero_flag) ? pc + 4 + (sign_extended << 2) : 
                     pc + 4;

    // --- Modüllerin Bağlantıları ---
    // Program Counter
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 0;
        else
            pc <= next_pc;
    end

    // Instruction Memory
    instruction_memory imem (
        .address(pc), 
        .instruction(instruction)
    );

    // Control Unit
    control_unit ctrl (
        .opcode(instruction[31:26]),
        .reg_dst(reg_dst), 
        .alu_src(alu_src), 
        .mem_read(mem_read), 
        .mem_write(mem_write), 
        .reg_write(reg_write), 
        .mem_to_reg(mem_to_reg), 
        .branch(branch), 
        .jump(jump), 
        .alu_op(alu_op)
    );

    // Register File
    register_file regfile (
        .clk(clk), 
        .reg_write(reg_write), 
        .read_reg1(instruction[25:21]), 
        .read_reg2(instruction[20:16]), 
        .write_reg(write_register), 
        .write_data(write_data), 
        .read_data1(read_data1), 
        .read_data2(read_data2)
    );

    // Sign Extender
    assign sign_extended = {{16{instruction[15]}}, instruction[15:0]};

    // ALU
    alu alu_unit (
        .operand1(read_data1), 
        .operand2(alu_src ? sign_extended : read_data2), 
        .alu_control(alu_op), 
        .result(alu_result), 
        .zero(zero_flag)
    );

    // Data Memory
    data_memory dmem (
        .clk(clk), 
        .address(alu_result), 
        .write_data(read_data2), 
        .mem_read(mem_read), 
        .mem_write(mem_write), 
        .read_data(mem_read_data)
    );

    // Write Back MUX (Memory/ALU to Register File)
    assign write_data = mem_to_reg ? mem_read_data : alu_result;
    assign write_register = reg_dst ? instruction[15:11] : instruction[20:16];

endmodule
