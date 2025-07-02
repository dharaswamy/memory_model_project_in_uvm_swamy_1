class mem_scoreboard extends uvm_scoreboard;
  

  //uvm analysis imp
  uvm_analysis_imp#(mem_seq_item,mem_scoreboard) item_collected_export ; 
  
  //taking one queue of transaction class handle
  mem_seq_item pkt_qu[$];
  
  //temporay memory
  reg [7:0] mem_reg[`MEM_DEPTH];
  
  //factory registration
  `uvm_component_utils(mem_scoreboard)
  
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
    endfunction:new
  
  //build_phase
  virtual function void build_phase(uvm_phase phase); 
    super.build_phase(phase);
    item_collected_export =new("item_collected_export",this);
    //default values
    foreach(mem_reg[i])
      mem_reg[i] = '1;
  endfunction:build_phase
  
  
  //write method implementation
  virtual function void write(mem_seq_item  pkt );
  //  `uvm_info(get_full_name(),$sformatf("%0s",pkt.sprint()),UVM_NONE);
    pkt_qu.push_back(pkt);
  endfunction:write
  
virtual task run_phase(uvm_phase phase);
  mem_seq_item mem_pkt;
  forever begin:begin_forever
  wait(pkt_qu.size() >0);
  mem_pkt = pkt_qu.pop_front();
  mem_compare(mem_pkt);
  end:begin_forever
endtask:run_phase
  
  
  virtual task mem_compare(mem_seq_item mem_pkt);
    //first we checking the rst high
    if(mem_pkt.rst == 1) begin:B_rst
      foreach(mem_reg[i])
        mem_reg[i] = '1;
    end:B_rst
    
    //second case we checking the rst low
    else begin:B_rst0
     //write operation
      if(mem_pkt.wr_en==1 && mem_pkt.rd_en ==0) begin:write
        mem_reg[mem_pkt.addr]= mem_pkt.wdata;
        `uvm_info(get_full_name(),"--MEM_SCB WRITE DATA--------",UVM_NONE);
        `uvm_info(get_full_name,$sformatf("\n MEM_SCB WRITE WDATA(H)=%0H WITH ADDR(H)=%0H WR_EN(b)=%B",mem_pkt.wdata,mem_pkt.addr,mem_pkt.wr_en),UVM_NONE);
        `uvm_info(get_full_name(),"--MEM_SCB WRITE DATA COMPLETED--------",UVM_NONE);
        
      end:write
      
      if(mem_pkt.rd_en ==1 && mem_pkt.wr_en ==0) begin:read
        if(mem_reg[mem_pkt.addr] == mem_pkt.rdata) begin:true_c
          `uvm_info(get_full_name(),"-------MEM_SCB REDA DATA MATCH-----",UVM_NONE);
          `uvm_info(get_full_name(),$sformatf(" \n TEST PASSED Actual value mem_pkt.rdata =%0h, Expected value mem_reg=%0h, mem_pkt.addr =%0h",mem_pkt.rdata,mem_reg[mem_pkt.addr],mem_pkt.addr),UVM_NONE)
        end:true_c
        else begin:false_c
          `uvm_error(get_full_name(),"-------MEM_SCB REDA DATA MISMATCH-----")
          `uvm_info(get_full_name(),$sformatf(" \n TEST FAILED Actual value mem_pkt.rdata =%0h ,Expected value mem_reg=%0h mem_pkt.addr =%0h",mem_pkt.rdata,mem_reg[mem_pkt.addr],mem_pkt.addr),UVM_NONE) 
        end:false_c
      end:read
    end:B_rst0
    
  endtask:mem_compare
  
  virtual function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    `uvm_info("\n","--------------Extract phase of mem_scoreboard -----------------",UVM_NONE);
  endfunction:extract_phase
  
  virtual function void check_phase(uvm_phase phase);
    super.check_phase(phase);
    `uvm_info("\n","--------------Check phase of mem_scoreboard -----------------",UVM_NONE);
  endfunction:check_phase
  
  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("\n","--------------Report phase of mem_scoreboard -----------------",UVM_NONE);
  endfunction:report_phase
  
  virtual function void final_phase(uvm_phase phase);
    super.final_phase(phase);
    `uvm_info("\n","--------------final phase of mem_scoreboard -----------------",UVM_NONE);
  endfunction:final_phase
  
endclass:mem_scoreboard