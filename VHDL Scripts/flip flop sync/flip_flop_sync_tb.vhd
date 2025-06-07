----------------------------------------------------------------------------------
-- Company: University of Montpellier
-- Engineer: Amine Adel Bekdouche
-- 
-- Create Date: 04.10.2023 10:33:23
-- Design Name: M1-FPGA
-- Module Name: flip_flop_sync_tb - Behavioral
-- Project Name: FPGA Crash Course
-- Target Devices: Xilinx Artix-7 (or your specific FPGA)
-- Tool Versions: Vivado 2023.1 (or your actual version)
-- Description: 
-- This is the testbench for the flip_flop_sync module. It simulates the 
-- behavior of a synchronous SR flip-flop with data input and clock signal. 
-- The testbench applies various input combinations to verify correct 
-- functionality of set, reset, and data operations on clock edges.
-- 
-- Dependencies: 
-- flip_flop_sync.vhd
-- IEEE.STD_LOGIC_1164.ALL
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - Added test scenarios for set, reset, and data input
-- Additional Comments:
-- This testbench is part of the M1-FPGA educational project at the University 
-- of Montpellier, used to validate the flip-flop module through simulation.
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

entity flip_flop_sync_tb is
--  Port ( );
end flip_flop_sync_tb;

architecture Behavioral of flip_flop_sync_tb is

component flip_flop_sync is
    Port ( r : in STD_LOGIC;
           s : in STD_LOGIC;
           d : in STD_LOGIC;
           q : out STD_LOGIC;
           qb : out STD_LOGIC;
           h : in STD_LOGIC);
end component;

signal r,s,d,q,qb,h : STD_LOGIC;

begin
    cmp : flip_flop_sync port map (r,s,d,q,qb,h);
    
    process
    begin
        h <= '0';
        wait for 5ns;
        h <= '1';
        wait for 5ns;
    end process;
    
    process
    begin
        r <= '0';
        wait for 1ns;
        r <= '1';
        wait for 1ns;
        r <= '0';
        wait for 1ns;
        r <= '1';
        wait for 3ns;
        r <= '0';
        wait;
    end process;
    
    process
    begin
        s <= '0';
        wait for 12ns;
        s <= '1';
        wait for 1ns;
        s <= '0';
        wait for 1ns;
        s <= '1';
        wait for 2ns;
        s <= '0';
        wait;
    end process;
    
        process
    begin
        d <= '1';
        wait for 11ns;
        d <= '0';
        wait for 15ns;
        d <= '1';
        wait for 1ns;
        d <= '0';
        wait;
    end process;
end Behavioral;
