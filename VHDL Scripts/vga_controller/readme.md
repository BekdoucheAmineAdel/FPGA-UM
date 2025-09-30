VGA Controller in VHDL
======================

Project Overview
----------------
This project involves the design and implementation of a VGA controller using VHDL on a Basys 3 FPGA board. The controller is capable of generating synchronization signals, displaying colored patterns, and rendering sprites using PROM and Block ROM memory.

Developed as part of the Master's program in Electronics, Electrical Energy & Automation at Université de Montpellier.

Features
--------
- VGA signal generation (640x480 @ 60Hz)
- Pixel clock generation (25 MHz and 1 Hz)
- Display of colored stripes
- Sprite rendering using PROM
- Advanced sprite rendering using Block ROM
- Interactive control via switches
- Fully testbenched and simulated in Vivado

Components
----------
1. gen_pixel_clk
   - Generates 25 MHz pixel clock and 1 Hz clock for sprite movement

2. VGA_640x480
   - Generates horizontal and vertical sync signals and active video signal (vidon)

3. VGA_STRIPES
   - Displays alternating red and green horizontal stripes

4. VGA_PROM
   - Displays a sprite in the top-left corner using PROM
   - Controlled via 4-bit switch input

5. VGA_PROM_2
   - Displays complex sprites using Block ROM
   - Supports .coe file initialization

6. TOP_VGA_*
   - Top-level modules integrating all components for:
     - Stripes display
     - PROM sprite display
     - Block ROM sprite display

Simulation & Testing
--------------------
Each component includes a testbench to validate:
- Clock division
- Sync signal generation
- RGB output correctness
- Sprite rendering and movement

Visual Results
--------------
- ✅ Clock and sync signals verified via waveform
- ✅ Stripes and sprites rendered correctly
- ✅ Sprite movement controlled via switches
- ✅ Complex images displayed from Block ROM

Implementation
--------------
- XDC File: Defines pin constraints for Basys 3
- Bitstream Generation: Done via Vivado
- Programming: Bitstream uploaded to Basys 3 via USB

Future Improvements
-------------------
- Higher resolution support
- Smooth sprite animation
- Real-time interactivity
- Resource optimization
- Advanced applications (e.g., games, GUIs)

File Structure
--------------
src/

├── gen_pixel_clk.vhd

├── VGA_640x480.vhd

├── VGA_PROM.vhd

├── VGA_PROM_2.vhd

├── TOP_VGA_STRIPES.vhd

├── TOP_VGA_PROM.vhd

├── TOP_VGA_PROM_2.vhd

├── PROM.vhd

└── img2.m

tb/

├── VGA_640x480_tb.vhd

└── TOP_VGA_STRIPES_tb.vhd

constraints/

└── basys3_mapping.xdc

README.md

report.pdf
