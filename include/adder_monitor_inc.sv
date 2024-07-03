task adder_monitor::do_mon();
  forever @(vif.F) begin
    m_trans.input1 = vif.A;
    m_trans.input2 = vif.B;
    m_trans.sum    = vif.F;
    analysis_port.write(m_trans);
    `uvm_info(get_type_name(), $sformatf("%0d + %0d = %0d", vif.A, vif.B, vif.F), UVM_MEDIUM)
  end
endtask
