
//------------------------------------------------
// UVM Driver
//------------------------------------------------
// `define DRIV_IF vif.DRIVER.driver_cb
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

    @(posedge vif.a_clk);
    
      vif.s_axil_a_awaddr = req.s_axil_a_awaddr;
      vif.s_axil_a_awprot = req.s_axil_a_awprot;
      vif.s_axil_a_awvalid = req.s_axil_a_awvalid;
      vif.s_axil_a_wdata = req.s_axil_a_wdata;
      vif.s_axil_a_wstrb = req.s_axil_a_wstrb;
      vif.s_axil_a_wvalid = req.s_axil_a_wvalid;
      vif.s_axil_a_bready = req.s_axil_a_bready;
      vif.s_axil_a_araddr = req.s_axil_a_araddr;
      vif.s_axil_a_arprot = req.s_axil_a_arprot;
      vif.s_axil_a_arvalid = req.s_axil_a_arvalid;
      vif.s_axil_a_rready = req.s_axil_a_rready;
    
    @(posedge vif.a_clk); 

    /////output data
      req.s_axil_a_awready = vif.s_axil_a_awready;
      req.s_axil_a_wready = vif.s_axil_a_wready;
      req.s_axil_a_bresp = vif.s_axil_a_bresp;
      req.s_axil_a_bvalid = vif.s_axil_a_bvalid;
      req.s_axil_a_arready = vif.s_axil_a_arready;
      req.s_axil_a_rdata = vif.s_axil_a_rdata;
      req.s_axil_a_rresp = vif.s_axil_a_rresp;
      req.s_axil_a_rvalid = vif.s_axil_a_rvalid;
    
    @(posedge vif.a_clk)
    $display("-----------------------------------------------");
    $display("s_axil_a_awaddr = %h, s_axil_a_awprot=%h, s_axil_a_wdata=%h, s_axil_a_wstrb=%h, s_axil_a_araddr=%h, s_axil_a_arprot=%h",vif.s_axil_a_awaddr,vif.s_axil_a_awprot,vif.s_axil_a_wdata,vif.s_axil_a_wstrb,vif.s_axil_a_araddr,vif.s_axil_a_arprot);
    $display("s_axil_a_awvalid = %h, s_axil_a_wvalid=%h, s_axil_a_bready=%h, s_axil_a_arvalid=%h, s_axil_a_rready=%h",vif.s_axil_a_awvalid,vif.s_axil_a_wvalid,vif.s_axil_a_bready,vif.s_axil_a_arvalid,vif.s_axil_a_rready);
    $display("s_axil_a_bresp=%h,s_axil_a_rdata=%h, s_axil_a_rresp=%h",vif.s_axil_a_bresp,vif.s_axil_a_rdata, vif.s_axil_a_rresp);
    
    
    
  endtask : drive
endclass : mem_driver