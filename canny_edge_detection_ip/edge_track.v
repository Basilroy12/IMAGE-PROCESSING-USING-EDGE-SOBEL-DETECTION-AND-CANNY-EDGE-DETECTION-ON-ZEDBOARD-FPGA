`timescale 1ns / 1ps

module edge_track(
    input clk,
    input [71:0] data_in,
    input data_in_valid,
    output reg [7:0] data_out,
    output data_out_valid
    );

    assign data_out_valid = data_in_valid;

    // Define center pixel and thresholds
    reg [7:0] center_pixel;
    parameter HIGH_THRESHOLD = 8'd100;
    parameter LOW_THRESHOLD  = 8'd50;

    always @(posedge clk) begin
        center_pixel = data_in[39:32]; // Center pixel

        // Check for strong edges
        if (center_pixel >= HIGH_THRESHOLD) begin
            data_out <= 8'd255; // Strong edge
        end 
        else if (center_pixel >= LOW_THRESHOLD) begin
            // Check if a weak edge is connected to a strong edge
            if ((data_in[7:0] >= HIGH_THRESHOLD) || 
                (data_in[15:8] >= HIGH_THRESHOLD) || 
                (data_in[23:16] >= HIGH_THRESHOLD) ||
                (data_in[31:24] >= HIGH_THRESHOLD) ||
                (data_in[47:40] >= HIGH_THRESHOLD) ||
                (data_in[55:48] >= HIGH_THRESHOLD) ||
                (data_in[63:56] >= HIGH_THRESHOLD) ||
                (data_in[71:64] >= HIGH_THRESHOLD)) begin
                data_out <= 8'd255; // Keep weak edge if connected to strong edge
            end 
            else begin
                data_out <= 8'd0; // Suppress weak edge
            end
        end 
        else begin
            data_out <= 8'd0; // Suppress very weak edges
        end
    end

endmodule
