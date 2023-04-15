// UVM MONITOR
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
    $display("-----------------------------------------------");
//      $display("monitor_input_data %t", $time);
//// write operation signals and input data////
      trans_collected.s_axi_wvalid = vif.s_axi_wvalid;
      trans_collected.s_axi_wdata = vif.s_axi_wdata;
      trans_collected.m_axi_rvalid = vif.m_axi_rvalid;
      trans_collected.m_axi_rdata = vif.m_axi_rdata;
    //read opeartion signals
      
    trans_collected.m_axi_wready = vif.m_axi_wready;
    trans_collected.s_axi_rready = vif.s_axi_rready;
//     $display("s_axi_wvalid = %h, s_axi_wdata=%h, m_axi_rvalid=%h, m_axi_rdata=%h, m_axi_wready=%h, s_axi_rready=%h",vif.s_axi_wvalid,vif.s_axi_wdata,vif.m_axi_rvalid,vif.m_axi_rdata,vif.m_axi_wready,vif.s_axi_rready);
    ///////////some important input data/////////
    trans_collected.s_axi_wdata = vif.s_axi_wdata;
      trans_collected.s_axi_wstrb = vif.s_axi_wstrb;
      trans_collected.s_axi_wlast = vif.s_axi_wlast;
      trans_collected.s_axi_wuser = vif.s_axi_wuser;
//     $display("s_axi_wdata=%h, s_axi_wstrb=%h, s_axi_wlast=%h",req.s_axi_wdata,req.s_axi_wstrb,req.s_axi_wlast);
    ///////////other input signals//////////
    trans_collected.s_axi_awid = vif.s_axi_awid;
      trans_collected.s_axi_awaddr=vif.s_axi_awaddr;
    trans_collected.s_axi_awlen=vif.s_axi_awlen;
      trans_collected.s_axi_awsize=vif.s_axi_awsize;
      trans_collected.s_axi_awburst=vif.s_axi_awburst;
      trans_collected.s_axi_awlock=vif.s_axi_awlock;
      trans_collected.s_axi_awcache=vif.s_axi_awcache;
      trans_collected.s_axi_awprot=vif.s_axi_awprot;
      trans_collected.s_axi_awqos=vif.s_axi_awqos;
      trans_collected.s_axi_awregion=vif.s_axi_awregion;
      trans_collected.s_axi_awuser=vif.s_axi_awuser;
      trans_collected.s_axi_awvalid = vif.s_axi_awvalid;
    trans_collected.s_axi_bready = vif.s_axi_bready;
      trans_collected.s_axi_arid = vif.s_axi_arid;
      trans_collected.s_axi_araddr = vif.s_axi_araddr;
      trans_collected.s_axi_arlen = vif.s_axi_arlen ;
      trans_collected.s_axi_arsize = vif.s_axi_arsize;
      trans_collected.s_axi_arburst = vif.s_axi_arburst;
      trans_collected.s_axi_arlock = vif.s_axi_arlock;
      trans_collected.s_axi_arcache = vif.s_axi_arcache;
      trans_collected.s_axi_arprot = vif.s_axi_arprot;
      trans_collected.s_axi_arqos = vif.s_axi_arqos;
      trans_collected.s_axi_arregion = vif.s_axi_arregion;
      trans_collected.s_axi_aruser = vif.s_axi_aruser;
      trans_collected.s_axi_arvalid = vif.s_axi_arvalid;
    trans_collected.m_axi_awready = vif.m_axi_awready;
    trans_collected.m_axi_bid = vif.m_axi_bid;
     trans_collected.m_axi_bresp = vif.m_axi_bresp;
     trans_collected.m_axi_buser = vif.m_axi_buser;
     trans_collected.m_axi_bvalid = vif.m_axi_bvalid;
    trans_collected.m_axi_arready = vif.m_axi_arready;
     trans_collected.m_axi_rid = vif.m_axi_rid;
     trans_collected.m_axi_rresp = vif.m_axi_rresp;
     trans_collected.m_axi_rlast = vif.m_axi_rlast;
     trans_collected.m_axi_ruser = vif.m_axi_ruser;
    @(posedge vif.clk); 
      $display("-----------------------------------------------");
//     $display("monitor_output_data %t", $time);
    /////output data
      trans_collected.m_axi_wdata = vif.m_axi_wdata;
      trans_collected.s_axi_rdata = vif.s_axi_rdata;
