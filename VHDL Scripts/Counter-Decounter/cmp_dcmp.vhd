----------------------------------------------------------------------------------
-- Company: University of Montpellier
-- Engineer: Amine Adel Bekdouche
-- 
-- Create Date: 04.10.2023 11:39:35
-- Design Name: M1-FPGA
-- Module Name: cmp_dcmp - Behavioral
-- Project Name: FPGA Crash Course
-- Target Devices: Xilinx Artix-7 (or your specific FPGA)
-- Tool Versions: Vivado 2023.1 (or your actual version)
-- Description: 
-- This module implements a counter/decounter (increment/decrement) logic.
-- It counts up or down based on a control signal. The counter can be used 
-- for timing, sequencing, or control applications in digital systems.
-- 
-- Dependencies: 
-- IEEE.STD_LOGIC_1164.ALL
-- IEEE.NUMERIC_STD.ALL
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - Added synchronous reset and enable control
-- Additional Comments:
-- This module is part of the M1-FPGA educational project at the University of 
-- Montpellier, designed to teach digital design using VHDL and FPGA tools.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cmp_dcmp is
    Port ( cmd : in STD_LOGIC;
           reset : in STD_LOGIC;
           h : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (7 downto 0));
end cmp_dcmp;

architecture Behavioral of cmp_dcmp is
signal temp : STD_LOGIC_VECTOR (7 downto 0);
begin
    process (h,reset,cmd)
    begin
        if reset = '1' then
            temp <= "00000000";
        elsif h'event and h='1' then
            if cmd = '0' then
            temp <= temp + 1;
            else
            temp <= temp - 1;
            end if;
        end if;
       output <= temp;
    end process;
end Behavioral;
