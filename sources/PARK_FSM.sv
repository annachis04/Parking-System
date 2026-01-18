`timescale 1ns / 1ps

module PARK_FSM(
    input logic clk,
    input logic rst,
    input logic [3:0] count,
    output logic [1:0] floor,
    output logic full
);

//Se asociaza sirurilor de biti folositi pentru codarea starilor nume ce pot fi folosite mai usor in cod.
//La compilare, numele vor fi inlocuite in cod cu numerele asociate la inceput.
localparam FLOOR0 = 2'b00;
localparam FLOOR1 = 2'b01;
localparam FLOOR2 = 2'b10;
localparam FULL = 2'b11;

logic [1:0] state, state_next;

//registrul de stare
always_ff @(posedge clk) begin
    if(rst == 1)
        state <= FLOOR0;
    else
        state <= state_next;
end

//circuit combinational pentru calculul starii urmatoare
always_comb begin
    state_next = state;
    case(state)
        FLOOR0: begin
                       if(count <= 4) state_next = FLOOR0;
                       else if(count>4) state_next=FLOOR1;
                end
        FLOOR1: begin
                         if(count <= 8 && count>4) state_next = FLOOR1;
                         else if(count<=4) state_next=FLOOR0;
                         else if (count>8) state_next=FLOOR2;
                 end
        FLOOR2: begin
                         if(count<12 && count>8) state_next = FLOOR2;
                         else if(count<=8) state_next=FLOOR1;
                         else if (count==12) state_next=FULL;
                 end
        FULL: begin
                         if(count==12) state_next = FULL;
                         else if(count<12) state_next=FLOOR2;
                 end
        default: state_next = FLOOR0;
    endcase
end


//circuit combinational pentru calculul iesirilor
always_comb 
begin
    case(state)
        FLOOR0: begin
                       floor=0;
                       full=0;
                end
        FLOOR1: begin
                         floor=1;
                         full=0;
                 end
        FLOOR2: begin
                         floor=2;
                         full=0;
                 end
        FULL:   begin
                        floor=2;
                        full=1;   
                end
        default: begin
                    floor=0;
                    full=0;
                 end
     endcase
end


endmodule
