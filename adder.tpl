agent_name = adder
trans_item = sequence_item

trans_var = rand logic [7:0] input1;
trans_var = rand logic [7:0] input2;
trans_var =      logic [8:0] sum;

if_port =  logic [7:0] A;
if_port =  logic [7:0] B;
if_port =  logic [8:0] F;

driver_inc  = adder_driver_inc.sv   inline
monitor_inc = adder_monitor_inc.sv  inline