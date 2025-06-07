# FPGA-UM

This repository contains various lab works and projects related to FPGA, created during my academic year. The designs are primarily written in VHDL and serve as practical exercises for understanding digital systems, hardware description, and FPGA design flows.

## Repository Structure

- **VHDL Scripts/**  
  Contains subfolders for each project or module implemented in VHDL:
  - [`counter`](VHDL%20Scripts/counter): Simple digital counter.
  - [`counter_decounter`](VHDL%20Scripts/counter_decounter): Bidirectional counter (count up & down).
  - [`flip flop sync`](VHDL%20Scripts/flip%20flop%20sync): Synchronous flip-flop circuits.
  - [`latch`](VHDL%20Scripts/latch): Latch designs for memory elements.
  - [`register`](VHDL%20Scripts/register): Register modules for data storage.
  - [`traffic_lights`](VHDL%20Scripts/traffic_lights): Traffic light controller example.
  - [`vga_controller`](VHDL%20Scripts/vga_controller): VGA signal generator/controller.

## Getting Started

1. **Prerequisites**
   - FPGA development board (such as Xilinx, Altera, or similar)
   - VHDL-compatible simulator and synthesizer (e.g., ModelSim, Vivado, Quartus)
   - Basic understanding of digital logic and VHDL

2. **Usage**
   - Clone the repository:
     ```sh
     git clone https://github.com/BekdoucheAmineAdel/FPGA-UM.git
     ```
   - Browse to the `VHDL Scripts` directory and select a project.
   - Open the VHDL files in your preferred FPGA IDE or simulator.
   - Simulate or synthesize the design according to your FPGA toolchain’s workflow.

## Projects Overview

Each subfolder in `VHDL Scripts` contains VHDL source files for a specific lab or project. Example projects include:
- **Counters and Registers:** Fundamental building blocks for sequential circuits.
- **Flip-Flops and Latches:** Basic storage and synchronization primitives.
- **Traffic Light Controller:** Simple state machine design for real-world applications.
- **VGA Controller:** Signal generation for driving VGA-compatible displays.

## Contributing

This repository serves as a learning resource. If you have suggestions or improvements, feel free to open an issue or submit a pull request.

## License

Distributed for educational purposes.

---

*Created and maintained by Bekdouche Amine.*
