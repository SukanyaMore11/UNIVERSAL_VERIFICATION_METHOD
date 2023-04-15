//------------------------------------------------
// UVM Sequence
//------------------------------------------------


// //=========================================================================
// // mem_sequence - random stimulus 
// //=========================================================================
class mem_sequence extends uvm_sequence#(mem_seq_item);
  
  `uvm_object_utils(mem_sequence)
  
  //--------------------------------------- 
  //Constructor
  //---------------------------------------
  function new(string name = "mem_sequence");
    super.new(name);
  endfunction
  
  `uvm_declare_p_sequencer(mem_sequencer)
  
  //---------------------------------------
  // create, randomize and send the item to driver
  //---------------------------------------
  virtual task body();
    repeat(5) begin
    req = mem_seq_item::type_id::create("req");
    wait_for_grant();
    req.randomize();
    send_request(req);
    wait_for_item_done();
   end 
  endtask
endclass
//=========================================================================



// //=========================================================================
// //
// //=========================================================================
class wr_rd_sequence extends uvm_sequence#(mem_seq_item);
  
  `uvm_object_utils(wr_rd_sequence)
   
  //--------------------------------------- 
  //Constructor
  //---------------------------------------
  function new(string name = "wr_rd_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do_with(req,{req.s_axil_a_arvalid==1;})
    `uvm_do_with(req,{req.s_axil_b_arvalid==1;})
    `uvm_do_with(req,{req.s_axil_a_wvalid==0;})
    `uvm_do_with(req,{req.s_axil_a_awvalid==0;})
    `uvm_do_with(req,{req.s_axil_b_wvalid==0;})
    `uvm_do_with(req,{req.s_axil_b_awvalid==0;}) 
    `uvm_do_with(req,{req.s_axil_a_wvalid==1;})
    `uvm_do_with(req,{req.s_axil_a_awvalid==1;})
    `uvm_do_with(req,{req.s_axil_b_wvalid==1;})
    `uvm_do_with(req,{req.s_axil_b_awvalid==1;})
    `uvm_do_with(req,{req.s_axil_a_arvalid==0;})
    `uvm_do_with(req,{req.s_axil_b_arvalid==0;})
  endtask
endclass
// //=========================================================================


