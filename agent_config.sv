

//configuration of agent 

class agent_config extends uvm_object;
  
 //factory registration
`uvm_object_utils(agent_config)
  
  uvm_active_passive_enum is_active=UVM_ACTIVE;
  
  //default constructor
  function new(input string name="agent_config");
    super.new(name);
  endfunction:new
  
  
  
endclass:agent_config