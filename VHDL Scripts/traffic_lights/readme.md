FDC State Machine Project
=========================

Overview
--------
This project implements a Finite State Machine (FSM) named `fdc` for managing vehicle and pedestrian traffic signals. It is designed as part of the M1-FPGA educational project at the University of Montpellier.

Key Features:
- Implements a finite state machine for managing vehicle and pedestrian signals.
- Supports pedestrian button inputs (`bph`, `bpv`) for horizontal and vertical crossings.
- Controls traffic light phases: vehicle green/yellow/red and pedestrian walk.
- Ensures safe and timed transitions between states.
- Designed for M1-FPGA educational project at University of Montpellier.

FSM Description
---------------
The FSM transitions through six states:
- ETA_VH
- ETA_YH
- ETA_PH
- ETA_VV
- ETA_YV
- ETA_PV

Each state controls the output signals for horizontal (`vh`, `yh`, `rh`) and vertical (`vv`, `yv`, `rv`) traffic lights. Transitions are determined by:
- Clock (`clk`)
- Reset (`rst`)
- Pedestrian button inputs (`bph`, `bpv`)
- A 4-bit internal timer (`temp`)

Testbench: fdc_tb
-----------------
The testbench `fdc_tb` simulates the `fdc` module and verifies its behavior under various input conditions.

Features:
- Simulates `fdc` module with clock, reset, and pedestrian button inputs.
- Verifies correct state transitions and output signal behavior.
- Includes timing scenarios for both horizontal and vertical pedestrian requests.
- Supports waveform-based validation of FSM logic.
- Part of the M1-FPGA educational project.

Usage
-----
1. Load the `fdc.vhd` and `fdc_tb.vhd` files into your VHDL simulation environment.
2. Run the simulation to observe the FSM behavior and validate signal transitions.
3. Use waveform viewers to analyze timing and state transitions.

Dependencies
------------
- IEEE standard libraries: `STD_LOGIC_1164`, `STD_LOGIC_ARITH`, `STD_LOGIC_UNSIGNED`
- Compatible with Xilinx FPGA development tools
