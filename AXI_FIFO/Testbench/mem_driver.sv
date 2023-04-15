// UVM DRIVER
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
///----------------DISPLAY TO CHACK THE DATA--------------------    
//      $display("input_data %t", $time);
//     $display("s_axi_wvalid = %h, s_axi_wdata=%h, m_axi_rvalid=%h, m_axi_rdata=%h, m_axi_wready=%h, s_axi_rready=%h",req.s_axi_wvalid,req.s_axi_wdata,req.m_axi_rvalid,req.m_axi_rdata,req.m_axi_wready,req.s_axi_rready);
    
    
//// write operation signals and input data////
      vif.s_axi_wvalid = req.s_axi_wvalid;
      vif.s_axi_wdata = req.s_axi_wdata;
      vif.m_axi_rvalid = req.m_axi_rvalid;
      vif.m_axi_rdata = req.m_axi_rdata;
    //read opeartion signals
    vif.m_axi_wready = req.m_axi_wready;
    vif.s_axi_rready = req.s_axi_rready;
   
    ///////////some important input data/////////
    vif.s_axi_wdata = req.s_axi_wdata;
      vif.s_axi_wstrb = req.s_axi_wstrb;
      vif.s_axi_wlast = req.s_axi_wlast;
      vif.s_axi_wuser = req.s_axi_wuser;

    ///////////other input signals//////////
    vif.s_axi_awid = req.s_axi_awid;
      vif.s_axi_awaddr=req.s_axi_awaddr;
    vif.s_axi_awlen=req.s_axi_awlen;
      vif.s_axi_awsize=req.s_axi_awsize;
      vif.s_axi_awburst=req.s_axi_awburst;
      vif.s_axi_awlock=req.s_axi_awlock;
      vif.s_axi_awcache=req.s_axi_awcache;
      vif.s_axi_awprot=req.s_axi_awprot;
      vif.s_axi_awqos=req.s_axi_awqos;
      vif.s_axi_awregion=req.s_axi_awregion;
      vif.s_axi_awuser=req.s_axi_awuser;
      vif.s_axi_awvalid = req.s_axi_awvalid;
    vif.s_axi_bready = req.s_axi_bready;
      vif.s_axi_arid = req.s_axi_arid;
      vif.s_axi_araddr = req.s_axi_araddr;
      vif.s_axi_arlen = req.s_axi_arlen ;
      vif.s_axi_arsize = req.s_axi_arsize;
      vif.s_axi_arburst = req.s_axi_arburst;
      vif.s_axi_arlock = req.s_axi_arlock;
      vif.s_axi_arcache = req.s_axi_arcache;
      vif.s_axi_arprot = req.s_axi_arprot;
      vif.s_axi_arqos = req.s_axi_arqos;
      vif.s_axi_arregion = req.s_axi_arregion;
      vif.s_axi_aruser = req.s_axi_aruser;
      vif.s_axi_arvalid = req.s_axi_arvalid;
    vif.m_axi_awready = req.m_axi_awready;
    vif.m_axi_bid = req.m_axi_bid;
     vif.m_axi_bresp = req.m_axi_bresp;
     vif.m_axi_buser = req.m_axi_buser;
     vif.m_axi_bvalid = req.m_axi_bvalid;
    vif.m_axi_arready = req.m_axi_arready;
     vif.m_axi_rid = req.m_axi_rid;
     vif.m_axi_rresp = req.m_axi_rresp;
     vif.m_axi_rlast = req.m_axi_rlast;
     vif.m_axi_ruser = req.m_axi_ruser;
    @(posedge vif.clk); 
    
    /////output data
      req.m_axi_wdata = vif.m_axi_wdata;
      req.s_axi_rdata = vif.s_axi_rdata;
     
    ////////////////other output signals////////////////
    req.s_axi_awready=vif.s_axi_awready;
    req.s_axi_wready=vif.s_axi_wready;
     req.s_axi_bid = vif.s_axi_bid;
    req.s_axi_bresp=vif.s_axi_bresp;
     req.s_axi_buser = vif.s_axi_buser;
      req.s_axi_bvalid=vif.s_axi_bvalid;
    req.s_axi_arready = vif.s_axi_arready;
      req.s_axi_rid = vif.s_axi_rid;
      req.s_axi_rdata =vif.s_axi_rdata;
      req.s_axi_rresp = vif.s_axi_rresp;
      req.s_axi_rlast = vif.s_axi_rlast;
      req.s_axi_ruser =vif.s_axi_ruser;
      req.s_axi_rvalid = vif.s_axi_rvalid;
    req.m_axi_awid = vif.m_axi_awid;
     req.m_axi_awaddr = vif.m_axi_awaddr;
     req.m_axi_awlen = vif.m_axi_awlen;
     req.m_axi_awsize = vif.m_axi_awsize;
     req.m_axi_awburst = vif.m_axi_awburst;
     req.m_axi_awlock = vif.m_axi_awlock;
     req.m_axi_awcache = vif.m_axi_awcache;
     req.m_axi_awprot = vif.m_axi_awprot;
     req.m_axi_awqos=vif.m_axi_awqos;
     req.m_axi_awregion = vif.m_axi_awregion;
     req.m_axi_awuser = vif.m_axi_awuser;
     req.m_axi_awvalid = vif.m_axi_awvalid;
    req.m_axi_wstrb = vif.m_axi_wstrb;
     req.m_axi_wlast = vif.m_axi_wlast;
     req.m_axi_wuser = vif.m_axi_wuser;
     req.m_axi_wvalid = vif.m_axi_wvalid;
    req.m_axi_bready = vif.m_axi_bready;
     req.m_axi_arid = vif.m_axi_arid;
     req.m_axi_araddr = vif.m_axi_araddr;
     req.m_axi_arlen = vif.m_axi_arlen;
     req.m_axi_arsize = vif.m_axi_arsize;
     req.m_axi_arburst = vif.m_axi_arburst;
     req.m_axi_arlock = vif.m_axi_arlock;
     req.m_axi_arcache = vif.m_axi_arlock;
     req.m_axi_arprot = vif.m_axi_arprot;
     req.m_axi_arqos = vif.m_axi_arqos;
     req.m_axi_arregion = vif.m_axi_arregion;
     req.m_axi_aruser = vif.m_axi_aruser;
     req.m_axi_arvalid = vif.m_axi_arvalid;
    req.m_axi_rready = vif.m_axi_rready;
    $display("m_axi_awid =%h",vif.m_axi_awid);
//----------------DISPLAY DATA AT THIRD CLOCK EDGE
    @(posedge vif.clk)
    $display("-----------------------------------------------");
    $display("s_axi_wvalid = %h, s_axi_wdata=%h, m_axi_rvalid=%h, m_axi_rdata=%h, m_axi_wready=%h, s_axi_rready=%h",vif.s_axi_wvalid,vif.s_axi_wdata,vif.m_axi_rvalid,vif.m_axi_rdata,vif.m_axi_wready,vif.s_axi_rready);
    $display("m_axi_wdata=%h,s_axi_rdata=%h",vif.m_axi_wdata,vif.s_axi_rdata);
    
    
    
  endtask : drive
endclass : mem_driver