//------------------------------------------------
// UVM Sequence_item
//------------------------------------------------
class mem_seq_item extends uvm_sequence_item;
  //---------------------------------------
  //data and control fields
  //---------------------------------------
  
    // Width of data bus in bits
    parameter DATA_WIDTH = 32;
    // Width of address bus in bits
    parameter ADDR_WIDTH = 16;
    // Width of wstrb (width of data bus in words)
    parameter STRB_WIDTH = (DATA_WIDTH/8);
    // Extra pipeline register on output
    parameter PIPELINE_OUTPUT = 0;
  

    /*
     * AXI slave A interface
     */
    rand bit [ADDR_WIDTH-1:0]  s_axil_a_awaddr;
    rand bit [2:0]             s_axil_a_awprot;
    rand bit                   s_axil_a_awvalid;
    bit                   s_axil_a_awready;
    rand bit [DATA_WIDTH-1:0]  s_axil_a_wdata;
    rand bit [STRB_WIDTH-1:0]  s_axil_a_wstrb;
    rand bit                   s_axil_a_wvalid;
    bit                   s_axil_a_wready;
    bit [1:0]             s_axil_a_bresp;
    bit                   s_axil_a_bvalid;
    rand bit                   s_axil_a_bready;
    rand bit [ADDR_WIDTH-1:0]  s_axil_a_araddr;
    rand bit [2:0]             s_axil_a_arprot;
    rand bit                   s_axil_a_arvalid;
    bit                   s_axil_a_arready;
    bit [DATA_WIDTH-1:0]  s_axil_a_rdata;
    bit [1:0]             s_axil_a_rresp;
    bit                   s_axil_a_rvalid;
    rand bit                   s_axil_a_rready;

    /*
     * AXI slave B interface
     */
    rand bit [ADDR_WIDTH-1:0]  s_axil_b_awaddr;
    rand bit [2:0]             s_axil_b_awprot;
    rand bit                   s_axil_b_awvalid;
    bit                   s_axil_b_awready;
    rand bit [DATA_WIDTH-1:0]  s_axil_b_wdata;
    rand bit [STRB_WIDTH-1:0]  s_axil_b_wstrb;
    rand bit                   s_axil_b_wvalid;
    bit                   s_axil_b_wready;
    bit [1:0]             s_axil_b_bresp;
    bit                   s_axil_b_bvalid;
    rand bit                   s_axil_b_bready;
    rand bit [ADDR_WIDTH-1:0]  s_axil_b_araddr;
    rand bit [2:0]             s_axil_b_arprot;
    rand bit                   s_axil_b_arvalid;
    bit                   s_axil_b_arready;
    bit [DATA_WIDTH-1:0]  s_axil_b_rdata;
    bit [1:0]             s_axil_b_rresp;
    bit                   s_axil_b_rvalid;
    rand bit                   s_axil_b_rready;
    
  
  //---------------------------------------
  //Utility and Field macros
  //---------------------------------------
  `uvm_object_utils_begin(mem_seq_item)
//     `uvm_field_int(addr,UVM_ALL_ON)
    /*
     * AXI slave interface
     */
    `uvm_field_int(   s_axil_a_awaddr ,UVM_ALL_ON)
    `uvm_field_int(   s_axil_a_awprot ,UVM_ALL_ON)
    `uvm_field_int(   s_axil_a_awvalid ,UVM_ALL_ON)
    `uvm_field_int(   s_axil_a_wdata ,UVM_ALL_ON)
    `uvm_field_int(   s_axil_a_wstrb ,UVM_ALL_ON)
    `uvm_field_int(   s_axil_a_wvalid ,UVM_ALL_ON)
    `uvm_field_int(   s_axil_a_bready ,UVM_ALL_ON)
    `uvm_field_int(   s_axil_a_araddr ,UVM_ALL_ON)
    `uvm_field_int(   s_axil_a_arprot ,UVM_ALL_ON)
    `uvm_field_int(   s_axil_a_arvalid ,UVM_ALL_ON)
    `uvm_field_int(   s_axil_a_rready ,UVM_ALL_ON)
    `uvm_field_int(   s_axil_b_awaddr ,UVM_ALL_ON)
    `uvm_field_int(   s_axil_b_awprot ,UVM_ALL_ON)
    `uvm_field_int(   s_axil_b_awvalid ,UVM_ALL_ON)
    `uvm_field_int(   s_axil_b_wdata ,UVM_ALL_ON)
    `uvm_field_int(   s_axil_b_wstrb ,UVM_ALL_ON)
    `uvm_field_int(   s_axil_b_wvalid ,UVM_ALL_ON)
    `uvm_field_int(   s_axil_b_bready ,UVM_ALL_ON)
    `uvm_field_int(   s_axil_b_araddr ,UVM_ALL_ON)
    `uvm_field_int(   s_axil_b_arprot ,UVM_ALL_ON)
    `uvm_field_int(   s_axil_b_arvalid ,UVM_ALL_ON)
    `uvm_field_int(   s_axil_b_rready ,UVM_ALL_ON)
  `uvm_object_utils_end
  
  //---------------------------------------
  //Constructor
  //---------------------------------------
  function new(string name = "mem_seq_item");
    super.new(name);
  endfunction
  
  
endclass