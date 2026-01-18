`timescale 1ns / 1ps

module CLK_DELAY(
    input logic clk,
    input logic rst,
    output logic clk_delay
);

logic [31:0] count;

always_ff @(posedge clk)
begin
    if(rst==1)
        count=0;
    else 
        count<=count+1;
end

assign clk_delay=count[28];

endmodule
