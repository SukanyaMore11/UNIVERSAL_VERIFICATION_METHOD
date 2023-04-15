//------------------------------------------------
// UVM Monitor
//------------------------------------------------

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
      @(posedge vif.a_clk);
    $display("-----------------------------------------------");
//      $display("monitor_input_data %t", $time);
//// write operation signals and input data////
      trans.s_axil_a_awaddr = vif.s_axil_a_awaddr;
      trans.s_axil_a_awprot = vif.s_axil_a_awprot;
      trans.s_axil_a_awvalid = vif.s_axil_a_awvalid;
      trans.s_axil_a_wdata = vif.s_axil_a_wdata;
      trans.s_axil_a_wstrb = vif.s_axil_a_wstrb;
      trans.s_axil_a_wvalid = vif.s_axil_a_wvalid;
      trans.s_axil_a_bready = vif.s_axil_a_bready;
      trans.s_axil_a_araddr = vif.s_axil_a_araddr;
      trans.s_axil_a_arprot = vif.s_axil_a_arprot;
      trans.s_axil_a_arvalid = vif.s_axil_a_arvalid;
      trans.s_axil_a_rready = vif.s_axil_a_rready;
      
      @(posedge vif.a_clk); 
      $display("-----------------------------------------------");
    /////output data
      trans.s_axil_a_awready = vif.s_axil_a_awready;
      trans.s_axil_a_wready = vif.s_axil_a_wready;
      trans.s_axil_a_bresp = vif.s_axil_a_bresp;
      trans.s_axil_a_bvalid = vif.s_axil_a_bvalid;
      trans.s_axil_a_arready = vif.s_axil_a_arready;
      trans.s_axil_a_rdata = vif.s_axil_a_rdata;
      trans.s_axil_a_rresp = vif.s_axil_a_rresp;
      trans.s_axil_a_rvalid = vif.s_axil_a_rvalid;
   
      
      @(posedge vif.a_clk) 
	  item_collected_port.write(trans_collected);
      $display("---------------------[Monitor]--------------------------");
      $display("s_axi_wvalid = %h, s_axi_wdata=%h, m_axi_rvalid=%h, m_axi_rdata=%h, m_axi_wready=%h, s_axi_rready=%h",vif.s_axi_wvalid,vif.s_axi_wdata,vif.m_axi_rvalid,vif.m_axi_rdata,vif.m_axi_wready,vif.s_axi_rready);
$display("m_axi_wdata=%h,s_axi_rdata=%h",vif.m_axi_wdata,vif.s_axi_rdata); 
//       $display("m_axi_wdata=%h,s_axi_rdata=%h,wr_ptr_reg_wr=%h,rd_ptr_reg_wr=%h,wr_ptr_reg_rd=%h,rd_ptr_reg_rd=%h",vif.m_axi_wdata,vif.s_axi_rdata,vif.wr_ptr_reg_wr,vif.rd_ptr_reg_wr,vif.wr_ptr_reg_rd,vif.rd_ptr_reg_rd);
   
      end 
      
  endtask : run_phase

endclass : mem_monitor