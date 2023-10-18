module sm_ram
#(
    parameter SIZE = 64
)
(
    input         clk,
    input  [31:0] a, b,
    input         we_a, we_b,
    input  [31:0] wd_a, wd_b,
    output [31:0] rd_a, rd_b
);
    reg [31:0] ram [SIZE - 1:0];
    assign rd_a = ram [a[31:2]];
    assign rd_b = ram [b[31:2]];

    initial begin
        $readmemh ("ram.hex", ram);
    end


    always @(posedge clk)
        if (we_a)
            ram[a[31:2]] <= wd_a;
    
    always @(posedge clk)
        if (we_b)
            ram[b[31:2]] <= wd_b;

endmodule
