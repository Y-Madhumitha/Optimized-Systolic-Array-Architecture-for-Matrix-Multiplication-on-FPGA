# 🚀 Optimized Systolic Array Architecture for Matrix Multiplication on FPGA

Designed and implemented an optimized systolic array architecture on FPGA for efficient matrix multiplication using hex-packed input formatting. The design aims to minimize resource usage and improve scalability for large matrix operations.

## 🧠 Overview

Matrix multiplication is a fundamental operation in various computing applications like AI, image processing, and DSP. This project presents a pipelined systolic array architecture using Verilog HDL, optimized through hex-packed input formatting for reduced memory usage and high-speed computation.

---

## ✨ Key Highlights

-  *Hex-packed matrix format* for efficient data handling and reduced storage overhead.
-  *Implemented using Verilog HDL* and synthesized in *Xilinx Vivado*.
-  *Deployed on Nexys 4 FPGA board (Artix-7)*.
-  *Pipelined architecture* to ensure high-speed, parallel, and scalable matrix computations.

---

## 🖥 Tools & Technologies

| Tool           | Purpose                              |
|----------------|--------------------------------------|
| Verilog HDL    | Hardware Description and Modeling    |
| Xilinx Vivado  | Synthesis, Simulation, Implementation|
| Nexys 4 (Artix-7) | FPGA Deployment                   |

---

## 🛠 How It Works

1. *Input Formatting:* Matrices are encoded in a compact hexadecimal format to reduce I/O and memory access time.
2. *Systolic Array Design:* Multiple processing elements (PEs) compute partial products in a pipelined and synchronized fashion.
3. *Pipelining:* Enables overlapping of operations for throughput maximization.
4. *Deployment:* Fully synthesized and tested on a physical FPGA board for real-time performance validation.

---

