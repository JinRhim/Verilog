# Verilog

## Chapter 2 

1. Combinational Circuits  
    1. concurrent statement / continuous assignment 
        1. already ready to execute 
        2. evaluated any time. 
        3. Every time right side always changes 
        4. execute repeatedly (as if they are in loop)

2. Combinational Logic Example 
    1. Clock generator 
  ```
  assign #10 CLK = ~CLK; 

  assign #5 C = A&& B; 
  assign #5 E = C || D;   
  ```
  
    2. Array of AND Gates 
    
  ```
  assign C[3] = A[3] && B[3];
  assign C[2] = A[2] && B[2];
  assign C[1] = A[1] && B[1];
  assign C[0] = A[0] && B[0];
  
  //Instead of this, use 4-bit vectors 
  
  assign C = A & B;
 
 
 

