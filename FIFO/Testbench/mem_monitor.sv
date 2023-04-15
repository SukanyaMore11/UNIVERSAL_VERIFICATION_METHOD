//--------------------------------------------
// UVM MONITOR
//---------------------------------------------

class mem_monitor extends uvm_monitor;

  //---------------------------------------
  // Virtual Interface
  //---------------------------------------
  virtual mem_if vif;

  //---------------------------------------
  // analysis port, to send the transaction to scoreboard
  //---------------------------------------
  uvm_analysis_port #(mem_seq_item) item_collected_port;
  
  //---------------------------------------
  // The following property holds the transaction information currently
  // begin captured (by the collect_address_phase and data_phase methods).
  //---------------------------------------
  mem_seq_item trans_collected;

  `uvm_component_utils(mem_monitor)

  //---------------------------------------
  // new - constructor
  //---------------------------------------
  function new (string name, uvm_component parent);
    super.new(name, parent);
    trans_collected = new();
    item_collected_port = new("item_collected_port", this);
  endfunction : new

  //---------------------------------------
  // build_phase - getting the interface handle
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual mem_if)::get(this, "", "vif", vif))
       `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction: build_phase
  
  //---------------------------------------
  // run_phase - convert the signal level activity to transaction level.
  // i.e, sample the values on interface signal ans assigns to transaction class fields
  //---------------------------------------
  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.clk);
//       $display("monitor_input_data %t", $time);
      wait(vif.valid);
//       $display("monitor_input_data_after wait %t", $time);
      trans_collected.w_en   = vif.w_en;
      trans_collected.r_en   = vif.r_en;
      trans_collected.din   = vif.din;
      @(posedge vif.clk);
//       $display("monitor_output_data %t", $time);
      trans_collected.dout   = vif.dout;
      trans_collected.full   = vif.full;
      trans_collected.empty   = vif.empty;
      trans_collected.half_full   = vif.half_full;
      trans_collected.write_pointer   = vif.write_pointer;
      trans_collected.read_pointer   = vif.read_pointer;
      trans_collected.counter   = vif.counter;
      @(posedge vif.clk);
      item_collected_port.write(trans_collected);
//       $display("monitor_display %t", $time);
//       trans_collected.print();

      $display("-----------MONITOR--------------");
      $display("- w_en = %d, r_en = %d,din=%d ",vif.w_en,vif.r_en,vif.din);
    $display("- full = %d, empty =%d, half_full=%d, dout=%d, counter=%d",vif.full,vif.empty,vif.half_full,vif.dout,vif.counter);
    $display("-------------------------");

      end 
  
      
  endtask : run_phase

endclass : mem_monitor