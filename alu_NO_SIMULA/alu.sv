`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2019 22:28:44
// Design Name: 
// Module Name: alu
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


module alu
(   
    input logic [15:0]A, [15:0]B, [15:0]OP,
    
    output logic [16:0]result,          //tiene 1 bit adicional para detección de errores
    output logic error                     //HIGH si hay CARRY OUT
 );
  
 always_comb begin
    case (OP)                         //suma - or - resta - and -> orden de los bits
        'd0:  begin
                    result=A + B;
                    if (result[16]==1)   error=1'b1;     //SI EL BIT ADICIONAL ES 1, ES CARRY OUT
                    else error=1'b0;
                end              
        'd1:  begin
                    result=A - B;
                    if (result[16]==1)   error=1'b1;     //SI EL BIT ADICIONAL ES 1, ES CARRY OUT
                    else error=1'b0;
                end
        'd2:    begin result=A & B; error=1'b0; end
        'd3:    begin result=A | B; error=1'b0; end
        default:    begin 
                        result=0;
                        error=1'b0;
                    end
   endcase
 end
endmodule