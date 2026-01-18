`timescale 1ns / 1ps

module FLOOR_DECODER(
    input logic [1:0] floor,
    input logic full,
    output logic [2:0] floor_decoder
);

always_comb 
begin
    if(full==1)
        floor_decoder=3'b000;
    else 
        begin
            case(floor) 
                0: floor_decoder=3'b001;
                1: floor_decoder=3'b010;
                2: floor_decoder=3'b100;
                default: floor_decoder=3'b111;
             endcase       
        end
end

endmodule
