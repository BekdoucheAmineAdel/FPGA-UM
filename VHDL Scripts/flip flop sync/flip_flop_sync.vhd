----------------------------------------------------------------------------------
-- Company: University of Montpellier
-- Engineer: Amine Adel Bekdouche
-- 
-- Create Date: 04.10.2023 10:27:10
-- Design Name: M1-FPGA
-- Module Name: flip_flop_sync - Behavioral
-- Project Name: FPGA Crash Course
-- Target Devices: Xilinx Artix-7 (or your specific FPGA)
-- Tool Versions: Vivado 2023.1 (or your actual version)
-- Description: 
-- This module implements a synchronous SR flip-flop with data input (D) and 
-- clock signal (H). On the rising edge of the clock, the output Q is updated 
-- based on the state of the reset (R), set (S), and data (D) inputs. The 
-- complementary output QB is also provided.
-- 
-- Dependencies: 
-- IEEE.STD_LOGIC_1164.ALL
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - Added synchronous behavior and complementary output
-- Additional Comments:
-- This module is part of the M1-FPGA educational project at the University 
-- of Montpellier, designed to demonstrate basic sequential logic design.
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

entity flip_flop_sync is
    Port ( r : in STD_LOGIC;
           s : in STD_LOGIC;
           d : in STD_LOGIC;
           q : out STD_LOGIC;
           qb : out STD_LOGIC;
           h : in STD_LOGIC);
end flip_flop_sync;

architecture Behavioral of flip_flop_sync is

signal qtemp : STD_LOGIC;

begin
    process
    begin
        wait until h'event and h = '1';
        if r = '1' then
            qtemp <= '0';
        elsif s = '1' then
            qtemp <= '1';
        else
            qtemp <= d;
        end if;
        
        q <= qtemp;
        qb <= not(qtemp);   
    end process;
end Behavioral;
