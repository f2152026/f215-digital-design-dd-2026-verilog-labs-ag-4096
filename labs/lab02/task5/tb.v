// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and outputs
  reg [3:0] A;
  reg [3:0] B;
  reg op;
  wire[3:0] res; 
  // TODO: instantiate DUT here

  alu chicken_tikka(
    .a(A),
    .b(B),
    .op(op),
    .result(res)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, chicken_tikka);
    end
  end

  reg [3:0]exp_res;
  int errors;

  initial begin
    // TODO: apply different input combinations

    for(int o = 0;o <= 1;o++)begin
        for(int i = 0;i < 16;i++) begin
            for(int j = 0;j < 16;j++) begin
                A = i;
                B = j;
                op = o;
                #5;

                if(op == 0)begin
                    exp_res = A + B;
                end else begin
                    exp_res = A - B;
                end

                if(res !== exp_res)begin
                    $display("FAIL at time %0t: A=%b B=%b  and op=%b --> RESULT = %b expected = %b", $time, A, B, op, res, exp_res);
                    errors = errors + 1;
                end

            end
        end
    end

    $display("RESULT: %0d errors out of 512 tests", errors);
    $finish;

    
  end

  initial
    $monitor($time, " A = %b, B = %b, op = %b, res = %b", A, B, op, res); // change as required

endmodule