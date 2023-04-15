// UVM SCOREBOARD
class mem_scoreboard extends uvm_scoreboard;
  
  //---------------------------------------
  // declaring pkt_qu to store the pkt's recived from monitor
  //---------------------------------------
  mem_seq_item pkt_qu[$];
  
  //---------------------------------------
  // DUMMY MEMORY AND READ, WRITE POINTERS
  //---------------------------------------
  bit [31:0] sc_mem_wr [31:0];
  bit [31:0] sc_mem_rd [31:0];
  bit [5:0] wr_ptr_reg_wr;
  bit [5:0] wr_ptr_reg_rd;
  bit [5:0] rd_ptr_reg_wr;
  bit [5:0] rd_ptr_reg_rd;
  //---------------------------------------
  //port to recive packets from monitor
  //---------------------------------------
  uvm_analysis_imp#(mem_seq_item, mem_scoreboard) item_collected_export;
  `uvm_component_utils(mem_scoreboard)

  //---------------------------------------
  // new - constructor
  //---------------------------------------
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  //---------------------------------------
  // build_phase - create port and initialize local memory
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
      item_collected_export = new("item_collected_export", this);
    foreach(sc_mem_wr[i]) sc_mem_wr[i] = 32'hFFFF;
    foreach(sc_mem_rd[i]) sc_mem_rd[i] = 32'hFFFF;
  endfunction: build_phase
  
  //---------------------------------------
  // write task - recives the pkt from monitor and pushes into queue
  //---------------------------------------
  virtual function void write(mem_seq_item pkt);
    //pkt.print();
    pkt_qu.push_back(pkt);
  endfunction : write

  //---------------------------------------
  // run_phase - compare's the read data with the expected data(stored in local memory)
  // local memory will be updated on the write operation.
  //---------------------------------------
  virtual task run_phase(uvm_phase phase);
    mem_seq_item mem_pkt;
    
    forever begin
      wait(pkt_qu.size() > 0);
      mem_pkt = pkt_qu.pop_front();
//--------------------------------------------
// WHEN WRITE SIGNAL TO DESIGN IS ONE THEN WRITE THE INPUT DATA INTO DUMMY MEMORY //----------------------------------------------     
      if(mem_pkt.s_axi_wvalid) begin
        
        sc_mem_wr[wr_ptr_reg_wr] = mem_pkt.s_axi_wdata;
        wr_ptr_reg_wr = wr_ptr_reg_wr +1;
        `uvm_info(get_type_name(),$sformatf("------ :: WRITE DATA       :: ------"),UVM_LOW)
        `uvm_info(get_type_name(),$sformatf("Addr: %0h",wr_ptr_reg_wr),UVM_LOW)
        `uvm_info(get_type_name(),$sformatf("Data: %0h",mem_pkt.s_axi_wdata),UVM_LOW)
        `uvm_info(get_type_name(),"------------------------------------",UVM_LOW) //------------------------------------
// WHEN READ ENABLE SIGNAL IS ONE THEN READ THE DATA FROM DUMMY MEMORY
//---------------------------------------        
      end
      if(mem_pkt.m_axi_wready) begin
        $display("m_axi_rready_wr=%h", mem_pkt.m_axi_rready);
        rd_ptr_reg_wr = rd_ptr_reg_wr+1;
        // CHECK WHETHER THE OUT DATA FROM DUMMY MEMORY AND DESIGN IS EQUAL OR NOT
        if(sc_mem_wr[rd_ptr_reg_wr] == mem_pkt.m_axi_wdata) begin
          `uvm_info(get_type_name(),$sformatf("------ :: READ DATA Match_wrs :: ------"),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Addr: %0h",rd_ptr_reg_wr),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",sc_mem_wr[rd_ptr_reg_wr],mem_pkt.m_axi_wdata),UVM_LOW)
          `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
        end
        // IF READ DATA IS NOT EQUAL TO THE DUMMY MEMORY DATA THEN THROW AN ERROR
        else begin
          `uvm_error(get_type_name(),"------ :: READ DATA MisMatch :: ------")
          `uvm_info(get_type_name(),$sformatf("Addr: %0h",rd_ptr_reg_wr),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",sc_mem_wr[rd_ptr_reg_wr],mem_pkt.m_axi_wdata),UVM_LOW)
          `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
        end
      end
    end
//--------------------------------------------------------------
// SAME LOGIC AS ABOVE
//--------------------------------------------------------------
    forever begin
      wait(pkt_qu.size() > 0);
      mem_pkt = pkt_qu.pop_front();
      
      if(mem_pkt.m_axi_rvalid) begin
        sc_mem_rd[wr_ptr_reg_rd] = mem_pkt.m_axi_rdata;
        wr_ptr_reg_rd = wr_ptr_reg_rd+1;
        `uvm_info(get_type_name(),$sformatf("------ :: WRITE DATA       :: ------"),UVM_LOW)
        `uvm_info(get_type_name(),$sformatf("Addr: %0h",wr_ptr_reg_rd),UVM_LOW)
        `uvm_info(get_type_name(),$sformatf("Data: %0h",mem_pkt.m_axi_rdata),UVM_LOW)
        `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)        
      end
      if(mem_pkt.m_axi_rready) begin
        rd_ptr_reg_rd = rd_ptr_reg_rd +1;
        $display("m_axi_rready_rd=%h", mem_pkt.m_axi_rready);
        if(sc_mem_rd[rd_ptr_reg_rd] == mem_pkt.s_axi_rdata) begin
          `uvm_info(get_type_name(),$sformatf("------ :: READ DATA Match_rd :: ------"),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Addr: %0h",rd_ptr_reg_rd),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",sc_mem_rd[rd_ptr_reg_rd],mem_pkt.s_axi_rdata),UVM_LOW)
          `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
        end
        else begin
          `uvm_error(get_type_name(),"------ :: READ DATA MisMatch :: ------")
          `uvm_info(get_type_name(),$sformatf("Addr: %0h",rd_ptr_reg_rd),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",sc_mem_rd[rd_ptr_reg_rd],mem_pkt.s_axi_rdata),UVM_LOW)
          `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
        end
      end
    end
  endtask : run_phase
endclass : mem_scoreboard