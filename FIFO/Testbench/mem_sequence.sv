// //-------------------------------------------------------------------------
// //UVM SEQUENCE
// //-------------------------------------------------------------------------

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
    repeat(1) begin
    req = mem_seq_item::type_id::create("req");
    wait_for_grant();
    req.randomize();
    send_request(req);
    wait_for_item_done();
   end 
  endtask
endclass
//=========================================================================

class wr_rd_sequence extends uvm_sequence#(mem_seq_item);
  
  `uvm_object_utils(wr_rd_sequence)
   
  //--------------------------------------- 
  //Constructor
  //---------------------------------------
  function new(string name = "wr_rd_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)begin
    `uvm_do_with(req,{req.w_en==1;})
    `uvm_do_with(req,{req.r_en==1;})
    end
  endtask
endclass
//=========================================================================


