// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and outputs
  reg [1:0] A;
  reg [1:0] B;
  wire GT, LT, EQ;
  // TODO: instantiate DUT here

  comp2 chicken_tikka(
    .A(A),
    .B(B),
    .GT(GT),
    .LT(LT),
    .EQ(EQ)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, chicken_tikka);
    end
  end

  reg exp_eq, exp_gt, exp_lt;
  int errors;

  initial begin
    // TODO: apply different input combinations

    for(int i = 0;i < 4;i++) begin
      for(int j = 0;j < 4;j++) begin
        A = i;
        B = j;
        #5;

        exp_eq = (A == B);
        exp_gt = (A > B);
        exp_lt = (A < B);

        if({EQ,GT,LT} !== {exp_eq, exp_gt, exp_lt})begin
        $display("FAIL at time %0t: A=%b B=%b  got GT=%b LT=%b EQ=%b  expected GT=%b LT=%b EQ=%b", $time, A, B, GT, LT, EQ, exp_gt, exp_lt, exp_eq);
        errors = errors + 1;
      end

      end
    end

    $display("RESULT: %0d errors out of 16 tests", errors);
    $finish;

    
  end

  initial
    $monitor($time, " A = %b, B = %b -> EQ, GT, LT = %b, %b, %b", A, B, EQ, GT, LT); // change as required



endmodule