----------------------------------------------------------------------------------
-- Company: University of Montpellier
-- Engineer: Bekdouche Amine Adel
-- 
-- Create Date: [Insert actual date]
-- Design Name: M2-FPGA
-- Module Name: TOP_VGA_PROM - Behavioral
-- Project Name: FPGA Crash Course
-- Target Devices: Xilinx Artix-7 (or your specific FPGA)
-- Tool Versions: Vivado 2023.1 (or your actual version)
-- Description: 
-- This is the top-level module for VGA sprite rendering using ROM-based pixel 
-- data. It integrates:
-- - Pixel clock generation (25 MHz and 1 Hz)
-- - VGA timing controller for 640x480 resolution
-- - Sprite rendering logic with directional control via switches
-- - PROM module for sprite pixel data storage
-- 
-- Inputs:
-- - clk: System clock input
-- - rst: Synchronous reset
-- - sw: 4-bit switch input for sprite movement
-- 
-- Outputs:
-- - hsync, vsync: VGA synchronization signals
-- - RGB: 12-bit RGB output for VGA display
-- 
-- Dependencies: 
-- gen_pixel_clk.vhd
-- VGA_640x480.vhd
-- VGA_PROM.vhd
-- PROM.vhd
-- IEEE.STD_LOGIC_1164.ALL
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - Integrated all submodules for complete VGA sprite system
-- Additional Comments:
-- This module is part of the M2-FPGA educational project at the University 
-- of Montpellier, demonstrating full VGA sprite rendering with user interaction.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP_VGA_PROM is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           hsync : out STD_LOGIC;
           vsync : out STD_LOGIC;
           RGB : out STD_LOGIC_VECTOR (11 downto 0);
           sw : in STD_LOGIC_VECTOR (3 downto 0));
end TOP_VGA_PROM;

architecture Behavioral of TOP_VGA_PROM is
    signal clk25, vidon, clk_1hz : STD_LOGIC;
    signal vc, hc: STD_LOGIC_VECTOR(9 downto 0);
    signal M : STD_LOGIC_VECTOR (31 downto 0);
    signal ROM_ADDR4 : STD_LOGIC_VECTOR (3 downto 0);
    
    component VGA_640x480 is
        Port ( clk25 : in STD_LOGIC;
               rst : in STD_LOGIC;
               hsync : out STD_LOGIC;
               vsync : out STD_LOGIC;
               hc : out STD_LOGIC_VECTOR (9 downto 0);
               vc : out STD_LOGIC_VECTOR (9 downto 0);
               vidon : out STD_LOGIC);
    end component;
    
    component VGA_PROM is
        Port ( clk_1hz : in STD_LOGIC;
               HC : in STD_LOGIC_VECTOR (9 downto 0);
               VC : in STD_LOGIC_VECTOR (9 downto 0);
               VIDON : in STD_LOGIC;
               M : in STD_LOGIC_VECTOR (31 downto 0);
               ROM_ADDR4 : out STD_LOGIC_VECTOR (3 downto 0);
               RGB : out STD_LOGIC_VECTOR (11 downto 0);
               sw : in STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component gen_pixel_clk is
        Port ( rst : in STD_LOGIC;
               clk : in STD_LOGIC;
               clk25 : out STD_LOGIC;
               clk_1hz : out STD_LOGIC);
    end component;
    
    component PROM is
        Port ( addr : in STD_LOGIC_VECTOR (3 downto 0);
               m : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
begin

    gen_pixel_clk_c : gen_pixel_clk port map(rst => rst, clk => clk, clk25 => clk25, clk_1hz => clk_1hz);
    VGA_640x480_c : VGA_640x480 port map(clk25 => clk25, rst => rst, hsync => hsync, vsync => vsync, hc => hc, vc => vc, vidon => vidon);
    VGA_PROM_c : VGA_PROM port map(clk_1hz => clk_1hz, hc => hc, vc => vc, vidon => vidon, M => M, ROM_ADDR4 => ROM_ADDR4, RGB => RGB, sw => sw);
    PROM_c : PROM port map(addr => ROM_ADDR4, m => M);
    
end Behavioral;