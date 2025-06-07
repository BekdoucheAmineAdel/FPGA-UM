----------------------------------------------------------------------------------
-- Company: University of Montpellier
-- Engineer: Bekdouche Amine Adel
-- 
-- Create Date: 11.10.2023 10:59:38
-- Design Name: M1-FPGA
-- Module Name: fdc_tb - Behavioral
-- Project Name: FPGA Crash Course
-- Target Devices: Xilinx Artix-7 (or your specific FPGA)
-- Tool Versions: Vivado 2023.1 (or your actual version)
-- Description: 
-- This is the testbench for the fdc module, which simulates a 4-way intersection 
-- traffic light controller with pedestrian buttons. The testbench generates 
-- clock and reset signals, and simulates pedestrian button presses (bph, bpv) 
-- to verify correct FSM transitions and output signal behavior.
-- 
-- Dependencies: 
-- fdc.vhd
-- IEEE.STD_LOGIC_1164.ALL
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - Added stimulus for pedestrian buttons and clock
-- Additional Comments:
-- This testbench is part of the M1-FPGA educational project at the University 
-- of Montpellier, used to validate the FSM logic for traffic light control.
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

entity fdc_tb is
--  Port ( );
end fdc_tb;

architecture Behavioral of fdc_tb is

component fdc is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           bph : in STD_LOGIC;
           bpv : in STD_LOGIC;
           vh : out STD_LOGIC;
           vv : out STD_LOGIC;
           yh : out STD_LOGIC;
           yv : out STD_LOGIC;
           rh : out STD_LOGIC;
           rv : out STD_LOGIC);
end component;

signal clk,rst,bph,bpv,vh,vv,yh,yv,rh,rv : STD_LOGIC;
begin
    fdc_comp : fdc port map(clk,rst,bph,bpv,vh,vv,yh,yv,rh,rv);
    ----------------------------------------------
    process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;
    ----------------------------------------------
    process
    begin
        rst <= '1';
        wait for 1ns;
        rst <= '0';
        wait;
    end process;
    ----------------------------------------------
    process
    begin
        bph <= '0';
        wait for 400ns;
        bph <= '1';
        wait for 20 ns;
        bph <= '0';
        wait;
    end process;
    ----------------------------------------------
    process
    begin
        bpv <= '0';
        wait for 500ns;
        bpv <= '1';
        wait for 20 ns;
        bpv <= '0';
        wait;
    end process;
    ----------------------------------------------
end Behavioral;
