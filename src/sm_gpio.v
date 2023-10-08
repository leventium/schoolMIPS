`include "sm_config.vh"

module sm_gpio (
    input                       clk,
    input      [31:0]           bAddr,
    input                       bWe,
    input      [31:0]           bWData,
    output     [31:0]           bRData,

    input      [`GPIO_SIZE-1:0] GpioInput,
    output reg [`GPIO_SIZE-1:0] GpioOutput
);

    localparam blank = 32 - `GPIO_SIZE;

    assign bRData = { { blank { 1'b0 } }, GpioInput };

    always @(posedge clk) begin

        if (bWe && bAddr[15:0] == 16'hbeb0)
            GpioOutput = bWData[`GPIO_SIZE-1:0];

    end

endmodule
