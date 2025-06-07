----------------------------------------------------------------------------------
-- Company: University of Montpellier
-- Engineer: Bekdouche Amine Adel
-- 
-- Create Date: 2025-06-07
-- Design Name: M2-FPGA
-- Module Name: TOP_VGA_PROM_2 - Structural
-- Project Name: FPGA Crash Course
-- Target Devices: Xilinx Artix-7 (or your specific FPGA)
-- Tool Versions: Vivado 2023.1 (or your actual version)
-- Description: 
-- This is the top-level module for a VGA display system using a PROM-based 
-- memory. It integrates a VGA timing generator, a pixel clock generator, 
-- a PROM-based image data source, and a display controller. The system 
-- outputs 12-bit RGB video signals synchronized with VGA timing.
-- 
-- Inputs:
-- - clk: System clock input
-- - rst: Active-high synchronous reset
-- - sw: 4-bit input switch for display control or mode selection
-- 
-- Outputs:
-- - hsync: Horizontal sync signal for VGA
-- - vsync: Vertical sync signal for VGA
-- - RGB: 12-bit RGB output for VGA display
-- 
-- Dependencies: 
-- IEEE.STD_LOGIC_1164.ALL
-- VGA_640x480 (VGA timing generator)
-- VGA_PROM_2 (Display controller)
-- gen_pixel_clk (Clock divider for 25 MHz and 1 Hz)
-- blk_mem_gen_2 (Block memory IP for image data)
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- This module is part of the M2-FPGA educational project at the University 
-- of Montpellier, demonstrating VGA signal generation and memory-mapped 
-- image display using IP cores.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TOP_VGA_PROM_2 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           hsync : out STD_LOGIC;
           vsync : out STD_LOGIC;
           RGB : out STD_LOGIC_VECTOR (11 downto 0);
           sw : in STD_LOGIC_VECTOR (3 downto 0));
end TOP_VGA_PROM_2;

architecture Behavioral of TOP_VGA_PROM_2 is
    signal clk25, vidon, clk_1hz : STD_LOGIC;
    signal vc, hc: STD_LOGIC_VECTOR(9 downto 0);
    signal M : STD_LOGIC_VECTOR (7 downto 0);
    signal ROM_ADDR17 : STD_LOGIC_VECTOR (16 downto 0);
    
    component VGA_640x480 is
        Port ( clk25 : in STD_LOGIC;
               rst : in STD_LOGIC;
               hsync : out STD_LOGIC;
               vsync : out STD_LOGIC;
               hc : out STD_LOGIC_VECTOR (9 downto 0);
               vc : out STD_LOGIC_VECTOR (9 downto 0);
               vidon : out STD_LOGIC);
    end component;
    
    component VGA_PROM_2 is
        Port ( clk_1hz : in STD_LOGIC;
               HC : in STD_LOGIC_VECTOR (9 downto 0);
               VC : in STD_LOGIC_VECTOR (9 downto 0);
               VIDON : in STD_LOGIC;
               M : in STD_LOGIC_VECTOR (7 downto 0);
               ROM_ADDR : out STD_LOGIC_VECTOR (16 downto 0);
               RGB : out STD_LOGIC_VECTOR (11 downto 0);
               sw : in STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component gen_pixel_clk is
        Port ( rst : in STD_LOGIC;
               clk : in STD_LOGIC;
               clk25 : out STD_LOGIC;
               clk_1hz : out STD_LOGIC);
    end component;
    
    component blk_mem_gen_2 is
      PORT (
        clka : IN STD_LOGIC;
        addra : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
      );
    end component;
    
begin

    gen_pixel_clk_c : gen_pixel_clk port map(rst => rst, clk => clk, clk25 => clk25, clk_1hz => clk_1hz);
    VGA_640x480_c : VGA_640x480 port map(clk25 => clk25, rst => rst, hsync => hsync, vsync => vsync, hc => hc, vc => vc, vidon => vidon);
    VGA_PROM_c : VGA_PROM_2 port map(clk_1hz => clk_1hz, hc => hc, vc => vc, vidon => vidon, M => M, ROM_ADDR => ROM_ADDR17, RGB => RGB, sw => sw);
    PROM_c : blk_mem_gen_2 port map(clka => clk25, addra => ROM_ADDR17, douta => M);
    
end Behavioral;
