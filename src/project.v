`default_nettype none

module tt_um_programmable_counter (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when powered
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    wire load = uio_in[0];
    wire oe   = uio_in[1];


    reg [7:0] count_register;

    // Counter sequential logic
    always @(posedge clk or negedge rst_n) begin // negative reset to follow TT specification
        if (!rst_n) begin
            count_register <= 8'h00;
        end else begin
            if (load) begin
                count_register <= ui_in; // Synchronous load from the 8 input pins
            end else begin
                count_register <= count_register + 1'b1;
            end
        end
    end

    assign uo_out = oe ? count_register : 8'h00;

    assign uio_out = 8'h00;
    assign uio_oe  = 8'h00;

endmodule

