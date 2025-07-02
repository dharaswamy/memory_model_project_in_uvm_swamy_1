
// Eda link : https://edaplayground.com/x/LAcU 

// ( swamy ) please copy the code but don't change/modify the code here. 

// Note : file name changed to memory_model_project_in_uvm_swamy_1.sv from memory_model_project_in_uvm_swamy.sv(1)

//=================================================================================================================
// Project Name :  " memory model depth 4 and wide 8 bit in uvm based "

// i.uvm based project.
//=================================================================================================================

`include "uvm_macros.svh"
`include "tb_defines.sv"
`include "mem_intf.sv"
//`include "mem_seq_itm.sv"
`include "mem_seq_item.sv"
`include "mem_base_sequence.sv"
//`include "mem_sequencer.sv"
`include "mem_driver.sv"
`include "mem_monitor.sv"
//`include "agent_config.sv"
`include "mem_agent.sv"
`include "mem_scoreboard.sv"
`include "mem_functional_cg.sv"
`include "mem_environment.sv"
`include "base_test.sv"

`include "wr_all_and_rd_all_test.sv"
`include "wr_followed_by_rd_test.sv"
`include "rst_test.sv"
`include "rst_bw_wr_rd_test.sv"

module mem_testbench_top();
  
 import uvm_pkg::*; 
  
 bit clk;
  
  //interaface instaniation
  mem_intf vintf(clk);
  
  initial begin
    clk=0;
  //  rst=0;
    forever #5 clk=~clk;
  end
  
  //memory dut instantiation 
  memory mem1( .clk(vintf.clk),
               .reset(vintf.rst),
               .addr(vintf.addr),
               .wr_en(vintf.wr_en),
               .rd_en(vintf.rd_en),
               .wdata(vintf.wdata),
               .rdata(vintf.rdata)
              );
  
  
  initial begin
    uvm_config_db#(virtual mem_intf )::set(uvm_root::get(),"*","mem_vintf",vintf);
    run_test();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
   // #500 $finish;
  end
  
endmodule:mem_testbench_top