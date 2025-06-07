----------------------------------------------------------------------------------
-- Company: University of Montpellier
-- Engineer: Bekdouche Amine Adel
-- 
-- Create Date: 04.10.2023 09:58:22
-- Design Name: M1-FPGA
-- Module Name: latch - Behavioral
-- Project Name: FPGA Crash Course
-- Target Devices: Xilinx Artix-7 (or your specific FPGA)
-- Tool Versions: Vivado 2023.1 (or your actual version)
-- Description: 
-- This module implements a level-sensitive D latch. When the enable signal (H) 
-- is high, the output Q follows the input D. When H is low, the output retains 
-- its last state. The complementary output QB is also provided.
-- 
-- Dependencies: 
-- IEEE.STD_LOGIC_1164.ALL
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - Added internal signal for latch state and complementary output
-- Additional Comments:
-- This module is part of the M1-FPGA educational project at the University 
-- of Montpellier, designed to demonstrate basic latch behavior in VHDL.
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

entity latch is
    Port ( d : in STD_LOGIC;
           h : in STD_LOGIC;
           q : out STD_LOGIC;
           qb : out STD_LOGIC);
end latch;

architecture Behavioral of latch is

signal qtemp : STD_LOGIC;
begin
    basc_latch: process (h,d)
    begin
        if h = '1' then
            qtemp <= d;
        else
            qtemp <= qtemp;
        end if;
    q <= qtemp;
    qb <= not(qtemp);
    end process;
end Behavioral;
