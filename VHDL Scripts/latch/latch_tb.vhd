----------------------------------------------------------------------------------
-- Company: University of Montpellier
-- Engineer: Bekdouche Amine Adel
-- 
-- Create Date: 04.10.2023 10:05:48
-- Design Name: M1-FPGA
-- Module Name: latch_tb - Behavioral
-- Project Name: FPGA Crash Course
-- Target Devices: Xilinx Artix-7 (or your specific FPGA)
-- Tool Versions: Vivado 2023.1 (or your actual version)
-- Description: 
-- This is the testbench for the latch module. It simulates the behavior of a 
-- level-sensitive latch with data (D) and enable (H) inputs. The testbench 
-- applies various input transitions to verify correct latch operation and 
-- output response (Q and QB).
-- 
-- Dependencies: 
-- latch.vhd
-- IEEE.STD_LOGIC_1164.ALL
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - Added test scenarios for data and enable transitions
-- Additional Comments:
-- This testbench is part of the M1-FPGA educational project at the University 
-- of Montpellier, used to validate the latch module through simulation.
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

entity latch_tb is
--  Port ( );
end latch_tb;

architecture Behavioral of latch_tb is

component latch is
    Port ( d : in STD_LOGIC;
           h : in STD_LOGIC;
           q : out STD_LOGIC;
           qb : out STD_LOGIC);
end component;

signal d,h: STD_LOGIC;
signal q,qb: STD_LOGIC;

begin
    cmp : latch port map (d,h,q,qb);
    
    process
    begin
        h <= '0';
        wait for 5ns;
        h <= '1';
        wait for 5ns;
    end process;
    
    process
    begin
        d <= '0';
        wait for 1ns;
        d <= '1';
        wait for 5ns;
        d <= '0';
        wait;
    end process;
end Behavioral;
