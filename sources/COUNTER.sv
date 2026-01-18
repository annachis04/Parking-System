`timescale 1ns / 1ps

module COUNTER(
    input logic clk,
    input logic rst,
    input logic count_down,
    input logic count_up,
    output logic [3:0] count
);

always_ff @(posedge clk) 
begin
    if(rst==1)
        count<=0;
    else 
        begin
            if(count_down==1)
                begin
                    if(count==0)
                        count<=0;
                    else 
                        count<=count-1;
                end
             else if(count_up==1)
                 count<=count+1;
        end
end

endmodule
