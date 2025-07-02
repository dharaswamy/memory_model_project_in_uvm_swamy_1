
//agent class
typedef uvm_sequencer #(mem_seq_item) mem_sequencer;
class mem_agent extends uvm_agent;
  
  //factory registration
  `uvm_component_utils(mem_agent)
  
  //sequencer handle declaration
  mem_sequencer seqr;
  //driver handle declartion
  mem_driver driv;
  
  //mem_monitor handle declaration
  mem_monitor mntr;
  
  uvm_analysis_port#(mem_seq_item) item_collected_port;
  
  //config agent handle declartion
 // agent_config a_cfg;
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction:new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE",$sformatf("%m"),UVM_HIGH);
    mntr=mem_monitor::type_id::create("mntr",this);
   // if(a_cfg.is_active == UVM_ACTIVE) begin
      seqr=mem_sequencer::type_id::create("seqr",this);
      driv=mem_driver::type_id::create("driv",this);
   item_collected_port=new("item_collected_port",this);
   // end
  endfunction:build_phase
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TRACE",$sformatf("%m"),UVM_HIGH);
  //  if(a_cfg.is_active == UVM_ACTIVE ) begin
      driv.seq_item_port.connect(seqr.seq_item_export);
    mntr.item_collected_port.connect(item_collected_port);//here we are connecting the port of monitor to the analysis port of agent.
   // end
  endfunction:connect_phase
 
endclass:mem_agent