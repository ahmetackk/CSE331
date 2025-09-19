module data_memory(
    input clk,                     // Saat sinyali
    input [31:0] address,          // Bellek adresi
    input [31:0] write_data,       // Belleğe yazılacak veri
    input mem_read,                // Bellekten okuma kontrol sinyali
    input mem_write,               // Belleğe yazma kontrol sinyali
    output reg [31:0] read_data    // Bellekten okunan veri
);
    reg [31:0] memory [0:255];     // 256 kelimelik data memory (32-bit kelime genişliği)

    // Bellekten veri okuma
    always @(*) begin
        if (mem_read)
            read_data = memory[address[9:2]]; // Word-aligned access
        else
            read_data = 32'b0;
    end

    // Belleğe veri yazma (yazma işlemi senkron)
    always @(posedge clk) begin
        if (mem_write)
            memory[address[9:2]] <= write_data;
    end
endmodule
