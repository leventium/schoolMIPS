module decoder (
    input        clk,
    input  [2:0] key,
    output [7:0] out
);
    always @(posedge clk)
        out <= 1'b1 << key;

endmodule
