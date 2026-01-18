`timescale 1ns / 1ps

module MUX(
    input logic in0,
    input logic in1,
    input logic sel,
    output logic out
);

always_comb 
begin
    case(sel)
        0: out=in0;
        1: out=in1;
    endcase
end

endmodule
