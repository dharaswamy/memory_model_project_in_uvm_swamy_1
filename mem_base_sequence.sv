
// base sequence class 
class mem_base_sequence extends uvm_sequence#(mem_seq_item);
  
 
  //factory registration
  `uvm_object_utils(mem_base_sequence)

  
  //default constructor
  function new( string name="mem_base_sequence");
    super.new(name);
  endfunction:new
 

 //body task
  virtual task body();
    req=mem_seq_item::type_id::create("req");
    repeat(1) begin
     
     
     start_item(req);
      assert(req.randomize() with{wr_en==1;addr==1;}) //or assert(req.randomize with{re.wr_en == 1 ; req.addr = 1;} this is also working verified.
      else begin
      `uvm_fatal("FATAL","RANDOMIZATION FAILED");
        end
     // req.print();
      finish_item(req);
    end
      
  endtask:body
  
  
endclass:mem_base_sequence
////////////////////////////////////////////////////
////////////////////////////////////////////////


class write_sequence extends uvm_sequence #(mem_seq_item);
 //factory registration
  `uvm_object_utils(write_sequence)

  
  //default constructor
  function new( string name="write_sequence");
    super.new(name);
  endfunction:new
 

 //body task
  virtual task body();
    
   
    req=mem_seq_item::type_id::create("req");
  
     start_item(req);
    assert(req.randomize with{wr_en==1;})
    else begin
    `uvm_fatal("FATAL","RANDOMIZATION FAILED");
    end
      req.print();
      finish_item(req);
 
      
  endtask:body
  
endclass:write_sequence

  ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////

class read_sequence extends uvm_sequence #(mem_seq_item);
 //factory registration
  `uvm_object_utils(read_sequence)

  
  //default constructor
  function new( string name="read_sequence");
    super.new(name);
  endfunction:new
 

 //body task
  virtual task body();
   
    repeat(1) begin
     req=mem_seq_item::type_id::create("req");
      start_item(req);
      assert( req.randomize with{req.wr_en==0;})
      else begin
        `uvm_fatal("FATAL","RANDOMIZATION FAILED");
      end
      req.print();
      finish_item(req);
    end
      
  endtask:body
    
endclass:read_sequence
  ///////////////////////////////////////////////////
//////////////////////////////////////////////////////////////

