//sequencer class

class mem_sequencer extends uvm_sequencer#(mem_seq_itm);
  
//factory registration
  `uvm_component_utils(mem_sequencer)
  
  //default sequencer
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction:new
  
  
  
endclass:mem_sequencer