----------------------------------------------------------------------------------
-- Company: University of Montpellier
-- Engineer: Bekdouche Amine Adel
-- 
-- Create Date: [Insert actual date]
-- Design Name: M2-FPGA
-- Module Name: blk_mem_gen_2 - Structural
-- Project Name: FPGA Crash Course
-- Target Devices: Xilinx Artix-7 (or your specific FPGA)
-- Tool Versions: Vivado 2023.1 (or your actual version)
-- Description: 
-- This module declares the interface for a block memory generator IP core 
-- (blk_mem_gen_v8_3_1). It provides synchronous read access to an 8-bit wide 
-- memory using a 17-bit address input. This memory can be used for storing 
-- image data, font maps, or other binary resources in FPGA designs.
-- 
-- Inputs:
-- - clka: Clock input for synchronous memory access
-- - addra: 17-bit address input
-- 
-- Outputs:
-- - douta: 8-bit data output from memory
-- 
-- Dependencies: 
-- IEEE.STD_LOGIC_1164.ALL
-- IEEE.NUMERIC_STD.ALL
-- blk_mem_gen_v8_3_1 library (Xilinx IP)
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- This module is part of the M2-FPGA educational project at the University 
-- of Montpellier, demonstrating memory-mapped data access using IP cores.
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY blk_mem_gen_v8_3_1;
USE blk_mem_gen_v8_3_1.blk_mem_gen_v8_3_1;

ENTITY blk_mem_gen_2 IS
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END blk_mem_gen_2;