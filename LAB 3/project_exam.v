genvar i;

generate
    for (i = 0; i < 32; i = i + 1) begin : full_adder_loop
        if (i == 0) begin
            full_adder FA (A[i], B_xor[i], sub_flag, sum[i], carry[i]);
        end else begin
            full_adder FA (A[i], B_xor[i], carry[i-1], sum[i], carry[i]);
        end
    end
endgenerate