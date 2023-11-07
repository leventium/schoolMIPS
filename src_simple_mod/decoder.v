module decoder (
    input clk,
    input key[2:0],
    output out[7:0]
);
    always @(posedge clk)
        out <= 1'b1 << key;

endmodule
