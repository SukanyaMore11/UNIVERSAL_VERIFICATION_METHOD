//UVM SEQUENCE ITEM
class mem_seq_item extends uvm_sequence_item;
  //---------------------------------------
  //data and control fields
  //---------------------------------------
  
  // Width of data bus in bits
    parameter DATA_WIDTH = 32;
    // Width of address bus in bits
    parameter ADDR_WIDTH = 32;
    // Width of wstrb (width of data bus in words)
    parameter STRB_WIDTH = (DATA_WIDTH/8);
    // Width of ID signal
    parameter ID_WIDTH = 8;
    // Propagate awuser signal
    parameter AWUSER_ENABLE = 0;
    // Width of awuser signal
    parameter AWUSER_WIDTH = 1;
    // Propagate wuser signal
    parameter WUSER_ENABLE = 0;
    // Width of wuser signal
    parameter WUSER_WIDTH = 1;
    // Propagate buser signal
    parameter BUSER_ENABLE = 0;
    // Width of buser signal
    parameter BUSER_WIDTH = 1;
    // Propagate aruser signal
    parameter ARUSER_ENABLE = 0;
    // Width of aruser signal
    parameter ARUSER_WIDTH = 1;
    // Propagate ruser signal
    parameter RUSER_ENABLE = 0;
    // Width of ruser signal
    parameter RUSER_WIDTH = 1;
    // Write data FIFO depth (cycles)
    parameter WRITE_FIFO_DEPTH = 32;
    // Read data FIFO depth (cycles)
    parameter READ_FIFO_DEPTH = 32;
    // Hold write address until write data in FIFO, if possible
    parameter WRITE_FIFO_DELAY = 0;
    // Hold read address until space available in FIFO for data, if possible
    parameter READ_FIFO_DELAY = 0;
  


    /*
     * AXI slave interface
     */
    rand  bit[ID_WIDTH-1:0]      s_axi_awid;
    rand  bit[ADDR_WIDTH-1:0]    s_axi_awaddr;
    rand  bit[7:0]               s_axi_awlen;
    rand  bit[2:0]               s_axi_awsize;
    rand  bit[1:0]               s_axi_awburst;
    rand  bit                    s_axi_awlock;
    rand  bit[3:0]               s_axi_awcache;
    rand  bit[2:0]               s_axi_awprot;
    rand  bit[3:0]               s_axi_awqos;
  rand  bit[3:0]               s_axi_awregion;
    rand  bit[AWUSER_WIDTH-1:0]  s_axi_awuser;
    rand  bit                    s_axi_awvalid;
     bit                    s_axi_awready;
    rand  bit[DATA_WIDTH-1:0]    s_axi_wdata;
    rand  bit[STRB_WIDTH-1:0]    s_axi_wstrb;
    rand  bit                    s_axi_wlast;
    rand  bit[WUSER_WIDTH-1:0]   s_axi_wuser;
    rand  bit                    s_axi_wvalid;
     bit                    s_axi_wready;
     bit[ID_WIDTH-1:0]      s_axi_bid;
     bit[1:0]               s_axi_bresp;
     bit[BUSER_WIDTH-1:0]   s_axi_buser;
     bit                    s_axi_bvalid;
    rand  bit                    s_axi_bready;
    rand  bit[ID_WIDTH-1:0]      s_axi_arid;
    rand  bit[ADDR_WIDTH-1:0]    s_axi_araddr;
    rand  bit[7:0]               s_axi_arlen;
    rand  bit[2:0]               s_axi_arsize;
    rand  bit[1:0]               s_axi_arburst;
    rand  bit                    s_axi_arlock;
    rand  bit[3:0]               s_axi_arcache;
    rand  bit[2:0]               s_axi_arprot;
    rand  bit[3:0]               s_axi_arqos;
  rand  bit[3:0]               s_axi_arregion;
    rand  bit[ARUSER_WIDTH-1:0]  s_axi_aruser;
    rand  bit                    s_axi_arvalid;
     bit                    s_axi_arready;
     bit[ID_WIDTH-1:0]      s_axi_rid;
     bit[DATA_WIDTH-1:0]    s_axi_rdata;
     bit[1:0]               s_axi_rresp;
     bit                    s_axi_rlast;
     bit[RUSER_WIDTH-1:0]   s_axi_ruser;
     bit                    s_axi_rvalid;
    rand  bit                    s_axi_rready;

    /*
     * AXI master interface
     */
     bit[ID_WIDTH-1:0]      m_axi_awid;
     bit[ADDR_WIDTH-1:0]    m_axi_awaddr;
     bit[7:0]               m_axi_awlen;
     bit[2:0]               m_axi_awsize;
     bit[1:0]               m_axi_awburst;
     bit                    m_axi_awlock;
     bit[3:0]               m_axi_awcache;
     bit[2:0]               m_axi_awprot;
     bit[3:0]               m_axi_awqos;
  bit[3:0]               m_axi_awregion;
     bit[AWUSER_WIDTH-1:0]  m_axi_awuser;
     bit                    m_axi_awvalid;
    rand  bit                    m_axi_awready;
     bit[DATA_WIDTH-1:0]    m_axi_wdata;
     bit[STRB_WIDTH-1:0]    m_axi_wstrb;
     bit                    m_axi_wlast;
     bit[WUSER_WIDTH-1:0]   m_axi_wuser;
     bit                    m_axi_wvalid;
    rand  bit                    m_axi_wready;
    rand  bit[ID_WIDTH-1:0]      m_axi_bid;
    rand  bit[1:0]               m_axi_bresp;
    rand  bit[BUSER_WIDTH-1:0]   m_axi_buser;
    rand  bit                    m_axi_bvalid;
     bit                    m_axi_bready;
     bit[ID_WIDTH-1:0]      m_axi_arid;
     bit[ADDR_WIDTH-1:0]    m_axi_araddr;
     bit[7:0]               m_axi_arlen;
     bit[2:0]               m_axi_arsize;
     bit[1:0]               m_axi_arburst;
     bit                    m_axi_arlock;
     bit[3:0]               m_axi_arcache;
     bit[2:0]               m_axi_arprot;
     bit[3:0]               m_axi_arqos;
  bit[3:0]               m_axi_arregion;
     bit[ARUSER_WIDTH-1:0]  m_axi_aruser;
     bit                    m_axi_arvalid;
    rand  bit                    m_axi_arready;
    rand  bit[ID_WIDTH-1:0]      m_axi_rid;
    rand  bit[DATA_WIDTH-1:0]    m_axi_rdata;
    rand  bit[1:0]               m_axi_rresp;
    rand  bit                    m_axi_rlast;
    rand  bit[RUSER_WIDTH-1:0]   m_axi_ruser;
    rand  bit                    m_axi_rvalid;
     bit                    m_axi_rready;
  
  //---------------------------------------
  //Utility and Field macros
  //---------------------------------------
  `uvm_object_utils_begin(mem_seq_item)
//     `uvm_field_int(addr,UVM_ALL_ON)
    /*
     * AXI slave interface
     */
    `uvm_field_int(   s_axi_awid ,UVM_ALL_ON)
    `uvm_field_int(   s_axi_awaddr ,UVM_ALL_ON)
    `uvm_field_int(   s_axi_awlen ,UVM_ALL_ON)
    `uvm_field_int(   s_axi_awsize ,UVM_ALL_ON)
    `uvm_field_int(   s_axi_awburst ,UVM_ALL_ON)
    `uvm_field_int(   s_axi_awlock ,UVM_ALL_ON)
    `uvm_field_int(   s_axi_awcache ,UVM_ALL_ON)
    `uvm_field_int(   s_axi_awprot ,UVM_ALL_ON)
    `uvm_field_int(   s_axi_awqos ,UVM_ALL_ON)
    `uvm_field_int(   s_axi_awregion ,UVM_ALL_ON)
    `uvm_field_int(   s_axi_awuser ,UVM_ALL_ON)
    `uvm_field_int(    s_axi_awvalid ,UVM_ALL_ON)
    `uvm_field_int(   s_axi_wdata ,UVM_ALL_ON)
    `uvm_field_int(   s_axi_wstrb ,UVM_ALL_ON)
    `uvm_field_int(    s_axi_wlast ,UVM_ALL_ON)
    `uvm_field_int(   s_axi_wuser ,UVM_ALL_ON)
    `uvm_field_int(    s_axi_wvalid ,UVM_ALL_ON)
    `uvm_field_int(    s_axi_bready ,UVM_ALL_ON)
    `uvm_field_int(   s_axi_arid ,UVM_ALL_ON)
    `uvm_field_int(   s_axi_araddr ,UVM_ALL_ON)
    `uvm_field_int(   s_axi_arlen ,UVM_ALL_ON)
    `uvm_field_int(   s_axi_arsize ,UVM_ALL_ON)
    `uvm_field_int(   s_axi_arburst ,UVM_ALL_ON)
    `uvm_field_int(    s_axi_arlock ,UVM_ALL_ON)
    `uvm_field_int(   s_axi_arcache ,UVM_ALL_ON)
    `uvm_field_int(   s_axi_arprot ,UVM_ALL_ON)
    `uvm_field_int(   s_axi_arqos ,UVM_ALL_ON)
  `uvm_field_int(   s_axi_arregion ,UVM_ALL_ON)
    `uvm_field_int(   s_axi_aruser ,UVM_ALL_ON)
    `uvm_field_int(    s_axi_arvalid ,UVM_ALL_ON)
