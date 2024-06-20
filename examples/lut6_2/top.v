module top(
    output led,
    output led2  
);
    
    LUT6_2 #(
    .INIT(64'h0000000100000001) // Specify LUT Contents
    ) LUT6_2_inst (
    .O6(led2), // 1-bit LUT6 output
    .O5(led), // 1-bit lower LUT5 output
    .I0(1'b0), // 1-bit LUT input
    .I1(1'b0), // 1-bit LUT input
    .I2(1'b0), // 1-bit LUT input
    .I3(1'b0), // 1-bit LUT input
    .I4(1'b0), // 1-bit LUT input
    .I5(1'b1)  // 1-bit LUT input (fast MUX select only available to O6 output)
    );

endmodule
