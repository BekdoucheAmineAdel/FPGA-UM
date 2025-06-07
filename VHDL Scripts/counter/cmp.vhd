----------------------------------------------------------------------------------
-- Company: University of Montpellier
-- Engineer: Amine Adel Bekdouche
-- 
-- Create Date: 04.10.2023 11:08:36
-- Design Name: M1-FPGA
-- Module Name: compteur - Behavioral
-- Project Name: FPGA Crash Course
-- Target Devices: Xilinx Artix-7 (or your specific FPGA)
-- Tool Versions: Vivado 2023.1 (or your actual version)
-- Description: 
-- This module implements a synchronous binary counter. It increments its value 
-- on each rising edge of the clock when enabled. The counter can be reset 
-- synchronously and may include additional features such as terminal count 
-- detection or direction control.
-- 
-- Dependencies: 
-- IEEE.STD_LOGIC_1164.ALL
-- IEEE.NUMERIC_STD.ALL
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - Added asynchronous reset functionality
-- Additional Comments:
-- This module is part of the M1-FPGA educational project at the University 
-- of Montpellier, designed to teach sequential logic and counter design.
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

entity compteur is
    Port ( h : in STD_LOGIC;
           reset : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (7 downto 0));
end compteur;

architecture Behavioral of compteur is

signal temp : STD_LOGIC_VECTOR (7 downto 0);
begin

    process (reset,h)
    begin
        if reset = '1' then
            temp <= "00000000";
        elsif h'event and h='1' then
            temp <= temp + 1;
        end if;
       output <= temp;
    end process;

end Behavioral;
