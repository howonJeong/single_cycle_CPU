`timescale 100ps / 100ps

module ALU(
    input [15:0] A,
    input [15:0] B,
    input Cin,
    input [3:0] OP,
    output reg Cout,
    output reg [15:0] C
    );
    
    // FILLME
    always @(A, B, Cin) begin
        Cout <= 0; // Initialize carry-out
        case(OP)
            4'b0000: begin // Adder
                {Cout, C} <= A + B + Cin; // Handles carry-out
            end
            4'b0001: begin // Subtractor
                {Cout, C} <= {1'b0, A} - (B + Cin); // `Cout` as borrow flag
                if (A < (B + Cin))
                    Cout <= 1;
            end
            4'b0010: C <= A;
            4'b0011: C <= ~(A & B); // NAND
            4'b0100: C <= ~(A | B); // NOR
            4'b0101: C <= ~(A ^ B); // XNOR
            4'b0110: C <= ~A;       // NOT
            4'b0111: C <= (A & B);  // AND
            4'b1000: C <= (A | B);  // OR
            4'b1001: C <= (A ^ B);  // XOR
            4'b1010: C <= A >> 1;   // Logical right shift
            4'b1011: C <= {A[15], A[15:1]};  // Arithmetic right shift
            4'b1100: begin          // Rotate right
                C <= A >> 1;
                C[15] <= A[0];
            end
            4'b1101: C <= A << 1;   // Logical left shift
            4'b1110: C <= A <<< 1;  // Arithmetic left shift
            4'b1111: begin          // Rotate left
                C <= (A << 1) | A[15];
            end
        endcase
    end
endmodule