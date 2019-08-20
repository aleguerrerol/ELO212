`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.08.2019 23:52:14
// Design Name: 
// Module Name: nuevo_driver
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


module nuevo_driver #(parameter in_length=32)(
    input logic CLK,RESET,DEC_TRIGGER,
    input logic [in_length-1:0]BIN_IN,      //desde ALU en BIN
    
    //output logic [in_length-1:0]OUT,            //kesestoooooo??? PROBABLEMENTE DEBEN SER CABLES INTERNOS NO +
    output logic [6:0]CATODOS,
    output logic [7:0]ANODOS
    ); 
    logic [2:0] cnt;
    logic clk;
    logic [3:0] DATA;
    logic [in_length-1:0]BCD_OUT;
    logic [in_length-1:0]OUT;                       //VERIFICAR SI ESTA BIEN O NO UWU
    logic dd_state;
    
    DD DD(.clk(CLK),.trigger(DEC_TRIGGER),.in(BIN_IN),.idle(dd_state),.bcd(BCD_OUT));              //convierte BIN_IN a BCD
    
    always_comb begin
        if(DEC_TRIGGER) OUT=BCD_OUT;
        else            OUT=BIN_IN;
    end
    
    clock_divider #(104167) clk_div(.clk_in(CLK),.reset(RESET),.clk_out(clk));                          //Frecuencia display
    contador_3bits  cnt_3bit(.clk_in(clk),.reset(RESET),.count(cnt));                                     //8 tiempos
    mux mux(.contador(cnt),.d_7(OUT[31:28]),.d_6(OUT[27:24]),.d_5(OUT[23:20]),
                       .d_4(OUT[19:16]),.d_3(OUT[15:12]),.d_2(OUT[11:8]),
                       .d_1(OUT[7:4]),.d_0(OUT[3:0]),.dato(DATA));                              //TDM
    switcher_an #(1,1,1,1,1,1,1,1)  switch(.count(cnt),.reset(RESET),.anodos(ANODOS));                  //mueve anodos
    decoder decoder(.in(DATA),.dec_trigger(DEC_TRIGGER),.sevenSeg(CATODOS));                            //salida a los catodos

endmodule