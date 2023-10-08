`include "sm_config.vh"

module sm_matrix (
    input                       clk,
    input      [31:0]           bAddr,
    input                       bWe,
    input      [31:0]           bWData,
    output     [31:0]           bRData,

    input      [`GPIO_SIZE-1:0] GpioInput,
    output     [`GPIO_SIZE-1:0] GpioOutput
);

    wire [31:0] bOut0;
    wire [31:0] bOut1;

    sm_ram sm_ram (
        .clk ( clk    ),
        .a   ( bAddr  ),
        .we  ( bWe    ),
        .wd  ( bWData ),
        .rd  ( bOut0  )
    );

    sm_gpio sm_gpio (
        .clk        ( clk        ),
        .bAddr      ( bAddr      ),
        .bWe        ( bWe        ),
        .bWData     ( bWData     ),
        .bRData     ( bOut1      ),

        .GpioInput  ( GpioInput  ),
        .GpioOutput ( GpioOutput )
    );
    
    assign bRData = bAddr[15:4] == 12'hbeb ? bOut1 : bOut0;

endmodule
