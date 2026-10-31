# RV32I Single-Cycle Processor

A 32-bit RISC-V single-cycle processor implemented in Verilog and designed for the Digilent Nexys A7 FPGA board.

## Project Overview

This project implements a single-cycle processor based on the RV32I instruction set architecture. It includes the processor datapath, control logic, register file, ALU, immediate generator, and separate instruction and data memories.

## Architecture

The processor consists of the following main components:

- Program Counter (PC)
- Instruction Memory
- Control Unit
- Register File
- Immediate Generator
- Arithmetic Logic Unit (ALU)
- ALU Control Unit
- Branch Unit
- Data Memory
- Writeback and Next-PC selection logic

See `docs/block_diagram.png` for the processor architecture.

## Instruction Support

The processor is designed to support the RV32I base integer instruction set, with the following project-specific exceptions:

- EBREAK: Halts the processor.
- ECALL: Treated as a NOP.
- FENCE and FENCE.TSO: Treated as NOPs.

## Repository Structure

- `rtl/`: Verilog source files.
- `sim/`: Testbenches and simulation programs.
- `docs/`: Architecture diagrams and documentation.
- `constraints/`: FPGA constraints.
- `scripts/`: Build and simulation scripts.

## Development Tools

- Verilog
- Xilinx Vivado
- Digilent Nexys A7 FPGA

## Testing

Simulation testbenches are located in `sim/testbenches/`.

## Contributors

