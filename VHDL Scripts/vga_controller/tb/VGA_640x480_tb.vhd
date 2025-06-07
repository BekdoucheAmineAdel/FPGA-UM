----------------------------------------------------------------------------------
-- Company: University of Montpellier
-- Engineer: Bekdouche Amine Adel
-- 
-- Create Date: [Insert actual date]
-- Design Name: M2-FPGA
-- Module Name: VGA_640x480_tb - Behavioral
-- Project Name: FPGA Crash Course
-- Target Devices: Xilinx Artix-7 (or your specific FPGA)
-- Tool Versions: Vivado 2023.1 (or your actual version)
-- Description: 
-- This is the testbench for the VGA_640x480 module. It simulates the behavior 
-- of a VGA timing generator for 640x480 resolution at 60 Hz. The testbench 
-- generates a 25 MHz clock and applies a reset pulse to verify correct 
-- synchronization signal generation (hsync, vsync) and pixel timing (hc, vc).
-- 
-- Dependencies: 
-- VGA_640x480.vhd
-- IEEE.STD_LOGIC_1164.ALL
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - Added clock and reset stimulus for simulation
-- Additional Comments:
-- This testbench is part of the M2-FPGA educational project at the University 
-- of Montpellier, used to validate VGA timing logic through simulation.
----------------------------------------------------------------------------------
entity VGA_640x480_tb is
end VGA_640x480_tb;

architecture Behavioral of VGA_640x480_tb is

    signal clk25,rst,hsync,vsync,vidon : STD_LOGIC;
    signal hc,vc : STD_LOGIC_VECTOR (9 downto 0);
    component VGA_640x480 is
        Port ( clk25 : in STD_LOGIC;
               rst : in STD_LOGIC;
               hsync : out STD_LOGIC;
               vsync : out STD_LOGIC;
               hc : out STD_LOGIC_VECTOR (9 downto 0);
               vc : out STD_LOGIC_VECTOR (9 downto 0);
               vidon : out STD_LOGIC);
    end component;

begin

    VGA_640x480_test : VGA_640x480 port map(clk25 => clk25, rst => rst, hsync => hsync, vsync => vsync, hc => hc, vc => vc, vidon => vidon);
    clock : process is
    begin
        clk25 <= '0';
        wait for 20ns;
        clk25 <= '1';
        wait for 20ns;
    end process; 
    reset : process is
    begin
        rst <= '0';
        wait for 21ns;
        rst <= '1';
        wait for 2ns;
        rst <= '0';
        wait;
    end process;
    
end Behavioral;
