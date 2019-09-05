`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.09.2019 16:17:14
// Design Name: 
// Module Name: coordinate_to_address
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//  
// this works only with a 512x384 matrix, that explains the magic numbers
// the ifs  are there to have a protective layer of 0's so we don't read off anything undefined
//     0 0 0 0 0
//     0 a b c 0
//     0 d e f 0
//     0 g h i 0
//     0 0 0 0 0
// keep in mind the 0s are address 0. if your sobel looks weird, it's because 0 might be some color other than black (the color of the (0,0) pixel)
// if that's the case, you'll have to change the design... maybe replace 0 for some address out of the expected range and write a 0 to it elsewhere.
//////////////////////////////////////////////////////////////////////////////////

// instance template:
// coordinate_to_address DUT (.x(x), .y(y), .add(add));
module coordinate_to_address(
    input logic [10:0]x, //x coordinate
    input logic [10:0]y, //y coordinate
    output logic [9:0]add[0:8]
    );
    
    always_comb begin
           
        if (x == 'd0 || y == 'd0) add[0] = 0;
        else add[0] = (x-1)+(y-1)*512; //top left
        
        if (y == 'd0) add[1] = 0;
        else add[1] = (x)+(y-1)*512; //top center
        
        if (x == 'd511 || y == 'd0) add[2] = 0;
        else add[2] = (x+1)+(y-1)*512; //top right
        
        if (x == 'd0) add[3] = 0;
        else add[3] = (x-1)+(y)*512; //center left
        
        add[4] = (x)+(y)*512; //center center
        
        if (x == 'd511) add[5] = 0;
        else add[5] = (x+1)+(y)*512; //center right
        
        if (x == 'd0 || y == 'd383) add[6] = 0;
        else add[6] = (x-1)+(y+1)*512; //bottom left
        
        if (y == 'd383) add[7] = 0;
        add[7] = (x)+(y+1)*512; //bottom center
        
        if (x == 'd511 || y == 'd383) add[8] = 0;
        add[8] = (x+1)+(y+1)*512; //bottom right
    end
    
endmodule
