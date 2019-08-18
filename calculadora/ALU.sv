`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.08.2019 01:30:10
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


module ALU #(parameter in_length=16)   //PARAMETRIZADO
(   
    input logic [in_length-1:0]A, [in_length-1:0]B, [in_length-1:0]OP,
    
    output logic [in_length-1:0]result,
    output logic [2:0]error                 //DEBE SER EL RGB
 );
 logic [in_length-1:0]A_bcd;
 logic [in_length-1:0]B_bcd;
 logic bcd_state;
  
 always_comb begin
    case (OP)                         //suma - or - resta - and -> orden de los bits
        'd0:    begin
                    result=A + B;
                    if (result[in_length-1]==1 && result[in_length-2]==1)   error=3'd1;     //OVERFLOW
                    else error=3'd0; 
                end              
        'd1:   //begin
                    result=A - B;
                 //   if (result[in_length-1]==1 && result[in_length-2]==1)   error=2'd1;   // FALTA UNDERFLOW
                //end
        'd2:    result=A & B;
        'd3:    result=A | B;
        default:    begin 
                        result=0;
                    end
   endcase
 end
endmodule