

class wr_followed_by_rd_test extends base_test;
 //factory registration
  `uvm_component_utils(wr_followed_by_rd_test);
  
  //write followed by read sequence handle declartion
   wr_f_rd_sequence  wr_f_rd;
  
  //default constructor
  function new(string name ="wr_followed_by_rd_test",uvm_component parent); 
    super.new(name,parent);
  endfunction:new
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    wr_f_rd= wr_f_rd_sequence::type_id::create("wr_f_rd",this);
  endfunction:build_phase
  
   virtual task  run_phase(uvm_phase phase);
    super.run_phase(phase);
    //phase.raise_objection(this);
   //  `uvm_info("\n"," -------------=============== wr_f_rd_test is started ================------------- ",UVM_NONE) // for without raise objection analysis
    wr_f_rd.start(env.agt.seqr);
  //   `uvm_info("\n"," -------------=============== wr_f_rd_test is ended ================------------- ",UVM_NONE) // for without raise objection analysis
    //phase.drop_objection(this);
    
    //set a drain-time for the environment if desired
  // phase.phase_done.set_drain_time(this, 100);
  endtask:run_phase  
  
  
  
endclass:wr_followed_by_rd_test