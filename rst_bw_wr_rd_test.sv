
class rst_bw_wr_rd_test extends base_test;

  //factory registration
  `uvm_component_utils(rst_bw_wr_rd_test)
  
rst_bw_wr_rd_sequence rst_b_wr_rd;
  
  //default constructor
  function new(string name = "rst_bw_wr_rd_sequence",uvm_component parent);
    super.new(name,parent);
  endfunction:new
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rst_b_wr_rd=rst_bw_wr_rd_sequence::type_id::create("rst_b_wr_rd");
  endfunction:build_phase
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
     phase.raise_objection(this);
    rst_b_wr_rd.start(env.agt.seqr);
    phase.drop_objection(this);
     //set a drain-time for the environment if desired
   phase.phase_done.set_drain_time(this, 200);
  endtask:run_phase
  
endclass:rst_bw_wr_rd_test