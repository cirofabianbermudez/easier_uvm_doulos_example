# Easier UVM Doulos example


## Introduction

Easier UVM from Doulos is a Perl script code generator for UVM. It is very easy to use and tha advantage of using it is that you get a complete and functional UVM environment that works out of the box.


## Prerequisites

To install Perl in Windows the easiest way to do it is via Scoop. Use the following command:

```powershell
scoop install perl
```

For Linux you can install with the following command:

```
sudo apt-get install perl
```

## Input files

- `dut` directory with all your `.sv` files of your design.
- `include` directory for extra codes.
- `common.tpl` file for general configurations
- `arith.tpl` file for the UVM component configurations
- `pinlist` file to map the virtual interface


## Example for a simple adder


`dut/adder.sv`
```verilog
module adder (
  input  logic [7:0] A,B,
  output logic [8:0] F 
);
  
  always_comb begin
    F = A + B;
  end
  
endmodule
```

`common.tpl`
```
dut_top = adder
top_default_seq_count = 10
```


`arith.tpl`
```
agent_name = arith
trans_item = trans

trans_var = rand logic [7:0] input1;
trans_var = rand logic [7:0] input2;
trans_var =      logic [8:0] sum;

if_port =  logic [7:0] A;
if_port =  logic [7:0] B;
if_port =  logic [8:0] F;

driver_inc  = arith_driver_inc.sv   inline
monitor_inc = arith_monitor_inc.sv  inline
```

`pinlist`
```
!arith_if
A A
B B
F F
```

`arith_driver_inc.sv`
```verilog
task arith_driver::do_drive();
  vif.A <= req.input1;
  vif.B <= req.input2;
  #10;
endtask
```

`arith_monitor_inc.sv`
```verilog
task arith_monitor::do_mon();
  forever @(vif.F) begin
    m_trans.input1 = vif.A;
    m_trans.input2 = vif.B;
    m_trans.sum    = vif.F;
    analysis_port.write(m_trans);
    `uvm_info(get_type_name(), $sformatf("%0d + %0d = %0d", vif.A, vif.B, vif.F), UVM_MEDIUM)
  end
endtask
```


Finally This is how you run the script:

```bash
perl easier_uvm_gel.pl arith.tpl
```

The output is a `generated_tb` directory with all the code and a `easier_uvm_gen.log`
