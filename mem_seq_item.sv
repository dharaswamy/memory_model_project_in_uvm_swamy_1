//transaction class for momory model

class mem_seq_item extends uvm_sequence_item;
  //rand fields 
  rand bit [1:0] addr;
  rand bit  wr_en;
  rand bit rd_en;
  rand bit [7:0] wdata;
  rand bit rst ;
  
  
  //analysis fields
  bit [7:0] rdata;
  
  //default constructor
  function new( string name="mem_seq_item");
    super.new(name);
  endfunction:new
  
  
 //factory registration 
  `uvm_object_utils_begin(mem_seq_item)
  `uvm_field_int(addr,UVM_ALL_ON)
  `uvm_field_int(wr_en,UVM_ALL_ON)
  `uvm_field_int(rd_en,UVM_ALL_ON)
  `uvm_field_int(wdata,UVM_ALL_ON)
  `uvm_field_int(rdata,UVM_ALL_ON)
  `uvm_field_int(rst,UVM_ALL_ON)
  `uvm_object_utils_end 
  
  /* //factory registration 
  `uvm_object_utils_begin(mem_seq_itm)
  `uvm_field_int(addr,UVM_ALL_ON + UVM_DEC)
  `uvm_field_int(wr_en,UVM_ALL_ON + UVM_BIN)
  `uvm_field_int(rd_en,UVM_ALL_ON + UVM_BIN)
  `uvm_field_int(wdata,UVM_ALL_ON + UVM_DEC)
  `uvm_object_utils_end  */
  
  constraint wr_en_rd_en_uneql_cons{ wr_en != rd_en;};
  constraint rst_const{soft rst==0;}
  
  function string display();
    $sformat(display," wr_en=%0b rd_en=%0b addr=%0d wdata=%0d rdata=%0d",wr_en,rd_en,addr,wdata,rdata);
  endfunction:display
  
endclass:mem_seq_item