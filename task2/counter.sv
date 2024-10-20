module counter #(
    parameter WIDTH = 8

)(
    // interface signals
    input logic clk,
    input logic rst,
    input logic en,
    input logic pos,
    output logic [WIDTH-1:0] count
);

always_ff @ (posedge clk)
    if (rst) begin
        count <= '0;
    end
    else if(pos)   begin
        count<= count + {{WIDTH-1{1'b0}}, en};
    end
    else if(!pos)   begin
        count<= count - {{WIDTH-1{1'b0}}, en};
    end
endmodule