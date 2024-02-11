module BlockMemoryControl (ALUSrc,
                          MemtoReg,
                          RegWrite, 
                          MemRead,
                          MemWrite,
                          Branch,
			  ALUOp,
                          Opcode,
                          CLK,
                          Reset
                          );
   
   output   ALUSrc;
   output   MemtoReg;
   output   RegWrite;
   output   MemRead;
   output   MemWrite;
   output   Branch;
   output   [2:0] ALUOp;
	
   input [6:0] Opcode;
   input       CLK;
   input       Reset;
   
   reg         ALUSrc;
   reg         MemtoReg;
   reg         RegDst;
   reg         RegWrite;
   reg         MemRead;
   reg         MemWrite;
   reg         Branch;
	reg 	[2:0]	ALUOp;
   
   
   always @ (posedge CLK)
     begin      
        $display("The opcode is %h", Opcode);
        case (Opcode)
          7'h63:
			 //beq
            begin
               $display("beq type");
               ALUSrc = 0;
               MemtoReg = 0;//any value
               RegWrite = 0;
               MemRead = 0;
               MemWrite = 0;
               Branch = 1;
	       ALUOp = 01;
            end
          7'h23:
			 // sw
            begin
               $display("sw type");
               ALUSrc = 1;
               MemtoReg = 0;//any value
               RegWrite = 0;
               MemRead = 0;
               MemWrite = 1;
               Branch = 0;
	       ALUOp= 00;
            end
          7'h33:
			 //r type
            begin
               $display("R type");
               ALUSrc = 0;
               MemtoReg = 0;
               RegWrite = 1;
               MemRead = 0;
               MemWrite = 0;
               Branch = 0;
					ALUOp = 00;
            end
          7'h3:
			 //lw 
            begin 
               $display("lw type");
               ALUSrc = 1;
               MemtoReg = 1;
               RegWrite = 1;
               MemRead = 1;
               MemWrite = 0;
               Branch = 0;
					ALUOp = 00;
            end
          default:
            begin 
               $display(" Wrong Opcode %h ", Opcode);  
            end
        endcase 
        
     end
   
endmodule