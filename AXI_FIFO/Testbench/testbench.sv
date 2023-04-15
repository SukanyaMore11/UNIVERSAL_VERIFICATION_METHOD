// TOP TESTBENCH
//---------------------------------------------------------------
//including interfcae and testcase files
`include "mem_interface.sv"
`include "mem_wr_rd_test.sv"
module tbench_top();
  //---------------------------------------
  //clock and reset signal declaration
  //---------------------------------------
  bit clk;
  bit reset;
  
  //---------------------------------------
  //clock generation
  //---------------------------------------
  always #5 clk = ~clk;
  
  //---------------------------------------
  //reset Generation
  //---------------------------------------
  initial begin
    reset = 1;
    #5 reset =0;
  end
  
  //---------------------------------------
  //interface instance
  //---------------------------------------
  mem_if intf(clk,reset);
  
  //---------------------------------------
  //DUT instance
  //---------------------------------------
  axi_fifo 
  DUT (
    
    /*
     * AXI slave interface
     */
    .s_axi_awid(intf.s_axi_awid),
    .s_axi_awaddr(intf.s_axi_awaddr),
    .s_axi_awlen(intf.s_axi_awlen),
    .s_axi_awsize(intf.s_axi_awsize),
    .s_axi_awburst(intf.s_axi_awburst),
    .s_axi_awlock(intf.s_axi_awlock),
    .s_axi_awcache(intf.s_axi_awcache),
    .s_axi_awprot(intf.s_axi_awprot),
    .s_axi_awqos(intf.s_axi_awqos),
    .s_axi_awregion(intf.s_axi_awregion),
    .s_axi_awuser(intf.s_axi_awuser),
    .s_axi_awvalid(intf.s_axi_awvalid),
    .s_axi_awready(intf.s_axi_awready),
    .s_axi_wdata(intf.s_axi_wdata),
    .s_axi_wstrb(intf.s_axi_wstrb),
    .s_axi_wlast(intf.s_axi_wlast),
    .s_axi_wuser(intf.s_axi_wuser),
    .s_axi_wvalid(intf.s_axi_wvalid),
    .s_axi_wready(intf.s_axi_wready),
    .s_axi_bid(intf.s_axi_bid),
    .s_axi_bresp(intf.s_axi_bresp),
    .s_axi_buser(intf.s_axi_buser),
    .s_axi_bvalid(intf.s_axi_bvalid),
    .s_axi_bready(intf.s_axi_bready),
    .s_axi_arid(intf.s_axi_arid),
    .s_axi_araddr(intf.s_axi_araddr),
    .s_axi_arlen(intf.s_axi_arlen),
    .s_axi_arsize(intf.s_axi_arsize),
    .s_axi_arburst(intf.s_axi_arburst),
    .s_axi_arlock(intf.s_axi_arlock),
    .s_axi_arcache(intf.s_axi_arcache),
    .s_axi_arprot(intf.s_axi_arprot),
    .s_axi_arqos(intf.s_axi_arqos),
    .s_axi_arregion(intf.s_axi_arregion),
    .s_axi_aruser(intf.s_axi_aruser),
    .s_axi_arvalid(intf.s_axi_arvalid),
    .s_axi_arready(intf.s_axi_arready),
    .s_axi_rid(intf.s_axi_rid),
    .s_axi_rdata(intf.s_axi_rdata),
    .s_axi_rresp(intf.s_axi_rresp),
    .s_axi_rlast(intf.s_axi_rlast),
    .s_axi_ruser(intf.s_axi_ruser),
    .s_axi_rvalid(intf.s_axi_rvalid),
    .s_axi_rready(intf.s_axi_rready),


/*
     * AXI master interface
     */
    .m_axi_awid(intf.m_axi_awid),
    .m_axi_awaddr(intf.m_axi_awaddr),
    .m_axi_awlen(intf.m_axi_awlen),
    .m_axi_awsize(intf.m_axi_awsize),
    .m_axi_awburst(intf.m_axi_awburst),
    .m_axi_awlock(intf.m_axi_awlock),
    .m_axi_awcache(intf.m_axi_awcache),
    .m_axi_awprot(intf.m_axi_awprot),
    .m_axi_awqos(intf.m_axi_awqos),
    .m_axi_awregion(intf.m_axi_awregion),
    .m_axi_awuser(intf.m_axi_awuser),
    .m_axi_awvalid(intf.m_axi_awvalid),
    .m_axi_awready(intf.m_axi_awready),
    .m_axi_wdata(intf.m_axi_wdata),
    .m_axi_wstrb(intf.m_axi_wstrb),
    .m_axi_wlast(intf.m_axi_wlast),
    .m_axi_wuser(intf.m_axi_wuser),
    .m_axi_wvalid(intf.m_axi_wvalid),
    .m_axi_wready(intf.m_axi_wready),
    .m_axi_bid(intf.m_axi_bid),
    .m_axi_bresp(intf.m_axi_bresp),
    .m_axi_buser(intf.m_axi_buser),
    .m_axi_bvalid(intf.m_axi_bvalid),
    .m_axi_bready(intf.m_axi_bready),
    
.m_axi_arid(intf.m_axi_arid),
    .m_axi_araddr(intf.m_axi_araddr),
    .m_axi_arlen(intf.m_axi_arlen),
    .m_axi_arsize(intf.m_axi_arsize),
    .m_axi_arburst(intf.m_axi_arburst),
    .m_axi_arlock(intf.m_axi_arlock),
    .m_axi_arcache(intf.m_axi_arcache),
    .m_axi_arprot(intf.m_axi_arprot),
    .m_axi_arqos(intf.m_axi_arqos),
    .m_axi_arregion(intf.m_axi_arregion),
    .m_axi_aruser(intf.m_axi_aruser),
    .m_axi_arvalid(intf.m_axi_arvalid),
    .m_axi_arready(intf.m_axi_arready),
    .m_axi_rid(intf.m_axi_rid),
    .m_axi_rdata(intf.m_axi_rdata),
    .m_axi_rresp(intf.m_axi_rresp),
    .m_axi_rlast(intf.m_axi_rlast),
    .m_axi_ruser(intf.m_axi_ruser),
    .m_axi_rvalid(intf.m_axi_rvalid),
    .m_axi_rready(intf.m_axi_rready)
    
   );
  
  //---------------------------------------
  //passing the interface handle to lower heirarchy using set method 
  //and enabling the wave dump
  //---------------------------------------
  initial begin 
    uvm_config_db#(virtual mem_if)::set(uvm_root::get(),"*","vif",intf);
    //enable wave dump
    $dumpfile("dump.vcd"); 
    $dumpvars();
  end
  
  //---------------------------------------
  //calling test
  //---------------------------------------
  initial begin 
    run_test();
  end
endmodule