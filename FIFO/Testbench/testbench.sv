//-------------------------------------------------------------------------
//UVM testbench
//-------------------------------------------------------------------------
//---------------------------------------------------------------
//including interfcae and testcase files
`include "mem_interface.sv"
`include "mem_wr_rd_test.sv"
module tbench_top();
  //---------------------------------------
  //clock and rst signal declaration
  //---------------------------------------
  bit clk;
  bit rst;
  
  //---------------------------------------
  //clock generation
  //---------------------------------------
  always #1 clk = ~clk;
  
  //---------------------------------------
  //rst Generation
  //---------------------------------------
  initial begin
    rst = 1;
    #1 rst =0;
  end
  
  //---------------------------------------
  //interface instance
  //---------------------------------------
  mem_if intf(clk,rst);
  
  //---------------------------------------
  //DUT instance
  //---------------------------------------
  top_fifo DUT(
    .clk(intf.clk),
    .rst(intf.rst),
    .din(intf.din),
    .w_en(intf.w_en),
    .r_en(intf.r_en),
    .dout(intf.dout),
    .full(intf.full),
    .empty(intf.empty),
    .half_full(intf.half_full),
    .counter(intf.counter),
    .valid(intf.valid),
    .read_pointer(intf.read_pointer),
    .write_pointer(intf.write_pointer)
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