//------------------------------------------------
// UVM Testbench
//------------------------------------------------
//including interfcae and testcase files
`include "mem_interface.sv"
`include "mem_wr_rd_test.sv"
module tbench_top();
  //---------------------------------------
  //clock and reset signal declaration
  //---------------------------------------
  bit a_clk, b_clk;
  bit a_rst, b_rst;
  
  //---------------------------------------
  //clock generation
  //---------------------------------------
  always #5 a_clk = ~a_clk;
  always #5 b_clk = ~b_clk;
  
  //---------------------------------------
  //reset Generation
  //---------------------------------------
  initial begin
    a_rst = 1;
    b_rst = 1;
    #10;
    a_rst =0;
    b_rst = 0;
  end
  
  //---------------------------------------
  //interface instance
  //---------------------------------------
  mem_if intf(a_clk,a_rst,b_clk,b_rst);
  
  //---------------------------------------
  //DUT instance
  //---------------------------------------
  axil_dp_ram 
  DUT (
    

    /*
     * AXI slave-A interface
     */
    .s_axil_a_awaddr(intf.s_axil_a_awaddr),
    .s_axil_a_awprot(intf.s_axil_a_awprot),
    .s_axil_a_awvalid(intf.s_axil_a_awvalid),
    .s_axil_a_awready(intf.s_axil_a_awready),
    .s_axil_a_wdata(intf.s_axil_a_wdata),
    .s_axil_a_wstrb(intf.s_axil_a_wstrb),
    .s_axil_a_wvalid(intf.s_axil_a_wvalid),
    .s_axil_a_wready(intf.s_axil_a_wready),
    .s_axil_a_bresp(intf.s_axil_a_bresp),
    .s_axil_a_bvalid(intf.s_axil_a_bvalid),
    .s_axil_a_bready(intf.s_axil_a_bready),
    .s_axil_a_araddr(intf.s_axil_a_araddr),
    .s_axil_a_arprot(intf.s_axil_a_arprot),
    .s_axil_a_arvalid(intf.s_axil_a_arvalid),
    .s_axil_a_arready(intf.s_axil_a_arready),
    .s_axil_a_rdata(intf.s_axil_a_rdata),
    .s_axil_a_rresp(intf.s_axil_a_rresp),
    .s_axil_a_rvalid(intf.s_axil_a_rvalid),
    .s_axil_a_rready(intf.s_axil_a_rready),


/*
     * AXI slave-B interface
     */
    .s_axil_b_awaddr(intf.s_axil_b_awaddr),
    .s_axil_b_awprot(intf.s_axil_b_awprot),
    .s_axil_b_awvalid(intf.s_axil_b_awvalid),
    .s_axil_b_awready(intf.s_axil_b_awready),
    .s_axil_b_wdata(intf.s_axil_b_wdata),
    .s_axil_b_wstrb(intf.s_axil_b_wstrb),
    .s_axil_b_wvalid(intf.s_axil_b_wvalid),
    .s_axil_b_wready(intf.s_axil_b_wready),
    .s_axil_b_bresp(intf.s_axil_b_bresp),
    .s_axil_b_bvalid(intf.s_axil_b_bvalid),
    .s_axil_b_bready(intf.s_axil_b_bready),
    .s_axil_b_araddr(intf.s_axil_b_araddr),
    .s_axil_b_arprot(intf.s_axil_b_arprot),
    .s_axil_b_arvalid(intf.s_axil_b_arvalid),
    .s_axil_b_arready(intf.s_axil_b_arready),
    .s_axil_b_rdata(intf.s_axil_b_rdata),
    .s_axil_b_rresp(intf.s_axil_b_rresp),
    .s_axil_b_rvalid(intf.s_axil_b_rvalid),
    .s_axil_b_rready(intf.s_axil_b_rready)

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