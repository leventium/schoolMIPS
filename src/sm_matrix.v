`include "sm_config.vh"

module sm_matrix (
    input                       clk,
    input      [31:0]           bAddr, userAddr,
    input                       bWe, userWe,
    input      [31:0]           bWData, userWData,
    output     [31:0]           bRData, userRData,

    input      [`GPIO_SIZE-1:0] GpioInput,
    output     [`GPIO_SIZE-1:0] GpioOutput
);

    wire [31:0] bOut0;
    wire [31:0] bOut1;

    sm_ram sm_ram (
        .clk   ( clk        ),
        .a     ( bAddr      ),
        .b     ( userAddr   ),
        .we_a  ( bWe        ),
        .we_b  ( userWe     ),
        .wd_a  ( bWData     ),
        .wd_b  ( userWData  ),
        .rd_a  ( bOut0      ),
        .rd_b  ( userRData  )
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
