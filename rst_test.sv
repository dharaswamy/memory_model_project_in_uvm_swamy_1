
class rst_test extends base_test;
  
  //factory registration
  `uvm_component_utils(rst_test)
  //rst sequence handle declaration
  rst_sequence  rst_sequ;
  
  function new(string name="rst_test",uvm_component parent);
    super.new(name,parent);
  endfunction:new
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rst_sequ=rst_sequence::type_id::create("rst_sequ");
  endfunction:build_phase
  
 virtual task run_phase(uvm_phase phase);
   
  super.run_phase(phase);
  phase.raise_objection(this);
  rst_sequ.start(env.agt.seqr);
  phase.drop_objection(this);
    //set a drain-time for the environment if desired
   phase.phase_done.set_drain_time(this, 200);
  endtask:run_phase
                                                
endclass:rst_test