# RV32I Single-Cycle Processor – Milestone 2

## Student Information

**Course:** CSCE 3301 – Computer Organization and Assembly Language  
**Project:** RV32I Processor – Milestone 2  
**Semester:** Fall 2026

**Team Members:**
1. Asmaa Elshabshiri – 900243596
2. Janna Alfiky – 900241379

---

## 1. Project Overview

The project involves the development of a single-cycle processor based on the RV32I instruction set architecture. The processor uses separate instruction and data memories and is designed to support the 42 instructions specified for Milestone 2.

This submission focuses on the verification of the processor through a Verilog testbench. The testbench applies machine-code instructions to the processor and checks whether the resulting register values, memory contents, and program counter updates match the expected behavior.

## 2. Testbench Coverage

The testbench is designed to verify all 42 instructions across the following categories:

- **R-type:** ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND.
- **I-type:** ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI.
- **Load:** LB, LH, LW, LBU, LHU.
- **Store:** SB, SH, SW.
- **Branch:** BEQ, BNE, BLT, BGE, BLTU, BGEU.
- **Jump:** JAL, JALR.
- **U-type:** LUI, AUIPC.
- **System and miscellaneous:** ECALL, EBREAK, FENCE, FENCE.TSO, PAUSE.

## 3. Testing Methodology

The testbench uses predefined machine-code instructions and controlled initial values to test individual processor operations.

For each test case, it:
- Loads the instruction into instruction memory.
- Initializes the required registers and memory locations.
- Allows the processor to execute the instruction.
- Checks the resulting register values, memory contents, or PC value.
- Compares the actual output with the expected result.
- Reports whether the test passed or failed.

The tests are designed to isolate individual instructions so that their behavior can be evaluated independently.

## 4. Assumptions and Design Decisions

- The processor is instantiated as `DUT` in the testbench.
- The testbench uses hierarchical references to access the processor's internal registers, memories, and PC.
- Register and memory values are initialized to controlled values before relevant tests.
- Data memory is assumed to use little-endian byte ordering.
- ECALL, FENCE, FENCE.TSO, and PAUSE are treated as NOP instructions according to the project specifications.
- EBREAK is treated as a halt instruction that prevents further PC updates.
- Expected results are based on the intended RV32I instruction behavior and the project's specifications.

## 5. Known Issues and Limitations

- The testbench depends on the processor's module hierarchy and internal signal names matching the references used in the testbench.
- The processor's Verilog source files must be included in the Vivado simulation project for the testbench to run.
- The testbench loads instructions directly into instruction memory; it does not automatically read `instructions_42.hex`.
- Some expected results may need adjustment depending on the initial PC and processor state.
- Full RV32I compliance has not been independently verified through this testbench.

## 6. Current Testing Status

- **Test cases prepared:** 42.
- **Instruction categories covered:** R-type, I-type, Load, Store, Branch, Jump, U-type, System, and Miscellaneous.
- **Simulation environment:** Xilinx Vivado.
- **Compilation status:** [Update after compilation.]
- **Passing test cases:** [Update after simulation.]
- **Failing test cases:** [Update after simulation.]
- **Unresolved issues:** [List any remaining issues.]

## 7. Submission Contents

**Submitted file:**

- `processor_ms2_tb.v` – Verilog testbench containing the test cases and expected-result checks for the 42 RV32I instructions.

The processor implementation is not included in this submission. Its Verilog modules are required separately in Vivado to compile and execute the testbench.

## 8. Release Notes

**Version 1.0 – Milestone 2**

Initial release of the RV32I processor verification testbench, covering 42 instructions across the supported instruction categories. Includes controlled test inputs, expected-result comparisons, and pass/fail reporting.
