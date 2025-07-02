`define MNTR_IF vintf.monitor_modp.monitor_cb

//monitor class

class mem_monitor extends uvm_monitor;
  
  //factory registration
  `uvm_component_utils(mem_monitor)
  
  //virtual interface handle declaratio
  virtual mem_intf vintf;
  
  //transaction class handle
  mem_seq_item trans_collected;
  
  //uvm_analysis port declaration
  uvm_analysis_port #(mem_seq_item) item_collected_port;
  
  //default constructor
  function new(string name,uvm_component parent);
    super.new(name,parent);
    trans_collected=new();
   
  endfunction:new
  
  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     item_collected_port=new("item_collected_port",this);
    if(!uvm_config_db#(virtual mem_intf)::get(this, "", "mem_vintf", vintf))
      `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vintf"});
  endfunction:build_phase
       
    //run task
       virtual task run_phase(uvm_phase phase);
       forever begin:begin_forever
         capture();
         end:begin_forever
         
       endtask:run_phase
  
  
  virtual task capture();
    
   
           
          /* if(vintf.monitor_modp.rst == 1) begin:rst_high
             trans_collected.rst = vintf.monitor_modp.rst;
             //write method 
             item_collected_port.write(trans_collected);
     `uvm_info(get_full_name,$sformatf("MEM_MONITOR COLLECTED VLAUES  RESET MODE \n %0s",trans_collected.sprint()),UVM_NONE);
           end */
           
         //  if( vintf.monitor_modp.rst == 0) begin:rst_low
             //waiting for the either wr_en ==1 or rd_en == 1
             @(posedge vintf.monitor_modp.clk);
             @(negedge vintf.monitor_modp.clk);
            wait(`MNTR_IF.wr_en || `MNTR_IF.rd_en);
              
             trans_collected.addr = `MNTR_IF.addr;
             
               if(`MNTR_IF.wr_en) begin:write
              
               trans_collected.wr_en  = `MNTR_IF.wr_en;
               trans_collected.wdata = `MNTR_IF.wdata;
               trans_collected.rd_en = `MNTR_IF.rd_en;
               trans_collected.rst = `MNTR_IF.rst;
               item_collected_port.write(trans_collected);
               `uvm_info(get_full_name,$sformatf("MEM_MONITOR COLLECTED VLAUES  WRITE MODE \n %0s",trans_collected.sprint()),UVM_NONE);
             end:write
           
             if(`MNTR_IF.rd_en) begin:read
              //@(negedge vintf.monitor_modp.clk);
               trans_collected.rd_en = `MNTR_IF.rd_en;
               trans_collected.rst  =  `MNTR_IF.rst;
               @(posedge vintf.monitor_modp.clk);
               @(negedge vintf.monitor_modp.clk);
               trans_collected.wr_en = `MNTR_IF.wr_en;
               trans_collected.rdata = `MNTR_IF.rdata;
               item_collected_port.write(trans_collected);
               `uvm_info(get_full_name,$sformatf("MEM_MONITOR COLLECTED VLAUES  READ MODE \n %0s",trans_collected.sprint()),UVM_NONE);
             end:read
           
          // end:rst_low
           
 endtask:capture
    
endclass:mem_monitor
