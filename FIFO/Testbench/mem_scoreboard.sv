//--------------------------------------------
// UVM SCOREBOARD
//---------------------------------------------
class mem_scoreboard extends uvm_scoreboard;
  
  //---------------------------------------
  // declaring pkt_qu to store the pkt's recived from monitor
  //---------------------------------------
  mem_seq_item pkt_qu[$];
//   mem_seq_item scb_pkt;
  
  //---------------------------------------
  // sc_mem 
  //---------------------------------------
  bit[15:0]mem[3:0];
  bit [1:0]write_pointer;
  bit [1:0]read_pointer;
  bit[2:0] counter;
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
//     scb_pkt = new();
  endfunction : new
  //---------------------------------------
  // build_phase - create port and initialize local memory
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
      item_collected_export = new("item_collected_export", this);
    foreach(mem[i])begin
    mem[i] = 8'hff;
   end
  endfunction: build_phase
  
  //---------------------------------------
  // write task - recives the pkt from monitor and pushes into queue
  //---------------------------------------
  virtual function void write(mem_seq_item pkt);
    //pkt.print();
    pkt_qu.push_back(pkt);
//     scb_pkt.print();
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
//       $display("data coming from monitor: %d", mem_pkt);
      if(mem_pkt.w_en)begin
      if(counter==0 && mem_pkt.r_en==1) begin
        $display("Can't read and write in fifo");
      end
      else
        begin
          mem[write_pointer] = mem_pkt.din;
//           $display("Actual Din:%d", mem_pkt.din);
          $display("written data:%d", mem[write_pointer]);
          $display("write is done");
          $display("write_pointer=%d", write_pointer);
          write_pointer= write_pointer+1;
          counter = counter+1;
          $display("counter after write operation =%d", counter);
        end
    end  
    if(mem_pkt.r_en)begin
      $display("read_pointer=%0d", read_pointer);
      $display("counter after read operation =%d", counter);
      $display("Expected data:%d", mem[read_pointer]);
      $display("Actual data:%d", mem_pkt.dout);
      if(mem_pkt.dout == mem[read_pointer])begin
        $display("read is done");
        $display("read_pointer=%0d", read_pointer);
        read_pointer=read_pointer+1;
        counter=counter-1;
        $display("counter after read operation =%d", counter);
        
      end
      else begin
        $display("read data is not correct");
//         $display("read_pointer=%0d", read_pointer);
      end
    end
     
    if(mem_pkt.counter == counter )begin
      if(mem_pkt.full)begin
        $display("fifo is full");
      end
      if(mem_pkt.empty)begin
        $display("fifo is empty");
      end
       if(mem_pkt.half_full)begin
         $display("fifo is half_full");
      end
    end
       
    end
  endtask : run_phase
endclass : mem_scoreboard