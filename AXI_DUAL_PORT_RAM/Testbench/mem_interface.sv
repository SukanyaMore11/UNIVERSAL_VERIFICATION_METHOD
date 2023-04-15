//------------------------------------------------
// UVM Interface
//------------------------------------------------
interface mem_if(input logic a_clk,a_rst,b_clk,b_rst);
  
  //---------------------------------------
  //declaring the signals
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
    logic [ADDR_WIDTH-1:0]  s_axil_a_awaddr;
    logic [2:0]             s_axil_a_awprot;
    logic                   s_axil_a_awvalid;
    logic                   s_axil_a_awready;
    logic [DATA_WIDTH-1:0]  s_axil_a_wdata;
    logic [STRB_WIDTH-1:0]  s_axil_a_wstrb;
    logic                   s_axil_a_wvalid;
    logic                   s_axil_a_wready;
    logic [1:0]             s_axil_a_bresp;
    logic                   s_axil_a_bvalid;
    logic                   s_axil_a_bready;
    logic [ADDR_WIDTH-1:0]  s_axil_a_araddr;
    logic [2:0]             s_axil_a_arprot;
    logic                   s_axil_a_arvalid;
    logic                   s_axil_a_arready;
    logic [DATA_WIDTH-1:0]  s_axil_a_rdata;
    logic [1:0]             s_axil_a_rresp;
    logic                   s_axil_a_rvalid;
    logic                   s_axil_a_rready;

    /*
     * AXI slave B interface
     */

    logic [ADDR_WIDTH-1:0]  s_axil_b_awaddr;
    logic [2:0]             s_axil_b_awprot;
    logic                   s_axil_b_awvalid;
    logic                   s_axil_b_awready;
    logic [DATA_WIDTH-1:0]  s_axil_b_wdata;
    logic [STRB_WIDTH-1:0]  s_axil_b_wstrb;
    logic                   s_axil_b_wvalid;
    logic                   s_axil_b_wready;
    logic [1:0]             s_axil_b_bresp;
    logic                   s_axil_b_bvalid;
    logic                   s_axil_b_bready;
    logic [ADDR_WIDTH-1:0]  s_axil_b_araddr;
    logic [2:0]             s_axil_b_arprot;
    logic                   s_axil_b_arvalid;
    logic                   s_axil_b_arready;
    logic [DATA_WIDTH-1:0]  s_axil_b_rdata;
    logic [1:0]             s_axil_b_rresp;
    logic                   s_axil_b_rvalid;
    logic                   s_axil_b_rready;
    
//   logic [5:0]                wr_ptr_reg_rd;
//   logic [5:0]                rd_ptr_reg_rd;
//   logic [5:0]                wr_ptr_reg_wr;
//   logic [5:0]                rd_ptr_reg_wr;
//   //---------------------------------------
//   //driver clocking block
//   //---------------------------------------
//   clocking driver_cb @(posedge clk);
//     default input #1 output #1;
    
//     /*
//      * AXI slave interface
//      */
//     input    s_axi_awid;
//     input    s_axi_awaddr;
//     input   s_axi_awlen;
//     input   s_axi_awsize;
//     input    s_axi_awburst;
//     input    s_axi_awlock;
//     input   s_axi_awcache;
//     input   s_axi_awprot;
//     input   s_axi_awqos;
//     input   s_axi_awregion;
//     input   s_axi_awuser;
//     input   s_axi_awvalid;
//     output  s_axi_awready;
//     input   s_axi_wdata;
//     input    s_axi_wstrb;
//     input    s_axi_wlast;
//     input   s_axi_wuser;
//     input   s_axi_wvalid;
//     output  s_axi_wready;
//     output   s_axi_bid;
//     output   s_axi_bresp;
//     output  s_axi_buser;
//     output  s_axi_bvalid;
//     input   s_axi_bready;
//     input    s_axi_arid;
//     input    s_axi_araddr;
//     input   s_axi_arlen;
//     input   s_axi_arsize;
//     input    s_axi_arburst;
//     input    s_axi_arlock;
//     input   s_axi_arcache;
//     input   s_axi_arprot;
//     input   s_axi_arqos;
//     input   s_axi_arregion;
//     input    s_axi_aruser;
//     input                       s_axi_arvalid;
//     output                      s_axi_arready;
//     output        s_axi_rid;
//     output  s_axi_rdata;
//     output   s_axi_rresp;
//     output                      s_axi_rlast;
//     output   s_axi_ruser;
//     output                      s_axi_rvalid;
//     input                       s_axi_rready;

