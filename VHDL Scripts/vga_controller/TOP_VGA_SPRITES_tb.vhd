----------------------------------------------------------------------------------
-- Company: University of Montpellier
-- Engineer: Bekdouche Amine Adel
-- 
-- Create Date: [Insert actual date]
-- Design Name: M2-FPGA
-- Module Name: TOP_VGA_SPRITES_tb - Behavioral
-- Project Name: FPGA Crash Course
-- Target Devices: Xilinx Artix-7 (or your specific FPGA)
-- Tool Versions: Vivado 2023.1 (or your actual version)
-- Description: 
-- This is the testbench for the TOP_VGA_SPRITES module. It simulates the 
-- top-level VGA display system, including pixel clock generation, VGA timing, 
-- and RGB pattern output. The testbench generates a 50 MHz clock and applies 
-- a reset pulse to verify correct synchronization and RGB output behavior.
-- 
-- Dependencies: 
-- TOP_VGA_SPRITES.vhd
-- IEEE.STD_LOGIC_1164.ALL
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - Added clock and reset stimulus for simulation
-- Additional Comments:
-- This testbench is part of the M2-FPGA educational project at the University 
-- of Montpellier, used to validate the complete VGA display pipeline.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP_VGA_SPRITES_tb is
end TOP_VGA_SPRITES_tb;

architecture Behavioral of TOP_VGA_SPRITES_tb is

signal clk, rst, hsync, vsync: STD_LOGIC;
signal RGB : STD_LOGIC_VECTOR (11 downto 0);

component TOP_VGA_SPRITES is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           hsync : out STD_LOGIC;
           vsync : out STD_LOGIC;
           RGB : out STD_LOGIC_VECTOR (11 downto 0));
end component;
begin

TOP_VGA_SPRITES_test : TOP_VGA_SPRITES port map (clk => clk, rst => rst, hsync => hsync, vsync => vsync, RGB => RGB);

clock : process is
begin
    clk <= '0';
    wait for 10ns;
    clk <= '1';
    wait for 10ns;
end process;

reset : process is
begin
    rst <= '0';
    wait for 9ns;
    rst <= '1';
    wait for 2ns;
    rst <= '0';
    wait;
end process;

end Behavioral;