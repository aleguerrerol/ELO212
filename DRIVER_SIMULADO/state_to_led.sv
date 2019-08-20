`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.08.2019 13:58:10
// Design Name: 
// Module Name: state_to_led
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

//MODULE************* state_to_led(.status(),.LED());

module state_to_led(
    input logic [1:0]status,
    output logic [2:0]LED
    );
    always_comb begin
        case (status)
            'd0:    LED=3'b000;
            'd1:    LED=3'b001;
            'd2:    LED=3'b010;
            'd3:    LED=3'b100;
        endcase
    end
endmodule
