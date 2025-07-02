
//interface declaration for the memory model

interface mem_intf(input logic clk);
  
  logic [1:0] addr;
  logic wr_en;
  logic rd_en;
  logic [7:0]  wdata;
  logic [7:0] rdata;
  logic rst;
  
  //clocking block for the driver
  clocking driver_cb@(posedge clk);
   default input #1 output #0 ;
    
    output addr;
    output wr_en;
    output rd_en;
    output wdata;
    output rst;
    
    input rdata;
    
  endclocking:driver_cb
  
  //clocking block for the monitor
  clocking monitor_cb@(posedge clk);
  default input #1 output #1;
  
    input addr;
    input wr_en;
    input rd_en;
    input wdata;
    input rdata;
    input rst;
  endclocking:monitor_cb
  
  //modport for the driver 
  modport driver_modp(clocking driver_cb,input clk);
  //modport for the monitor
    modport monitor_modp(clocking monitor_cb,input clk,rst);
  
  
endinterface:mem_intf