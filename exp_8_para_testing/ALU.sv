`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2019 06:55:58
// Design Name: 
// Module Name: ALU
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

// alu nombre_(.A(),.B(),.OP(),.estado(),.result(),.error());

module ALU #(parameter largo=16)(   
    input logic [largo-1:0]A, [largo-1:0]B, [2:0]OP,      //OP 4 BITS
    //input logic estado,
    
    output logic [largo-1:0]result, //tiene 1 bit adicional para detecci�n de errores
    output logic error                     //indica CARRY OUT
 );
  
 always_comb begin        
    case (OP)
            'd0:    result= A + B;                
            'd1:    result= A * B;
            'd2:    result= A && B;
            'd4:    result= A - B;
            'd5:    result= A || B;
        default:    result= 'b0;
    endcase
 end
endmodule