`define DRIV_IF vif.driver_modp.driver_cb

class mem_driver extends uvm_driver #(mem_seq_item);

  //--------------------------------------- 
  // Virtual Interface
  //--------------------------------------- 
  virtual mem_intf vif;
  `uvm_component_utils(mem_driver)
    
  //--------------------------------------- 
  // Constructor
  //--------------------------------------- 
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //--------------------------------------- 
  // build phase
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual mem_intf)::get(this, "", "mem_vintf", vif))
       `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction: build_phase

  //---------------------------------------  
  // run phase
  //---------------------------------------  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
     forever begin
       //  phase.raise_objection(this); 
     seq_item_port.get_next_item(req);
       // `uvm_info("\n"," ============= mem_driver afer get_next_item =========",UVM_NONE) // for without raise objection in test analysis
      drive();
       // `uvm_info("\n"," ============= mem_driver afer drive task =========",UVM_NONE) // for without raise objection in test analysis
      `uvm_info("DRIV_RUN",$sformatf("\n DRIVER SEN THE STIMULUS TO DUT \n  %0s",req.sprint),UVM_NONE)
      seq_item_port.item_done(req);
     //  phase.drop_objection(this);
    end
  endtask : run_phase
  
  //---------------------------------------
  // drive - transaction level to signal level
  // drives the value's from seq_item to interface signals
  //---------------------------------------
  virtual task drive();
  //  `uvm_info("\n"," ============= mem_driver entered in to the dirve task =========",UVM_NONE) /// for without raise objection in test analysis

   @(posedge vif.driver_modp.clk);
    `uvm_info("\n"," ============= mem_driver entered dirve task and after posedge of clock =========",UVM_NONE)
   //@(`DRIV_IF);
    //@(negedge vif.driver_modp.clk);
     `DRIV_IF.addr <= req.addr;
    
   /* if(req.rst == 1) begin:reset_high
      `uvm_info(get_full_name," DRIVER DRIVES THE RESET IS HIGH ",UVM_NONE);
      `DRIV_IF.rst <= req.rst;
      `DRIV_IF.wr_en <= req.wr_en;
      `DRIV_IF.wdata <= req.wdata;
      `DRIV_IF.rd_en <= req.rd_en;
    end:reset_high */
    
   
    
   //if(req.rst == 0) begin:reset_low
      if(req.wr_en) begin // write operation
      `DRIV_IF.rst <= req.rst;
      `DRIV_IF.wr_en <= req.wr_en;
      `DRIV_IF.wdata <= req.wdata;
      `DRIV_IF.rd_en <= req.rd_en; 
      end
      if(req.rd_en) begin //read operation
        `DRIV_IF.rst <= req.rst;
        `DRIV_IF.rd_en <= req.rd_en;
        `DRIV_IF.rst <= req.rst;
        `DRIV_IF.wr_en <= req.wr_en;
        @(posedge vif.driver_modp.clk);
       `DRIV_IF.rd_en <= 0;
       `DRIV_IF.wr_en <= 0;
        end
       //end:reset_low
      endtask : drive
  
endclass : mem_driver


/*//driver class for the memory
`define DRIV_IF vif.driver_modp.driver_cb;

class mem_driver extends uvm_driver#(mem_seq_item);
  //factory registration
  `uvm_component_utils(mem_driver)
  
  //interface handle declaration
  virtual mem_intf vif;
  
  //default constructor
  function new(input string name,uvm_component parent);
    super.new(name,parent);
  endfunction:new
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //config db get method
    if(!uvm_config_db#(virtual mem_intf)::get(this,"","mem_vif",vif))
    `uvm_fatal(get_full_name()," THERE IS NO SET METHOD OF \" mem_vif \" so first set the mem_vif");
  endfunction:build_phase
  
  
virtual task run_phase(uvm_phase phase);
  // super.run_phase(phase);
  //req=mem_seq_item::type_id::create("req");
  repeat(1) begin
  
   start_item_port.get_next_item(req);
   `uvm_info("DRIVE_RUN",{"\n",req.sprint()},UVM_NONE);
   // drive();
    start_item_port.item_done(req);
  end
endtask:run_phase
  
  //drive task for driving signals to dut 
     task drive();
    @(posedge vif.driver_modp.clk);
      `DRIV_IF.wr_en <= req.wr_en;
      `DRIV_IF.rd_en <= req.rd_en;
      `DRIV_IF.addr  <= req.addr;
      `DRIV_IF.wdata <= req.wdata;
      
      if( req.rd_en==1) begin
      @(posedge vif.driver_modp.clk);
      end
    endtask:drive  
    
    
endclass:mem_driver*/