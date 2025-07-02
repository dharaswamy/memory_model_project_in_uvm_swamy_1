

//environment class
class mem_environment extends uvm_env;
  
//factory registration
`uvm_component_utils(mem_environment)

//mem_agent class handle declaration
mem_agent agt;
  
//mem_scoreboard class handle declaration
  mem_scoreboard mem_scb;
  
//mem_functional_cg class handle declartion.
  mem_functional_cg mem_fcg;
  
//default constructor
  function new(input string name,uvm_component parent);
    super.new(name,parent);
  endfunction:new
  
  virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    agt=mem_agent::type_id::create("agt",this);
    mem_scb=mem_scoreboard::type_id::create("mem_scb",this);
    mem_fcg =mem_functional_cg::type_id::create("mem_fcg",this);
  endfunction:build_phase
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agt.item_collected_port.connect(mem_scb.item_collected_export);//scb export is connected to agent analysis port because agent analysis port is connected to the mntr analysis port.so this model also we use.or you connect to mntr analysis port also see below commentend line.
//agt.mntr.item_collected_port.connect(mem_scb_item_collected_export);
    agt.mntr.item_collected_port.connect(mem_fcg.item_collected_export);
  endfunction:connect_phase
  
endclass:mem_environment