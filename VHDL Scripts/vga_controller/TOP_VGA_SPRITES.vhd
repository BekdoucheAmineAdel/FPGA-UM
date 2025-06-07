----------------------------------------------------------------------------------
-- Company: University of Montpellier
-- Engineer: Bekdouche Amine Adel
-- 
-- Create Date: [Insert actual date]
-- Design Name: M2-FPGA
-- Module Name: TOP_VGA_SPRITES - Behavioral
-- Project Name: FPGA Crash Course
-- Target Devices: Xilinx Artix-7 (or your specific FPGA)
-- Tool Versions: Vivado 2023.1 (or your actual version)
-- Description: 
-- This is the top-level module for VGA display output. It integrates:
-- - A pixel clock generator (gen_pixel_clk) to produce a 25 MHz clock
-- - A VGA timing controller (VGA_640x480) for 640x480 resolution at 60 Hz
-- - A pixel generator (VGA_STRIPES) to produce RGB color patterns
-- The module outputs horizontal and vertical sync signals and a 12-bit RGB signal.
-- 
-- Dependencies: 
-- gen_pixel_clk.vhd
-- VGA_640x480.vhd
-- VGA_STRIPES.vhd
-- IEEE.STD_LOGIC_1164.ALL
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - Integrated VGA timing and RGB pattern generation
-- Additional Comments:
-- This module is part of the M2-FPGA educational project at the University 
-- of Montpellier, demonstrating VGA signal generation and display control.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP_VGA_SPRITES is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           hsync : out STD_LOGIC;
           vsync : out STD_LOGIC;
           RGB : out STD_LOGIC_VECTOR (11 downto 0));
end TOP_VGA_SPRITES;

architecture Behavioral of TOP_VGA_SPRITES is
    signal clk25, vidon : STD_LOGIC;
    signal vc, hc: STD_LOGIC_VECTOR(9 downto 0);
    component VGA_640x480 is
        Port ( clk25 : in STD_LOGIC;
               rst : in STD_LOGIC;
               hsync : out STD_LOGIC;
               vsync : out STD_LOGIC;
               hc : out STD_LOGIC_VECTOR (9 downto 0);
               vc : out STD_LOGIC_VECTOR (9 downto 0);
               vidon : out STD_LOGIC);
    end component;
    
    component VGA_STRIPES is
        Port ( HC : in STD_LOGIC_VECTOR (9 downto 0);
               VC : in STD_LOGIC_VECTOR (9 downto 0);
               vidon : in STD_LOGIC;
               RGB : out STD_LOGIC_VECTOR (11 downto 0));
    end component;
    
    component gen_pixel_clk is
        Port ( rst : in STD_LOGIC;
               clk : in STD_LOGIC;
               clk25 : out STD_LOGIC);
    end component;
    
begin

    gen_pixel_clk_c : gen_pixel_clk port map(rst => rst, clk => clk, clk25 => clk25);
    VGA_640x480_c : VGA_640x480 port map(clk25 => clk25, rst => rst, hsync => hsync, vsync => vsync, hc => hc, vc => vc, vidon => vidon);
    VGA_STRIPES_c : VGA_STRIPES port map(hc => hc, vc => vc, vidon => vidon, RGB => RGB);

end Behavioral;