`include "sm_config.vh"
`define OUTPUT 4'h0
`define INPUT  4'h4

module sm_gpio (
    input                       clk,
    input      [31:0]           bAddr,
    input                       bWe,
    input      [31:0]           bWData,
    output reg [31:0]           bRData,

    input      [`GPIO_SIZE-1:0] GpioInput,
    output reg [`GPIO_SIZE-1:0] GpioOutput
);
    wire active;
    assign active = (bAddr[15:4] == 12'hbeb);

    always @(posedge clk) begin
        casez (bAddr[3:0])
            `OUTPUT:  if (active) GpioOutput = bWData[`GPIO_SIZE-1:0];
            `INPUT:   bRData[`GPIO_SIZE-1:0] = GpioInput;
            default: bRData[`GPIO_SIZE-1:0] = GpioInput;
        endcase
    end

endmodule
