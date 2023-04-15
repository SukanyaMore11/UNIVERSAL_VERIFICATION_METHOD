//------------------------------------------------
// UVM Agent
//------------------------------------------------

`include "mem_seq_item.sv"
`include "mem_sequencer.sv"
`include "mem_sequence.sv"
`include "mem_driver.sv"
`include "mem_driver_1.sv"
`include "mem_monitor.sv"
`include "mem_monitor_1.sv"

class mem_agent extends uvm_agent;

  //---------------------------------------
  // component instances
  //---------------------------------------
  mem_driver    driver;
  mem_driver_1  driver_1
  mem_sequencer sequencer;
  mem_monitor   monitor;
  mem_monitor_1 monitor_1;

  `uvm_component_utils(mem_agent)
  
  //---------------------------------------
  // constructor
  //---------------------------------------
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //---------------------------------------
  // build_phase
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    monitor = mem_monitor::type_id::create("monitor", this);
    monitor_1 = mem_monitor_1::type_id::create("monitor", this);

    //creating driver and sequencer only for ACTIVE agent
    if(get_is_active() == UVM_ACTIVE) begin
      driver    = mem_driver::type_id::create("driver", this);
      driver_1  = mem_driver_1::type_id::create("driver", this);
      sequencer = mem_sequencer::type_id::create("sequencer", this);
    end
  endfunction : build_phase
  
  //---------------------------------------  
  // connect_phase - connecting the driver and sequencer port
  //---------------------------------------
  function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
      driver.seq_item_port1.connect(sequencer.seq_item_export);
    end
  endfunction : connect_phase

endclass : mem_agent