`uvm_field_int(    s_axi_rready ,UVM_ALL_ON)
`uvm_field_int(    m_axi_awready ,UVM_ALL_ON)
`uvm_field_int(    m_axi_wready ,UVM_ALL_ON)
    `uvm_field_int(  m_axi_bid ,UVM_ALL_ON)
    `uvm_field_int(   m_axi_bresp ,UVM_ALL_ON)
    `uvm_field_int(   m_axi_buser ,UVM_ALL_ON)
    `uvm_field_int(    m_axi_bvalid ,UVM_ALL_ON)
`uvm_field_int(    m_axi_arready ,UVM_ALL_ON)
    `uvm_field_int(   m_axi_rid ,UVM_ALL_ON)
    `uvm_field_int(   m_axi_rdata ,UVM_ALL_ON)
    `uvm_field_int(   m_axi_rresp ,UVM_ALL_ON)
    `uvm_field_int(    m_axi_rlast ,UVM_ALL_ON)
    `uvm_field_int(   m_axi_ruser ,UVM_ALL_ON)
    `uvm_field_int(    m_axi_rvalid ,UVM_ALL_ON)
  `uvm_object_utils_end
  
  //---------------------------------------
  //Constructor
  //---------------------------------------
  function new(string name = "mem_seq_item");
    super.new(name);
  endfunction
  
  
endclass