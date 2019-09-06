`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.09.2019 15:47:34
// Design Name: 
// Module Name: top
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


module top(
    input logic CLK100MHZ,CLK82MHZ,
    input logic rx_ready,
    input logic [7:0]rx_data,
    input logic [17:0]line,
    input logic hc_visible, vc_visible,
    output logic [23:0]col[0:8]
    
    );
    
    coordinate_to_address coordinate_to_address_1 (.x(hc_visible), .y(vc_visible), .add(add[0:8]));
    
    // cable : COORDINATE_TO_ADDRES to GET_COLOR
    logic [17:0]add[0:8];
    
    // cables: BRAM to GET_COLOR - GET_COLOR to BRAM
    
    logic [23:0]get_col[0:8];
    logic [17:0]send_add[0:8];
     
    
   
    blk_mem_gen_0 bram0(.clka(CLK100MHZ),
                        .ena(1),
                        .wea(rx_ready),
                        .addra(line),
                        .dina(rx_data),
                        .clkb(CLK82MHZ),
                        .enb(1),
                        .addrb(send_add[0]),
                        .doutb(get_col[0]));
                        
    get_color get_color_0(.addr(add[0]),.send_add(send_add[0]),.get_col(get_col[0]),.col(col[0]));
    
    blk_mem_gen_0 bram1(.clka(CLK100MHZ),
                        .ena(1),
                        .wea(rx_ready),
                        .addra(line),
                        .dina(rx_data),
                        .clkb(CLK82MHZ),
                        .enb(1),
                        .addrb(send_add[1]),
                        .doutb(get_col[1]));
    
    get_color get_color_1(.addr(add[1]),.send_add(send_add[1]),.get_col(get_col[1]),.col(col[1]));                    
                        
    blk_mem_gen_0 bram2(.clka(CLK100MHZ),
                        .ena(1),
                        .wea(rx_ready),
                        .addra(line),
                        .dina(rx_data),
                        .clkb(CLK82MHZ),
                        .enb(1),
                        .addrb(send_add[2]),
                        .doutb(get_col[2]));
                        
    get_color get_color_2(.addr(add[2]),.send_add(send_add[2]),.get_col(get_col[2]),.col(col[2]));                    
                        
    blk_mem_gen_0 bram3(.clka(CLK100MHZ),
                        .ena(1),
                        .wea(rx_ready),
                        .addra(line),
                        .dina(rx_data),
                        .clkb(CLK82MHZ),
                        .enb(1),
                        .addrb(send_add[3]),
                        .doutb(get_col[3]));
                        
    get_color get_color_3(.addr(add[3]),.send_add(send_add[3]),.get_col(get_col[3]),.col(col[3]));
                        
    blk_mem_gen_0 bram4(.clka(CLK100MHZ),
                        .ena(1),
                        .wea(rx_ready),
                        .addra(line),
                        .dina(rx_data),
                        .clkb(CLK82MHZ),
                        .enb(1),
                        .addrb(send_add[4]),
                        .doutb(get_col[4]));
                        
    get_color get_color_4(.addr(add[4]),.send_add(send_add[4]),.get_col(get_col[4]),.col(col[4]));                    
                        
    blk_mem_gen_0 bram5(.clka(CLK100MHZ),
                        .ena(1),
                        .wea(rx_ready),
                        .addra(line),
                        .dina(rx_data),
                        .clkb(CLK82MHZ),
                        .enb(1),
                        .addrb(send_add[5]),
                        .doutb(get_col[5]));
                        
    get_color get_color_5(.addr(add[5]),.send_add(send_add[5]),.get_col(get_col[5]),.col(col[5]));
                        
    blk_mem_gen_0 bram6(.clka(CLK100MHZ),
                        .ena(1),
                        .wea(rx_ready),
                        .addra(line),
                        .dina(rx_data),
                        .clkb(CLK82MHZ),
                        .enb(1),
                        .addrb(send_add[6]),
                        .doutb(get_col[6]));
                        
    get_color get_color_6(.addr(add[6]),.send_add(send_add[6]),.get_col(get_col[6]),.col(col[6]));                    
                        
    blk_mem_gen_0 bram7(.clka(CLK100MHZ),
                        .ena(1),
                        .wea(rx_ready),
                        .addra(line),
                        .dina(rx_data),
                        .clkb(CLK82MHZ),
                        .enb(1),
                        .addrb(send_add[7]),
                        .doutb(get_col[7]));
    
    get_color get_color_7(.addr(add[7]),.send_add(send_add[7]),.get_col(get_col[7]),.col(col[7]));
                        
    blk_mem_gen_0 bram8(.clka(CLK100MHZ),
                        .ena(1),
                        .wea(rx_ready),
                        .addra(line),
                        .dina(rx_data),
                        .clkb(CLK82MHZ),
                        .enb(1),
                        .addrb(send_add[8]),
                        .doutb(get_col[8]));
    get_color get_color_8(.addr(add[8]),.send_add(send_add[8]),.get_col(get_col[8]),.col(col[8]));
endmodule