//       trans_collected.wr_ptr_reg_wr = vif.wr_ptr_reg_wr;
//     trans_collected.rd_ptr_reg_wr = vif.rd_ptr_reg_wr;
//     trans_collected.wr_ptr_reg_rd = vif.wr_ptr_reg_rd;
//     trans_collected.rd_ptr_reg_rd = vif.rd_ptr_reg_rd;

    ////////////////other output signals////////////////
    trans_collected.s_axi_awready=vif.s_axi_awready;
    trans_collected.s_axi_wready=vif.s_axi_wready;
     trans_collected.s_axi_bid = vif.s_axi_bid;
    trans_collected.s_axi_bresp=vif.s_axi_bresp;
     trans_collected.s_axi_buser = vif.s_axi_buser;
      trans_collected.s_axi_bvalid=vif.s_axi_bvalid;
    trans_collected.s_axi_arready = vif.s_axi_arready;
      trans_collected.s_axi_rid = vif.s_axi_rid;
      trans_collected.s_axi_rdata =vif.s_axi_rdata;
      trans_collected.s_axi_rresp = vif.s_axi_rresp;
      trans_collected.s_axi_rlast = vif.s_axi_rlast;
      trans_collected.s_axi_ruser =vif.s_axi_ruser;
      trans_collected.s_axi_rvalid = vif.s_axi_rvalid;
    trans_collected.m_axi_awid = vif.m_axi_awid;
     trans_collected.m_axi_awaddr = vif.m_axi_awaddr;
     trans_collected.m_axi_awlen = vif.m_axi_awlen;
     trans_collected.m_axi_awsize = vif.m_axi_awsize;
     trans_collected.m_axi_awburst = vif.m_axi_awburst;
     trans_collected.m_axi_awlock = vif.m_axi_awlock;
     trans_collected.m_axi_awcache = vif.m_axi_awcache;
     trans_collected.m_axi_awprot = vif.m_axi_awprot;
     trans_collected.m_axi_awqos=vif.m_axi_awqos;
     trans_collected.m_axi_awregion = vif.m_axi_awregion;
     trans_collected.m_axi_awuser = vif.m_axi_awuser;
     trans_collected.m_axi_awvalid = vif.m_axi_awvalid;
    trans_collected.m_axi_wstrb = vif.m_axi_wstrb;
     trans_collected.m_axi_wlast = vif.m_axi_wlast;
     trans_collected.m_axi_wuser = vif.m_axi_wuser;
     trans_collected.m_axi_wvalid = vif.m_axi_wvalid;
    trans_collected.m_axi_bready = vif.m_axi_bready;
     trans_collected.m_axi_arid = vif.m_axi_arid;
     trans_collected.m_axi_araddr = vif.m_axi_araddr;
     trans_collected.m_axi_arlen = vif.m_axi_arlen;
     trans_collected.m_axi_arsize = vif.m_axi_arsize;
     trans_collected.m_axi_arburst = vif.m_axi_arburst;
     trans_collected.m_axi_arlock = vif.m_axi_arlock;
     trans_collected.m_axi_arcache = vif.m_axi_arlock;
     trans_collected.m_axi_arprot = vif.m_axi_arprot;
     trans_collected.m_axi_arqos = vif.m_axi_arqos;
     trans_collected.m_axi_arregion = vif.m_axi_arregion;
     trans_collected.m_axi_aruser = vif.m_axi_aruser;
     trans_collected.m_axi_arvalid = vif.m_axi_arvalid;
    trans_collected.m_axi_rready = vif.m_axi_rready;
    
//     trans_collected.wr_ptr_reg_rd = vif.wr_ptr_reg_rd;
//      trans_collected.rd_ptr_reg_rd = vif.rd_ptr_reg_rd;
//      trans_collected.wr_ptr_reg_wr = vif.wr_ptr_reg_wr;
//      trans_collected.rd_ptr_reg_wr = vif.rd_ptr_reg_wr;
      
      @(posedge vif.clk) 
//--------------------------------------------------------
// WRITE DATA FROM TRANS COLLECTED TO TRANS PORT
//--------------------------------------------------------
	  item_collected_port.write(trans_collected);
      
//---------------------------------------------------------------
// DISPLAY DATA TO CHECK      
      $display("---------------------[Monitor]--------------------------");
      $display("s_axi_wvalid = %h, s_axi_wdata=%h, m_axi_rvalid=%h, m_axi_rdata=%h, m_axi_wready=%h, s_axi_rready=%h",vif.s_axi_wvalid,vif.s_axi_wdata,vif.m_axi_rvalid,vif.m_axi_rdata,vif.m_axi_wready,vif.s_axi_rready);
$display("m_axi_wdata=%h,s_axi_rdata=%h",vif.m_axi_wdata,vif.s_axi_rdata); 

    end    
  endtask : run_phase

endclass : mem_monitor