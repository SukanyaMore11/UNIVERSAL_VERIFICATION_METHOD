//UVM SEQUENCE_ITEM
class mem_seq_item extends uvm_sequence_item;
  
  //declaring the transaction items
  rand bit w_en, r_en;
  rand bit [15:0]din;
  bit [15:0]dout;
  bit full;
  bit empty;
  bit half_full;
  bit [2:0]counter;
  bit [1:0] write_pointer;
  bit [1:0] read_pointer;
  
  `uvm_object_utils_begin(mem_seq_item)
  `uvm_field_int(    w_en ,UVM_ALL_ON)
  `uvm_field_int(    r_en ,UVM_ALL_ON)
  `uvm_field_int(    din ,UVM_ALL_ON)
  `uvm_object_utils_end
  
  //---------------------------------------
  //Constructor
  //---------------------------------------
  function new(string name = "mem_seq_item");
    super.new(name);
  endfunction
  
// //   constraint wr_rd_en{if(empty) {w_en != r_en;}};
//   function void display(string name);
//     $display("-------------------------");
//     $display("- %s ",name);
//     $display("-------------------------");
//     $display("- w_en = %d, r_en = %d,din=%d ",w_en,r_en,din);
//     $display("- full = %d, empty =%d, half_full=%d, dout=%d, counter=%d",full,empty,half_full,dout,counter);
//     $display("-------------------------");
//   endfunction
endclass
