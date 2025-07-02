
//base test class
class base_test extends uvm_test;
  
  //factory registration
  `uvm_component_utils(base_test)
 // `uvm_field_int(item_count)
  //`uvm_component_utils_end
  
  //environment handle declaration
  mem_environment env;
  
  //base sequence handle declaration
// mem_base_sequence b_sequ;
  
  
   uvm_factory factory;
uvm_coreservice_t cs = uvm_coreservice_t::get();
  
  //int unsigned item_count;
  
 // wr_rd_sequence_f1 f1;
  //default constructor
  function new(string name="base_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction:new
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     uvm_config_db#(int )::set(null,"*","item_count",2);
 //  b_sequ=mem_base_sequence::type_id::create("b_sequ");
    
    env=mem_environment::type_id::create("env",this);
   
    endfunction:build_phase
  
 virtual function void end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  this.print();
  factory = cs.get_factory();
  factory.print();//it prints the factory registered components and objects
endfunction 
 
  //start_of_simulation_phase function
  virtual function void start_of_simulation_phase(uvm_phase phase);
super.start_of_simulation_phase(phase);
`uvm_info("TRACE",$sformatf("%m"),UVM_HIGH);
uvm_top.print_topology(); //it prints the topology of tb architechture its based on the testcase

endfunction:start_of_simulation_phase
  
 virtual task  run_phase(uvm_phase phase);
    super.run_phase(phase);
   // phase.raise_objection(this);
   // b_sequ.start(env.agt.seqr);
    //f1.start(env.agt.seqr);
   // phase.drop_objection(this);
    
    //set a drain-time for the environment if desired
  // phase.phase_done.set_drain_time(this, 200);
  endtask:run_phase  
  
  
  
endclass:base_test