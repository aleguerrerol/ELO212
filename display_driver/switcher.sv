`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.07.2019 23:39:45
// Design Name: 
// Module Name: switcher
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
//////////////////////////////////////////////////////////////////////////////////


module switcher #(parameter D7=1,D6=1,D5=1,D4=1,D3=1,D2=1,D1=1,D0=1)(
    input logic [2:0]count,
    input logic reset,
    output logic [7:0]anodos
    );
    always_comb begin
        case(count)
            3'b000:  if(D0 && reset==1'b1) anodos=8'b11111110;
                     else if(D0 && reset==1'b0) anodos=8'b11111111;
                     else   anodos=8'b11111111;
            
            3'b001:  if(D1) anodos=8'b11111101;
                     else   anodos=8'b11111111;
            
            3'b010:  if(D2) anodos=8'b11111011;
                     else   anodos=8'b11111111;
            
            3'b011:  if(D3) anodos=8'b11110111;
                     else   anodos=8'b11111111;
            
            3'b100:  if(D4) anodos=8'b11101111;
                     else   anodos=8'b11111111;
            
            3'b101:  if(D5) anodos=8'b11011111;
                     else   anodos=8'b11111111;
            
            3'b110:  if(D6) anodos=8'b10111111;
                     else   anodos=8'b11111111;
            
            3'b111:  if(D7) anodos=8'b01111111;
                     else   anodos=8'b11111111;
            
            default: anodos=8'b11111111;
        endcase
    end
endmodule
