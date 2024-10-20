module counter #(
    parameter WIDTH = 8,
    parameter delay = 2
)(

    // interface signals
    input logic clk,
    input logic rst,
    input logic en,
    output logic [delay-1:0] del,
    output logic [WIDTH-1:0] count
);
initial del=1;
always_ff @ (posedge clk)
    if (del !=0) begin
        
        del <= del - 1;
        if(del==0) count<=0;
    end
    else if (rst) count <= 0;
    else if (count==9) del <= 3;
    else    count<= count + {{WIDTH-1{1'b0}}, en};
    
endmodule

