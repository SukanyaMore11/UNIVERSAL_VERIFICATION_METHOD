//--------------------------------------------
// UVM DRIVER
//---------------------------------------------
class mem_driver extends uvm_driver #(mem_seq_item);

  //--------------------------------------- 
  // Virtual Interface
  //--------------------------------------- 
  virtual mem_if vif;
  `uvm_component_utils(mem_driver)
    
  //--------------------------------------- 
  // Constructor
  //--------------------------------------- 
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //--------------------------------------- 
  // build phase
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     if(!uvm_config_db#(virtual mem_if)::get(this, "", "vif", vif))
       `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction: build_phase

  //---------------------------------------  
  // run phase
  //---------------------------------------  
  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
    end
  endtask : run_phase
  
  //---------------------------------------
  // drive - transaction level to signal level
  // drives the value's from seq_item to interface signals
  //---------------------------------------
  virtual task drive();

 	@(posedge vif.clk);
//       $display("driver_input_data %t", $time);
      vif.valid <= 1;
      vif.din <= req.din;
      vif.w_en <= req.w_en;
      vif.r_en <=req.r_en;
//       $display("din = %d", vif.din);
      
      @(posedge vif.clk);
//       $display("driver_output_data %t", $time);
      vif.valid <= 0;
      req.full = vif.full;
      req.empty = vif.empty;
      req.half_full = vif.half_full ;
      req.counter = vif.counter;
      req.write_pointer = vif.write_pointer;
      req.read_pointer = vif.read_pointer;
      req.dout = vif.dout;
      @(posedge vif.clk);
//       $display("driver_display %t", $time);
//     req.print();
    $display("-------------------------");
    $display("-----------DRIVER--------------");
    $display("- w_en = %d, r_en = %d,din=%d ",vif.w_en,vif.r_en,vif.din);
    $display("- full = %d, empty =%d, half_full=%d, dout=%d, counter=%d",vif.full,vif.empty,vif.half_full,vif.dout,vif.counter);
    $display("-------------------------");

  endtask : drive
endclass : mem_driver