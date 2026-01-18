`timescale 1ns / 1ps

module tb();

logic clk;                   
logic rst;                   
logic car_out;               
logic car_in;               
logic [3:0] free_spot;      
logic [1:0] current_floor;  
logic parking_full;


PARK_SYSTEM DUT(
    .clk(clk),               
    .rst(rst),               
    .car_out(car_out),           
    .car_in(car_in) ,            
    .free_spot(free_spot),          
    .current_floor(current_floor),      
    .parking_full(parking_full)                          
);  

initial
begin
    clk=0;
    forever #10 clk=~clk;
end

initial
begin
    rst=1;
    @(negedge clk);
    rst=0;
end

initial
begin
    car_in=0;
    repeat(2)
    @(negedge clk);
    car_in=1;
    repeat(13)
    @(posedge clk);
    @(negedge clk);
    car_in=0;
    repeat(3)
    @(negedge clk);
    car_in=1;
    @(negedge clk);
    car_in=0;
    #10
    $stop();
end

initial
begin
    car_out=0;
    repeat(16)
    @(negedge clk);
    car_out=1;
    repeat(2)
    @(negedge clk);
    car_out=0;
end

endmodule
