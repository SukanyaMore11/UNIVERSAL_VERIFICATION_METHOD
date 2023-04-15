class mem_scoreboard extends uvm_scoreboard;
  
  parameter ADDR_WIDTH = 16;
  parameter VALID_ADDR_WIDTH = 14;
  parameter STRB_WIDTH = 4;
  parameter WORD_WIDTH = 4;
  parameter WORD_SIZE = 8;
  
  //---------------------------------------
  // declaring pkt_qu to store the pkt's recived from monitor
  //---------------------------------------
  mem_seq_item pkt_qu[$];
  
  //---------------------------------------
  // sc_mem 
  //---------------------------------------
  bit [31:0] sc_mem [16383:0];
  bit [13:0] valid_waddr_a;
  bit [13:0] valid_waddr_b;
  bit [13:0] valid_raddr_a;
  bit [13:0] valid_raddr_b;
  bit [31:0] read_data_a;
  bit [31:0] read_data_b;
  integer i, j, k, l;
  //---------------------------------------
  //port to recive packets from monitor
  //---------------------------------------
  uvm_analysis_imp#(mem_seq_item, mem_scoreboard) item_collected_export;
  uvm_analysis_imp#(mem_seq_item, mem_scoreboard) item_collected_export1;
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
    item_collected_export1 = new("item_collected_export1", this);
    foreach(sc_mem[i]) sc_mem[i] = 32'hFFFF;
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
    
    for (k = 0; k < 2**VALID_ADDR_WIDTH; k = k + 2**(VALID_ADDR_WIDTH/2)) begin
      for (l = i; l < k + 2**(VALID_ADDR_WIDTH/2); l = l + 1) begin
        sc_mem[l] = 0;
      end
    end      
    
    forever begin
      wait(pkt_qu.size() > 0);
      mem_pkt = pkt_qu.pop_front();
      
//       for (k = 0; k < 2**VALID_ADDR_WIDTH; k = k + 2**(VALID_ADDR_WIDTH/2)) begin
//         for (l = i; l < k + 2**(VALID_ADDR_WIDTH/2); l = l + 1) begin
//           sc_mem[l] = 0;
//         end
//       end      
      
      if(mem_pkt.s_axil_a_awvalid && mem_pkt.s_axil_a_wvalid) begin
        
        valid_waddr_a = mem_pkt.s_axil_a_awaddr >> (ADDR_WIDTH - VALID_ADDR_WIDTH);
        for (i = 0; i < WORD_WIDTH; i = i + 1) begin
          if (mem_pkt.s_axil_a_wstrb[i]) begin
            sc_mem[valid_waddr_a][WORD_SIZE*i +: WORD_SIZE] <= mem_pkt.s_axil_a_wdata[WORD_SIZE*i +: WORD_SIZE];
          end
        end
        
        `uvm_info(get_type_name(),$sformatf("------ :: WRITE DATA       :: ------"),UVM_LOW)
            `uvm_info(get_type_name(),$sformatf("Addr: %0h",mem_pkt.s_axil_a_awaddr),UVM_LOW)
            `uvm_info(get_type_name(),$sformatf("Valid Addr: %0h",valid_waddr_a),UVM_LOW) 
            `uvm_info(get_type_name(),$sformatf("Strobe: %0h",mem_pkt.s_axil_a_wstrb),UVM_LOW)        
            `uvm_info(get_type_name(),$sformatf("Write Data: %0h",mem_pkt.s_axil_a_wdata),UVM_LOW)
            `uvm_info(get_type_name(),$sformatf("Data Written in the valid address: %0h",sc_mem[valid_waddr_a]),UVM_LOW)
        `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)  
      end
          
      else if(mem_pkt.s_axil_a_arvalid) begin
        
        valid_raddr_a = mem_pkt.s_axil_a_araddr >> (ADDR_WIDTH - VALID_ADDR_WIDTH);
        read_data_a = sc_mem[valid_raddr_a];
        if(read_data_a == mem_pkt.s_axil_a_rdata) begin
          `uvm_info(get_type_name(),$sformatf("------ :: READ DATA Match_wrs :: ------"),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Valid Addr: %0h",valid_raddr_a),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",read_data_a,mem_pkt.s_axil_a_rdata),UVM_LOW)
          `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
        end
        else begin
          `uvm_error(get_type_name(),"------ :: READ DATA MisMatch :: ------")
          `uvm_info(get_type_name(),$sformatf("Valid Addr: %0h",valid_raddr_a),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",read_data_a,mem_pkt.s_axil_a_rdata),UVM_LOW)
          `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
        end
      end
      else begin
        `uvm_info(get_type_name(),$sformatf("Can't read and write at the same time from one Slave"),UVM_LOW)
      end
    end
    
    forever begin
      wait(pkt_qu.size() > 0);
      mem_pkt = pkt_qu.pop_front();
      
    if(mem_pkt.s_axil_b_awvalid && mem_pkt.s_axil_b_wvalid) begin
        
        valid_waddr_b = mem_pkt.s_axil_b_awaddr >> (ADDR_WIDTH - VALID_ADDR_WIDTH);
      for (j = 0; j < WORD_WIDTH; j = j + 1) begin
        if (mem_pkt.s_axil_b_wstrb[j]) begin
          sc_mem[valid_waddr_b][WORD_SIZE*j +: WORD_SIZE] <= mem_pkt.s_axil_b_wdata[WORD_SIZE*j +: WORD_SIZE];
          end
        end
        
        `uvm_info(get_type_name(),$sformatf("------ :: WRITE DATA       :: ------"),UVM_LOW)
      `uvm_info(get_type_name(),$sformatf("Addr: %0h",mem_pkt.s_axil_b_awaddr),UVM_LOW)
      `uvm_info(get_type_name(),$sformatf("Valid Addr: %0h",valid_waddr_b),UVM_LOW) 
      `uvm_info(get_type_name(),$sformatf("Strobe: %0h",mem_pkt.s_axil_b_wstrb),UVM_LOW)        
      `uvm_info(get_type_name(),$sformatf("Write Data: %0h",mem_pkt.s_axil_b_wdata),UVM_LOW)
            `uvm_info(get_type_name(),$sformatf("Data Written in the valid address: %0h",sc_mem[valid_waddr_b]),UVM_LOW)
        `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)  
      end
    
          
      else if(mem_pkt.s_axil_b_arvalid) begin
        
        valid_raddr_b = mem_pkt.s_axil_b_araddr >> (ADDR_WIDTH - VALID_ADDR_WIDTH);
        read_data_b = sc_mem[valid_raddr_b];
        if(read_data_b == mem_pkt.s_axil_b_rdata) begin
          `uvm_info(get_type_name(),$sformatf("------ :: READ DATA Match_wrs :: ------"),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Valid Addr: %0h",valid_raddr_b),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",read_data_b,mem_pkt.s_axil_b_rdata),UVM_LOW)
          `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
        end
        else begin
          `uvm_error(get_type_name(),"------ :: READ DATA MisMatch :: ------")
          `uvm_info(get_type_name(),$sformatf("Valid Addr: %0h",valid_raddr_b),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",read_data_b,mem_pkt.s_axil_b_rdata),UVM_LOW)
          `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
        end
      end
      else begin
        `uvm_info(get_type_name(),$sformatf("Can't read and write at the same time from one Slave"),UVM_LOW)
      end
    end
  endtask : run_phase
endclass : mem_scoreboard