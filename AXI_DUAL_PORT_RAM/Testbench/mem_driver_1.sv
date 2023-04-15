//------------------------------------------------
// UVM Driver
//------------------------------------------------
// `define DRIV_IF vif.DRIVER.driver_cb
class mem_driver_1 extends uvm_driver #(mem_seq_item);

  //--------------------------------------- 
  // Virtual Interface
  //--------------------------------------- 
  virtual mem_if vif;
  `uvm_component_utils(mem_driver_1)
    
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
      seq_item_port1.get_next_item(req);
      drive();
      seq_item_port1.item_done();
    end
  endtask : run_phase
  
  //---------------------------------------
  // drive - transaction level to signal level
  // drives the value's from seq_item to interface signals
  //---------------------------------------
  virtual task drive();

    @(posedge vif.b_clk);
    
      vif.s_axil_b_awaddr = req.s_axil_b_awaddr;
      vif.s_axil_b_awprot = req.s_axil_b_awprot;
      vif.s_axil_b_awvalid = req.s_axil_b_awvalid;
      vif.s_axil_b_wdata = req.s_axil_b_wdata;
      vif.s_axil_b_wstrb = req.s_axil_b_wstrb;
      vif.s_axil_b_wvalid = req.s_axil_b_wvalid;
      vif.s_axil_b_bready = req.s_axil_b_bready;
      vif.s_axil_b_araddr = req.s_axil_b_araddr;
      vif.s_axil_b_arprot = req.s_axil_b_arprot;
      vif.s_axil_b_arvalid = req.s_axil_b_arvalid;
      vif.s_axil_b_rready = req.s_axil_b_rready;
    
    @(posedge vif.b_clk); 

    /////output data
      req.s_axil_b_awready = vif.s_axil_b_awready;
      req.s_axil_b_wready = vif.s_axil_b_wready;
      req.s_axil_b_bresp = vif.s_axil_b_bresp;
      req.s_axil_b_bvalid = vif.s_axil_b_bvalid;
      req.s_axil_b_arready = vif.s_axil_b_arready;
      req.s_axil_b_rdata = vif.s_axil_b_rdata;
      req.s_axil_b_rresp = vif.s_axil_b_rresp;
      req.s_axil_b_rvalid = vif.s_axil_b_rvalid;
    
    @(posedge vif.b_clk)
    $display("-----------------------------------------------");
    $display("s_axil_a_awaddr = %h, s_axil_a_awprot=%h, s_axil_a_wdata=%h, s_axil_a_wstrb=%h, s_axil_a_araddr=%h, s_axil_a_arprot=%h",vif.s_axil_a_awaddr,vif.s_axil_a_awprot,vif.s_axil_a_wdata,vif.s_axil_a_wstrb,vif.s_axil_a_araddr,vif.s_axil_a_arprot);
    $display("s_axil_a_awvalid = %h, s_axil_a_wvalid=%h, s_axil_a_bready=%h, s_axil_a_arvalid=%h, s_axil_a_rready=%h",vif.s_axil_a_awvalid,vif.s_axil_a_wvalid,vif.s_axil_a_bready,vif.s_axil_a_arvalid,vif.s_axil_a_rready);
    $display("s_axil_a_bresp=%h,s_axil_a_rdata=%h, s_axil_a_rresp=%h",vif.s_axil_a_bresp,vif.s_axil_a_rdata, vif.s_axil_a_rresp);
    
    
    
  endtask : drive
endclass : mem_driver_1