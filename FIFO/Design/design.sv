module top_fifo(valid, w_en,r_en,din,rst,clk,full,empty,half_full,dout,counter,write_pointer, read_pointer  );
input bit w_en,r_en,clk,rst;
parameter N=16;
parameter M=32;
input  bit [N-1:0] din;
output bit [N-1:0] dout;
output bit full,empty,half_full;
bit [N-1:0]mem[M-1:0]; // declaring an unpacked 2D array 
output bit [4:0] write_pointer;
output bit [4:0] read_pointer;
output bit [5:0] counter;
input bit valid;

assign full=(counter==6'b100000);
assign empty=(counter==6'b000000);
assign half_full=(counter==6'b010000);

always_ff @(posedge clk)
begin
  if (valid)
    begin

      priority if(rst)  //active high reset
          begin
          counter<=6'b0;
          write_pointer<=5'b0;
          read_pointer<=5'b0;
          end

          else if ((!r_en)&(!w_en))
          begin
          counter<=counter; //when both read and write enable signals are inactive, counter remains the same
          end

          else if(6'b000000<counter && counter<6'b100000)
          begin

              if(r_en)
              begin
              counter=counter-6'b000001; //decrementing counter
              dout<=mem[read_pointer]; //reading from memory
              read_pointer<=read_pointer+5'b00001; //incrementing read pointer
              end

              if(w_en)
              begin
              counter=counter+6'b000001; //incrementing counter
              mem[write_pointer]<=din; //writing to memory
              write_pointer<=write_pointer+5'b00001; //incrementing write pointer
              end
          end
      
      



          else if(counter==6'b100000)
          begin
            assert(!w_en)
       		 begin
               if(r_en)begin
               $display("Only read can be performed");
               end
        	 end
            else $error("Can't write, memory is full");
              if (!w_en) //assert statement if write enable is active and counter is at maximum
              begin
              if(r_en) begin
                  counter<=counter-6'b00001;
                  dout<=mem[read_pointer];
                  read_pointer<=read_pointer+5'b00001;
                  end 
              end
//               else $error("Can't write, memory is full"); // we also see that this error is printed below in the Vivado Log when assert statement fails
          end

          else if(counter==6'b0)
          begin
            assert(!r_en)begin
              if(w_en)begin
                $display("Only write can be performed");
              end
            end
            else $error("Can't read, memory is empty");
            
              if (!r_en)  begin
              if(w_en) begin
                  counter<=counter+6'b000001;
                  mem[write_pointer]<=din;
                  write_pointer<=write_pointer+5'b00001;
                  end 
              end
//               else $error("Can't read, memory is empty");
          end
    end
      end
endmodule
