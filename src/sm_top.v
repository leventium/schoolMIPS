
//hardware top level module
module sm_top
(
    input                    clkIn,
    input                    rst_n,
    input   [ 3:0 ]          clkDevide,
    input                    clkEnable,
    output                   clk,
    input   [ 4:0 ]          regAddr,
    output  [31:0 ]          regData,

    input   [`GPIO_SIZE-1:0] GpioInput,
    output  [`GPIO_SIZE-1:0] GpioOutput
);
    //metastability input filters
    wire    [ 3:0 ] devide;
    wire            enable;
    wire    [ 4:0 ] addr;

    sm_debouncer #(.SIZE(4)) f0(clkIn, clkDevide, devide);
    sm_debouncer #(.SIZE(1)) f1(clkIn, clkEnable, enable);
    sm_debouncer #(.SIZE(5)) f2(clkIn, regAddr,   addr  );

    //cores
    //clock devider
    sm_clk_divider sm_clk_divider
    (
        .clkIn      ( clkIn     ),
        .rst_n      ( rst_n     ),
        .devide     ( devide    ),
        .enable     ( enable    ),
        .clkOut     ( clk       )
    );

    //instruction memory
    wire    [31:0]  imAddr;
    wire    [31:0]  imData;
    sm_rom reset_rom(imAddr, imData);

    wire [31:0] bAddr;
    wire        bWe;
    wire [31:0] bWData;
    wire [31:0] bRData;

    wire [`GPIO_SIZE-1:0] shim_wire;

    sm_converter shim (
        .data        ( shim_wire  ),
        .gpio_output ( GpioOutput )
    );

    sm_matrix sm_matrix (
        .clk        ( clk        ),
        .bAddr      ( bAddr      ),
        .bWe        ( bWe        ),
        .bWData     ( bWData     ),
        .bRData     ( bRData     ),
        .GpioInput  ( GpioInput  ),
        .GpioOutput ( shim_wire  )
    );

    sm_cpu sm_cpu
    (
        .clk        ( clk       ),
        .rst_n      ( rst_n     ),
        .regAddr    ( addr      ),
        .regData    ( regData   ),
        .imAddr     ( imAddr    ),
        .imData     ( imData    ),
        .bAddr      ( bAddr     ),
        .bWe        ( bWe       ),
        .bWData     ( bWData    ),
        .bRData     ( bRData    )
    );

endmodule

//metastability input debouncer module
module sm_debouncer
#(
    parameter SIZE = 1
)
(
    input                      clk,
    input      [ SIZE - 1 : 0] d,
    output reg [ SIZE - 1 : 0] q
);
    reg        [ SIZE - 1 : 0] data;

    always @ (posedge clk) begin
        data <= d;
        q    <= data;
    end

endmodule

//tunable clock devider
module sm_clk_divider
#(
    parameter shift  = 16,
              bypass = 0
)
(
    input           clkIn,
    input           rst_n,
    input   [ 3:0 ] devide,
    input           enable,
    output          clkOut
);
    wire [31:0] cntr;
    wire [31:0] cntrNext = cntr + 1;
    sm_register_we r_cntr(clkIn, rst_n, enable, cntrNext, cntr);

    assign clkOut = bypass ? clkIn 
                           : cntr[shift + devide];
endmodule


module sm_converter (
    input      [15:0] data,
    output reg [15:0] gpio_output
);
    reg  [9:0] count = 10'b0000000000;
    wire [6:0] s_seg0, s_seg1, s_seg2, s_seg3;

    sm_hex_display hex_conv0 (
        .digit         (data[3:0]),
        .seven_segments (s_seg0)
    );


    sm_hex_display hex_conv1 (
        .digit         (data[7:4]),
        .seven_segments (s_seg1)
    );


    sm_hex_display hex_conv2 (
        .digit         (data[11:8]),
        .seven_segments (s_seg2)
    );


    sm_hex_display hex_conv3 (
        .digit         (data[15:12]),
        .seven_segments (s_seg3)
    );

    always @(*) begin
        casez (count[9:8])
            2'b00: gpio_output = { 4'b0000, 4'b0001, s_seg0, 1'b0 };
            2'b01: gpio_output = { 4'b0000, 4'b0010, s_seg1, 1'b0 };
            2'b10: gpio_output = { 4'b0000, 4'b0100, s_seg2, 1'b0 };
            2'b11: gpio_output = { 4'b0000, 4'b1000, s_seg3, 1'b0 };
            default: count <= count + 1'b0;
        endcase
        count <= count + 1'b1;
    end

endmodule
