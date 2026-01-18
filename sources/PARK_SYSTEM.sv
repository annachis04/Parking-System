`timescale 1ns / 1ps


module PARK_SYSTEM(
    input logic clk,
    input logic rst,
    input logic car_out,
    input logic car_in,
    output logic [3:0] free_spot,
    output logic [1:0] current_floor,
    output logic parking_full
);

logic count_up;
logic cc;
logic [3:0] car_count ;


assign cc=(car_count<12)? 0:1;

MUX COUNT_MUX(
    .in0(car_in),   
    .in1(0),   
    .sel(cc),   
    .out(count_up)   
);

COUNTER CAR_COUNTER(
      .clk(clk),         
      .rst(rst),         
      .count_down(car_out),  
      .count_up(count_up),    
      .count(car_count)         
);

PARK_FSM FSM(
    .clk(clk),    
    .rst(rst),     
    .count(car_count),    
    .floor(current_floor),   
    .full(parking_full)            
);

assign free_spot=12-car_count;

endmodule
