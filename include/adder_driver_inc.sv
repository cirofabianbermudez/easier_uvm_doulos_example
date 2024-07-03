task adder_driver::do_drive();
  vif.A <= req.input1;
  vif.B <= req.input2;
  #10;
endtask
