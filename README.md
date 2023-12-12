# Verilog CPU

Welcome to the Verilog CPU project! In this repository, you'll find the source code for various simple CPUs implemented in Verilog. This project serves as coursework for the "Principles of Computer Organization" class, offering a practical exploration of CPU architecture and the Verilog hardware description language.

## Introduction

Here are four folders:

- **Folder 1:** Contains a simple single-cycle CPU.
- **Folder 2:** Houses a multi-cycle CPU.
- **Folder 3:** Features a multi-program CPU.
- **Folder 4:** Introduces a CPU that extends some instruction sets based on the single-cycle CPU.

## Getting Started

**Compiler:** Icarus Verilog

To compile the `main.v` file, follow these steps:

```
iverilog main.v
vvp a.out
```

After compilation, a VCD (Value Change Dump) file named 'main_test.vcd' will be generated in the folder. You can visualize the signal waveforms using `gtkwave`.
