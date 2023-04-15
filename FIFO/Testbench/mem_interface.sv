//UVM INTERFACE
interface mem_if(input bit clk,rst);
  
  //declaring the signals
  bit valid;
  bit w_en, r_en;
  bit [15:0]din;
  bit [15:0]dout;
  bit full;
  bit empty;
  bit half_full;
  bit [5:0]counter;
  bit [4:0] write_pointer;
  bit [4:0] read_pointer;
  
endinterface