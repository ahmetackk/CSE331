module processor_tb;
    reg clk;
    reg reset;

    // Clock sinyali oluştur
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 birimlik saat çevrimi
    end

    // Reset sinyali
    initial begin
        reset = 1;
        #10 reset = 0;
    end

    // İşlemcinin ana modülünü çağır
    processor uut (
        .clk(clk),
        .reset(reset)
    );
endmodule
