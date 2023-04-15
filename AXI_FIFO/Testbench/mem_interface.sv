//UVM INTERFACE
interface mem_if(input logic clk,reset);
  
  //---------------------------------------
  //declaring the signals
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
      logic [ID_WIDTH-1:0]      s_axi_awid;
      logic [ADDR_WIDTH-1:0]    s_axi_awaddr;
      logic [7:0]               s_axi_awlen;
      logic [2:0]               s_axi_awsize;
      logic [1:0]               s_axi_awburst;
      logic                    s_axi_awlock;
      logic [3:0]               s_axi_awcache;
      logic [2:0]               s_axi_awprot;
      logic [3:0]               s_axi_awqos;
  logic [3:0]               s_axi_awregion;
      logic[AWUSER_WIDTH-1:0]  s_axi_awuser;
      logic                    s_axi_awvalid;
     logic                    s_axi_awready;
      logic[DATA_WIDTH-1:0]    s_axi_wdata;
      logic[STRB_WIDTH-1:0]    s_axi_wstrb;
      logic                    s_axi_wlast;
      logic[WUSER_WIDTH-1:0]   s_axi_wuser;
      logic                    s_axi_wvalid;
     logic                    s_axi_wready;
     logic[ID_WIDTH-1:0]      s_axi_bid;
     logic[1:0]               s_axi_bresp;
     logic[BUSER_WIDTH-1:0]   s_axi_buser;
     logic                    s_axi_bvalid;
      logic                    s_axi_bready;
      logic[ID_WIDTH-1:0]      s_axi_arid;
      logic[ADDR_WIDTH-1:0]    s_axi_araddr;
      logic[7:0]               s_axi_arlen;
      logic[2:0]               s_axi_arsize;
      logic[1:0]               s_axi_arburst;
      logic                    s_axi_arlock;
      logic[3:0]               s_axi_arcache;
      logic[2:0]               s_axi_arprot;
      logic[3:0]               s_axi_arqos;
  logic[3:0]               s_axi_arregion;
      logic[ARUSER_WIDTH-1:0]  s_axi_aruser;
      logic                    s_axi_arvalid;
     logic                    s_axi_arready;
     logic[ID_WIDTH-1:0]      s_axi_rid;
     logic[DATA_WIDTH-1:0]    s_axi_rdata;
     logic[1:0]               s_axi_rresp;
     logic                    s_axi_rlast;
     logic[RUSER_WIDTH-1:0]   s_axi_ruser;
     logic                    s_axi_rvalid;
      logic                    s_axi_rready;

    /*
     * AXI master interface
     */
     logic[ID_WIDTH-1:0]      m_axi_awid;
     logic[ADDR_WIDTH-1:0]    m_axi_awaddr;
     logic[7:0]               m_axi_awlen;
     logic[2:0]               m_axi_awsize;
     logic[1:0]               m_axi_awburst;
     logic                    m_axi_awlock;
     logic[3:0]               m_axi_awcache;
     logic[2:0]               m_axi_awprot;
     logic[3:0]               m_axi_awqos;
  logic[3:0]               m_axi_awregion;
     logic[AWUSER_WIDTH-1:0]  m_axi_awuser;
     logic                    m_axi_awvalid;
      logic                    m_axi_awready;
     logic[DATA_WIDTH-1:0]    m_axi_wdata;
     logic[STRB_WIDTH-1:0]    m_axi_wstrb;
     logic                    m_axi_wlast;
     logic[WUSER_WIDTH-1:0]   m_axi_wuser;
     logic                    m_axi_wvalid;
      logic                    m_axi_wready;
      logic[ID_WIDTH-1:0]      m_axi_bid;
      logic[1:0]               m_axi_bresp;
      logic[BUSER_WIDTH-1:0]   m_axi_buser;
      logic                    m_axi_bvalid;
     logic                    m_axi_bready;
     logic[ID_WIDTH-1:0]      m_axi_arid;
     logic[ADDR_WIDTH-1:0]    m_axi_araddr;
     logic[7:0]               m_axi_arlen;
     logic[2:0]               m_axi_arsize;
     logic[1:0]               m_axi_arburst;
     logic                    m_axi_arlock;
     logic[3:0]               m_axi_arcache;
     logic[2:0]               m_axi_arprot;
     logic[3:0]               m_axi_arqos;
  logic[3:0]               m_axi_arregion;
     logic[ARUSER_WIDTH-1:0]  m_axi_aruser;
     logic                    m_axi_arvalid;
      logic                    m_axi_arready;
      logic[ID_WIDTH-1:0]      m_axi_rid;
      logic[DATA_WIDTH-1:0]    m_axi_rdata;
      logic[1:0]               m_axi_rresp;
      logic                    m_axi_rlast;
      logic[RUSER_WIDTH-1:0]   m_axi_ruser;
      logic                    m_axi_rvalid;
     logic                    m_axi_rready;
  
endinterface