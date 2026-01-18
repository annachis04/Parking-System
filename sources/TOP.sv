`timescale 1ns / 1ps

module TOP(
    input logic clk,
    input logic rst_clk,
    input logic rst_park,
    input logic car_out,
    input logic car_in,
    output logic clk_delay,
    output logic [6:0] spots_7seg,
    output logic [2:0] floor_decoded,
    output logic full_garage,
    output logic spots_available 
);

logic clk_d;
logic [3:0] free_spots;
logic [1:0] floor;
logic full;

assign clk_delay=clk_d;

CLK_DELAY CLK_DELAY0(
    .clk(clk),           
    .rst(rst_clk),           
    .clk_delay(clk_d)     
);

PARK_SYSTEM PARK_SYSTEM0(
      .clk(clk_d),               
      .rst(rst_park),               
      .car_out(car_out),           
      .car_in(car_in),            
      .free_spot(free_spots),          
      .current_floor(floor),      
      .parking_full(full)                          
);

FLOOR_DECODER DECODER0(
     .floor(floor),         
     .full(full),          
     .floor_decoder(floor_decoded)   
);

TRANSCODOR_7SEG TRANSCODOR0(
    .in(free_spots),   
    .out(spots_7seg)  
);

assign full_garage=full;
assign spots_available=~full;
    
    
endmodule
