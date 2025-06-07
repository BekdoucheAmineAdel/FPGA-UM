##################################################################################
# Company: University of Montpellier
# Engineer: Bekdouche Amine Adel
# 
# Create Date: 2025-06-07
# Design Name: M2-FPGA
# File Name: top_vga_prom_2.xdc
# Project Name: FPGA Crash Course
# Target Devices: Xilinx Artix-7 (or your specific FPGA)
# Tool Versions: Vivado 2023.1 (or your actual version)
# Description: 
# This constraints file maps the top-level ports of the VGA display system to 
# physical FPGA pins. It defines I/O standards and clock constraints for the 
# VGA output, input switches, reset button, and system clock.
#
# Constraints:
# - Clock input on pin W5 with 100 MHz frequency
# - Reset and 4-bit switch inputs mapped to user buttons
# - 12-bit RGB output mapped to VGA connector pins
# - Horizontal and vertical sync signals mapped to VGA connector
#
# Dependencies:
# - TOP_VGA_PROM_2.vhd (top-level design)
# - Board-specific pinout documentation
#
# Revision:
# Revision 0.01 - File Created
# Additional Comments:
# Ensure pin mappings match the actual FPGA development board used.
##################################################################################

# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

# Buttons
set_property PACKAGE_PIN U18 [get_ports rst]			
	set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property PACKAGE_PIN T18 [get_ports {sw[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
set_property PACKAGE_PIN W19 [get_ports {sw[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
set_property PACKAGE_PIN T17 [get_ports {sw[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
set_property PACKAGE_PIN U17 [get_ports {sw[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]

# VGA Connector
set_property PACKAGE_PIN G19 [get_ports {RGB[8]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {RGB[8]}]
set_property PACKAGE_PIN H19 [get_ports {RGB[9]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {RGB[9]}]
set_property PACKAGE_PIN J19 [get_ports {RGB[10]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {RGB[10]}]
set_property PACKAGE_PIN N19 [get_ports {RGB[11]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {RGB[11]}]
set_property PACKAGE_PIN N18 [get_ports {RGB[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {RGB[0]}]
set_property PACKAGE_PIN L18 [get_ports {RGB[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {RGB[1]}]
set_property PACKAGE_PIN K18 [get_ports {RGB[2]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {RGB[2]}]
set_property PACKAGE_PIN J18 [get_ports {RGB[3]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {RGB[3]}]
set_property PACKAGE_PIN J17 [get_ports {RGB[4]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {RGB[4]}]
set_property PACKAGE_PIN H17 [get_ports {RGB[5]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {RGB[5]}]
set_property PACKAGE_PIN G17 [get_ports {RGB[6]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {RGB[6]}]
set_property PACKAGE_PIN D17 [get_ports {RGB[7]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {RGB[7]}]
set_property PACKAGE_PIN P19 [get_ports hsync]
	set_property IOSTANDARD LVCMOS33 [get_ports hsync]
set_property PACKAGE_PIN R19 [get_ports vsync]	
	set_property IOSTANDARD LVCMOS33 [get_ports vsync]
