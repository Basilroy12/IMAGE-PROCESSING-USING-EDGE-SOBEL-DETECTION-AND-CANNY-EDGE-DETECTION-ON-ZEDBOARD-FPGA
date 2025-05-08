module double_threshold(
    input clk,
    input [7:0] data_in,
    input data_in_valid,
    output reg [7:0] data_out,
    output data_out_valid
);
    
    localparam UpperThreshold = 220;
    localparam LowerThreshold = 85; // 255/3 = 85
    
    assign data_out_valid = data_in_valid;
    
    always @(posedge clk) begin
        if (data_in_valid) begin
            case (1'b1)
                (data_in > UpperThreshold): data_out <= 8'd255; // Strong pixels
                (data_in < LowerThreshold): data_out <= 8'd0;   // Weak pixels
                default: data_out <= data_in;                   // Intermediate pixels
            endcase
        end
    end
    
endmodule