//test_case:sequence for write to any memory location, read from the same memory location, read data should be the same as written data

  class wr_f_rd_sequence extends uvm_sequence #(mem_seq_item);
    
    int unsigned addr =0;
    
    `uvm_object_utils( wr_f_rd_sequence )
    //write_sequence wr_seq;
    //read_sequence rd_seq;
    function new(string name =" wr_f_rd_sequence");
      super.new(name);
    endfunction:new
    
 /* virtual task body();
  `uvm_do_with(req,{req.wr_en==1;req.addr==0;})
  `uvm_do_with(req,{req.rd_en==1;req.addr==0;})
  `uvm_do_with(req,{req.wr_en==1;req.addr==1;})
  `uvm_do_with(req,{req.rd_en==1;req.addr==1;})
  `uvm_do_with(req,{req.wr_en==1;req.addr==2;})
  `uvm_do_with(req,{req.rd_en==1;req.addr==2;})
  `uvm_do_with(req,{req.wr_en==1;req.addr==3;})
  `uvm_do_with(req,{req.rd_en==1;req.addr==3;})
  endtask */
    
    virtual task body();
    
   //   `uvm_info("\n"," ----------wr_f_rd sequence body step1 is started (Before repeat) ---------",UVM_NONE) // for without raise objection in test analysis
    repeat(`MEM_DEPTH) begin
      //for wirte
     // `uvm_info("\n"," ----------wr_f_rd sequence body step2 is started (After repeat) ---------",UVM_NONE) // for without raise objection in test analysis
      req=mem_seq_item::type_id::create("req");
     // `uvm_info("\n"," ----------wr_f_rd sequence body step3 is started (After create) ---------",UVM_NONE) // for without raise objection in test analysis
      wait_for_grant();
      //`uvm_info("\n"," ----------wr_f_rd sequence body step1 is started (After wait for grant) ---------",UVM_NONE) // for without raise objection in test analysis
      assert( req.randomize with {wr_en == 1; addr == local::addr;}) 
        else `uvm_fatal(get_full_name(),"RANDOMIZATION IS FAILED ");
     // `uvm_info("\n"," ----------wr_f_rd sequence body step1 is started (After randomize) ---------",UVM_NONE) // for without raise objection in test analysis
     send_request(req);
     // `uvm_info("\n"," ----------wr_f_rd sequence body step1 is started (After send request) ---------",UVM_NONE) // for without raise objection in test analysis
      wait_for_item_done();
     // `uvm_info("\n"," ----------wr_f_rd sequence body step1 is started (After wait for item done) ---------",UVM_NONE) // for without raise objection in test analysis
       //for read               
     req=mem_seq_item::type_id::create("req");
     wait_for_grant();
     assert( req.randomize with {rd_en == 1 ; addr == local::addr;}) 
      else `uvm_fatal(get_full_name(),"RANDOMIZATION IS FAILED ")
     send_request(req);
      wait_for_item_done();
     this.addr++;                 
     end
    endtask:body 
    
  endclass: wr_f_rd_sequence 

//////////////////////////////////////////////////////////
//////////////////////////////////////////////////

//test case:sequence for the Perform write and read to all the memory locations

class wr_all_rd_all extends uvm_sequence#(mem_seq_item);
  
  //factory registration
  `uvm_object_utils(wr_all_rd_all)
  
  //default constructor
  function new(string name="wr_all_rd_all");
    super.new(name);
  endfunction:new
  
  virtual task body();
    
  `uvm_do_with(req,{req.wr_en==1;req.addr==3;})
  `uvm_do_with(req,{req.wr_en==1;req.addr==1;})
  `uvm_do_with(req,{req.wr_en==1;req.addr==2;})
  `uvm_do_with(req,{req.wr_en==1;req.addr==0;})
  
    `uvm_do_with(req,{req.rd_en==1;req.addr==2;})
    `uvm_do_with(req,{req.rd_en==1;req.addr==1;})
    `uvm_do_with(req,{req.rd_en==1;req.addr==3;})
    `uvm_do_with(req,{req.rd_en==1;req.addr==0;})
    
  endtask:body
  
endclass:wr_all_rd_all

///////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
class rst_high_sequence extends uvm_sequence#(mem_seq_item);
  //factory registration
  `uvm_object_utils(rst_high_sequence)
  
  function new(string name ="rst_high_sequence");
    super.new(name);
  endfunction:new
  
 virtual task body();
   
   req=mem_seq_item::type_id::create("req");
   start_item(req);
   assert((req.randomize with{rst==1;addr==0;wdata==0;wr_en==0;}))
   else begin
   `uvm_fatal("FATATL","RANDOMIZATION IS FAILED ");
   end
     req.rd_en=0;
   finish_item(req);
   endtask:body
  
endclass:rst_high_sequence

//////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////

class rst_low_sequence extends uvm_sequence#(mem_seq_item);
  //factory registration
  `uvm_object_utils(rst_low_sequence)
  
  function new(string name ="rst_low_sequence");
    super.new(name);
  endfunction:new
  
 virtual task body();
   
   req=mem_seq_item::type_id::create("req");
   start_item(req);
   assert(req.randomize with{rst==0;req.addr==0;wdata==0;wr_en==0;} )
   else begin
   `uvm_fatal("FATATL","RANDOMIZATION IS FAILED ");
   end
   req.rd_en=0;
   finish_item(req);
   endtask:body
  
endclass:rst_low_sequence

///////////////////////////////////////////////////////
////////////////////////////////////////////////////////

//test feature:sequence for reset behaviour of dut 

class rst_sequence extends uvm_sequence#(mem_seq_item);
  //factory registration
  `uvm_object_utils(rst_sequence)
  
  rst_high_sequence rst_h;
  rst_low_sequence rst_l;
  
  function new(string name ="rst_sequence");
    super.new(name);
  endfunction:new
  
 virtual task body();
   `uvm_info(get_full_name(),"\n --------------------RESET CONFIGARTION IS STARTED ------------------",UVM_NONE);
   `uvm_do(rst_h)
    #15;
   `uvm_do(rst_l)
   `uvm_info(get_full_name(),"\n --------------------RESET CONFIGARTION IS COMPLETED ------------------",UVM_NONE);
   `uvm_info(get_full_name(),"\n---------------NOW READING DATA FROM ALL MEMORY LOCATIONS AND SEE THE RESET BEHAVIOUR ALL LOCATIONS \" ff value \" ------------",UVM_NONE);
   `uvm_do_with(req,{rd_en==1;addr==0;})
   `uvm_do_with(req,{rd_en==1;addr==1;})
   `uvm_do_with(req,{rd_en==1;addr==2;})
   `uvm_do_with(req,{rd_en==1;addr==3;})
   `uvm_info(get_full_name(),"\n--------------- READING DATA FROM ALL MEMORY LOCATIONS COMPLETED ------------",UVM_NONE);
    
  
   endtask:body
  
endclass:rst_sequence

///////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////

//test_case:sequence for the Reset in Middle of Write/Read Operation 
//Assert reset in between write/read operation and check for default values. (after writing to few locations assert the reset and perform read operation, we should get default memory location value ‘hFF)

class rst_bw_wr_rd_sequence extends uvm_sequence #(mem_seq_item);
 
//factory registration
  `uvm_object_utils(rst_bw_wr_rd_sequence)
  
  //write sequence
  write_sequence wr_sequ;
  //read sequence
  read_sequence rd_sequ;
  //reset high sequence
    rst_high_sequence rst_h;
  //reset low sequence
  rst_low_sequence rst_l;
  
  //default constractor 
  function new(string name="rst_bw_wr_rd_sequence");
    super.new(name);
  endfunction:new
  
  virtual task body();
    
    `uvm_do(wr_sequ)
    `uvm_do(wr_sequ)
    `uvm_do(wr_sequ)
    `uvm_do(wr_sequ)
    `uvm_do(rst_h)
    #20;
    `uvm_do(rst_l)
    `uvm_do(rd_sequ);
    `uvm_do(rd_sequ);
    `uvm_do(rd_sequ);
    `uvm_do(rd_sequ);
    `uvm_do(rd_sequ);
     `uvm_do(wr_sequ)
    `uvm_do(wr_sequ)
     `uvm_do(rd_sequ);
     `uvm_do(wr_sequ)
     `uvm_do(rst_h)
      #10;
    `uvm_do(rst_l)
     `uvm_do(rd_sequ);
    `uvm_do(rd_sequ);
    `uvm_do(rd_sequ);
    `uvm_do(rd_sequ);
    `uvm_do(rd_sequ);
    
  endtask:body
  
endclass:rst_bw_wr_rd_sequence
