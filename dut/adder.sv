module adder (
  input  logic [7:0] A,B,
  output logic [8:0] F 
);
  
  always_comb begin
    F = A + B;
  end
  
endmodule
