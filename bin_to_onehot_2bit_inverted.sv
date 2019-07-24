`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.07.2019 17:47:53
// Design Name: 
// Module Name: bin_to_onehot_2bit_inverted
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: esto se utiliza para hacer TDM en solo 2 bits del display 7 seg, invertido porque los anodos
//                      funcionan como active low.
// 
//////////////////////////////////////////////////////////////////////////////////


module bin_to_onehot_2bit_inverted
    (
    input logic a,
    output logic [1:0]Y
    );
    always_comb begin
        case(a)
            4'b0: Y=2'b10;
            4'b1: Y=2'b01;
            default: Y=2'b00;
        endcase
    end
endmodule
