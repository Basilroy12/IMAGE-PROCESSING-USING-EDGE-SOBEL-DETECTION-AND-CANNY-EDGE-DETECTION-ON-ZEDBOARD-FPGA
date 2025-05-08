`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.09.2021 22:37:51
// Design Name: 
// Module Name: non_max_suppr
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

//old format
//  7:0      15:8    23:16
//  31:24    39:32   47:40
//  55:48    63:56   71:64

//modified format
//  23:16    15:8    7:0
//  47:40    39:32   31:24
//  71:64    63:56   55:48

//old
module non_max_suppr(
    input clk,
    input [71:0] mag_data,
    input mag_data_valid,
    input [71:0] dir_data,
    input dir_data_valid,
    output reg [7:0] data_out,  //data to double threshold
    output data_out_valid);
    
    assign  data_out_valid = mag_data_valid & dir_data_valid ;
    
    always @(posedge clk)
    begin
        if (mag_data_valid && dir_data_valid)
        begin
            case (dir_data[39:32])
                8'd1: begin   // Horizontal line
                    if ((mag_data[39:32] < mag_data[31:24]) || (mag_data[39:32] < mag_data[47:40]))
                        data_out <= 8'd0;
                    else 
                        data_out <= mag_data[39:32];     
                end
                8'd2: begin   // Bottom right to top left
                    if ((mag_data[39:32] < mag_data[55:48]) || (mag_data[39:32] < mag_data[23:16]))
                        data_out <= 8'd0;
                    else
                        data_out <= mag_data[39:32];
                end
                8'd3: begin    // Vertical line
                    if ((mag_data[39:32] < mag_data[63:56]) || (mag_data[39:32] < mag_data[15:8]))
                        data_out <= 8'd0;
                    else
                        data_out <= mag_data[39:32];
                end
                8'd4: begin    // Bottom left to top right
                    if ((mag_data[39:32] < mag_data[71:64]) || (mag_data[39:32] < mag_data[7:0]))
                        data_out <= 8'd0;
                    else
                        data_out <= mag_data[39:32];
                end  
                default: begin  // Ensure `data_out` has a value in all cases
                    data_out <= 8'd0;
                end  
            endcase
        end
        else begin
            data_out <= 8'd0; // Assign default value when no valid data
        end
    end

    
endmodule


//new
/*
module non_max_suppr(
    input clk,
    input [71:0] mag_data,
    input mag_data_valid,
    input [71:0] dir_data,
    input dir_data_valid,
    output reg [7:0] data_out,  //data to double threshold
    output data_out_valid);
    
    assign  data_out_valid = mag_data_valid & dir_data_valid ;
    
    always@ (posedge clk)
    begin
      if (mag_data_valid && dir_data_valid)
        begin
           case(dir_data[39:32])
             'd1 : begin   //Horizontal line
                     if((mag_data[39:32] < mag_data[31:24]) || (mag_data[39:32] < mag_data[47:40]))
                          data_out <= 0 ;
                     else 
                          data_out <= mag_data[39:32];     
                   end
             'd2 : begin   //bottom right to top left
                     if((mag_data[39:32] < mag_data[55:48]) || (mag_data[39:32] < mag_data[23:16]))
                          data_out <= 0 ;
                     else
                          data_out <= mag_data[39:32];
                   end
             'd3 : begin    //vertical line
                     if((mag_data[39:32] < mag_data[63:56]) || (mag_data[39:32] < mag_data[15:8]))
                          data_out <= 0 ;
                     else
                          data_out <= mag_data[39:32];
                   end
             'd4 : begin    //bottom left to top right
                     if((mag_data[39:32] < mag_data[71:64]) || (mag_data[39:32] < mag_data[7:0]))
                          data_out <= 0 ;
                     else
                          data_out <= mag_data[39:32];
                   end                    
            
           endcase          
        end
    end
    
endmodule
*/