//     /*
//      * AXI master interface
//      */
//     output        m_axi_awid;
//     output      m_axi_awaddr;
//     output  m_axi_awlen;
//     output  m_axi_awsize;
//     output   m_axi_awburst;
//     output                      m_axi_awlock;
//     output  m_axi_awcache;
//     output  m_axi_awprot;
//     output  m_axi_awqos;
//     output  m_axi_awregion;
//     output  m_axi_awuser;
//     output                      m_axi_awvalid;
//     input                       m_axi_awready;
//     output  m_axi_wdata;
//     output   m_axi_wstrb;
//     output                      m_axi_wlast;
//     output  m_axi_wuser;
//     output                      m_axi_wvalid;
//     input                       m_axi_wready;
//     input         m_axi_bid;
//     input    m_axi_bresp;
//     input   m_axi_buser;
//     input                       m_axi_bvalid;
//     output                      m_axi_bready;
//     output        m_axi_arid;
//     output      m_axi_araddr;
//     output  m_axi_arlen;
//     output  m_axi_arsize;
//     output   m_axi_arburst;
//     output                      m_axi_arlock;
//     output  m_axi_arcache;
//     output  m_axi_arprot;
//     output  m_axi_arqos;
//     output  m_axi_arregion;
//     output   m_axi_aruser;
//     output                      m_axi_arvalid;
//     input                       m_axi_arready;
//     input         m_axi_rid;
//     input   m_axi_rdata;
//     input    m_axi_rresp;
//     input                       m_axi_rlast;
//     input    m_axi_ruser;
//     input                       m_axi_rvalid;
//     output                      m_axi_rready;
    
//     output  wr_ptr_reg_rd;
//     output  rd_ptr_reg_rd;
//     output  wr_ptr_reg_wr;
//     output  rd_ptr_reg_wr; 
//   endclocking
  
//   //---------------------------------------
//   //monitor clocking block
//   //---------------------------------------
//   clocking monitor_cb @(posedge clk);
//     default input #1 output #1;
    

//     /*
//      * AXI slave interface
//      */
//     input    s_axi_awid;
//     input    s_axi_awaddr;
//     input   s_axi_awlen;
//     input   s_axi_awsize;
//     input    s_axi_awburst;
//     input    s_axi_awlock;
//     input   s_axi_awcache;
//     input   s_axi_awprot;
//     input   s_axi_awqos;
//     input   s_axi_awregion;
//     input   s_axi_awuser;
//     input   s_axi_awvalid;
//     output  s_axi_awready;
//     input   s_axi_wdata;
//     input    s_axi_wstrb;
//     input    s_axi_wlast;
//     input   s_axi_wuser;
//     input   s_axi_wvalid;
//     output  s_axi_wready;
//     output   s_axi_bid;
//     output   s_axi_bresp;
//     output  s_axi_buser;
//     output  s_axi_bvalid;
//     input   s_axi_bready;
//     input    s_axi_arid;
//     input    s_axi_araddr;
//     input   s_axi_arlen;
//     input   s_axi_arsize;
//     input    s_axi_arburst;
//     input    s_axi_arlock;
//     input   s_axi_arcache;
//     input   s_axi_arprot;
//     input   s_axi_arqos;
//     input   s_axi_arregion;
//     input    s_axi_aruser;
//     input                       s_axi_arvalid;
//     output                      s_axi_arready;
//     output        s_axi_rid;
//     output  s_axi_rdata;
//     output   s_axi_rresp;
//     output                      s_axi_rlast;
//     output   s_axi_ruser;
//     output                      s_axi_rvalid;
//     input                       s_axi_rready;

//     /*
//      * AXI master interface
//      */
//     output        m_axi_awid;
//     output      m_axi_awaddr;
//     output  m_axi_awlen;
//     output  m_axi_awsize;
//     output   m_axi_awburst;
//     output                      m_axi_awlock;
//     output  m_axi_awcache;
//     output  m_axi_awprot;
//     output  m_axi_awqos;
//     output  m_axi_awregion;
//     output  m_axi_awuser;
//     output                      m_axi_awvalid;
//     input                       m_axi_awready;
//     output  m_axi_wdata;
//     output   m_axi_wstrb;
//     output                      m_axi_wlast;
//     output  m_axi_wuser;
//     output                      m_axi_wvalid;
//     input                       m_axi_wready;
//     input         m_axi_bid;
//     input    m_axi_bresp;
//     input   m_axi_buser;
//     input                       m_axi_bvalid;
//     output                      m_axi_bready;
//     output        m_axi_arid;
//     output      m_axi_araddr;
//     output  m_axi_arlen;
//     output  m_axi_arsize;
//     output   m_axi_arburst;
//     output                      m_axi_arlock;
//     output  m_axi_arcache;
//     output  m_axi_arprot;
//     output  m_axi_arqos;
//     output  m_axi_arregion;
//     output   m_axi_aruser;
//     output                      m_axi_arvalid;
//     input                       m_axi_arready;
//     input         m_axi_rid;
//     input   m_axi_rdata;
//     input    m_axi_rresp;
//     input                       m_axi_rlast;
//     input    m_axi_ruser;
//     input                       m_axi_rvalid;
//     output                      m_axi_rready;
    
//     output  wr_ptr_reg_rd;
//     output  rd_ptr_reg_rd;
//     output  wr_ptr_reg_wr;
//     output  rd_ptr_reg_wr; 
//   endclocking
  
//   //---------------------------------------
//   //driver modport
//   //---------------------------------------
//   modport DRIVER  (clocking driver_cb,input clk,reset);
  
//   //---------------------------------------
//   //monitor modport  
//   //---------------------------------------
//   modport MONITOR (clocking monitor_cb,input clk,reset);
  
endinterface