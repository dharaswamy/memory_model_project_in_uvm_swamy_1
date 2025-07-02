class wr_all_and_rd_all_test extends base_test;
  
  `uvm_component_utils(wr_all_and_rd_all_test)
  
  wr_all_rd_all wra_rda;
  
  function new(string name="wr_all_and_rd_all_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction:new
 
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    wra_rda=wr_all_rd_all::type_id::create("wra_rda");
    
  endfunction:build_phase
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    wra_rda.start(env.agt.seqr);
    phase.drop_objection(this);
     //set a drain-time for the environment if desired
   phase.phase_done.set_drain_time(this, 200);
  endtask:run_phase
  
endclass:wr_all_and_rd_all_test
                  
                 //+UVM_NO_RELNOTES