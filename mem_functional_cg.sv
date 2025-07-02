//functional coverage class.user defined functional coverage class extends from uvm_subscriber class.
//and uvm_subscriber class is parametrized with the transaction class.

class mem_functional_cg extends uvm_subscriber#(mem_seq_item);
  
  //factory registration
  `uvm_component_utils(mem_functional_cg)
  
  //uvm analysis imp declaration
  uvm_analysis_imp#(mem_seq_item,mem_functional_cg) item_collected_export;
  
  mem_seq_item pkt;
  
  //default constructor
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction:new
  
  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export=new("item_collected_export",this);
  endfunction:build_phase
  
  //write method implementation in the this mem_function_cg class
  virtual function void write(mem_seq_item pkt);
  //  `uvm_info(get_full_name(),$sformatf("%0s",pkt.sprint()),UVM_NONE);
  endfunction:write
  
  // this covergroup covers the wr_en,rd_en,
//   covergroup mem_cgp(input string inst_name);
    
//     // coverage options.
//     option.name = inst_name;
//     option.per_instance = 1;
    
//     wr_en_covp      :  coverpoint wr_en;
//     rd_en_covp      :  coverpoint rd_en;
//     addr_covp       :  coverpoint addr;
//     wr_rd_addr_cross:  cross wr_en_covp,rd_en_covp,addr_covp;
//     wdata_covp      :  coverpoint wdata;
//     rdata_covp      :  coverpoint rdata;
    
//   endgroup:mem_cgp
  
  
endclass:mem_functional_cg



//  //rand fields 
//   rand bit [1:0] addr;
//   rand bit  wr_en;
//   rand bit rd_en;
//   rand bit [7:0] wdata;
//   rand bit rst ;
  
  
//   //analysis fields
//   bit [7:0] rdata;