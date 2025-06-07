----------------------------------------------------------------------------------
-- Company: University of Montpellier
-- Engineer: Bekdouche Amine Adel
-- 
-- Create Date: [Insert actual date if different]
-- Design Name: M2-FPGA
-- Module Name: gen_pixel_clk - Behavioral
-- Project Name: FPGA Crash Course
-- Target Devices: Xilinx Artix-7 (or your specific FPGA)
-- Tool Versions: Vivado 2023.1 (or your actual version)
-- Description: 
-- This module generates two clock signals from a high-frequency input clock:
-- - clk25: a 25 MHz pixel clock derived by dividing the input clock
-- - clk_1hz: a 1 Hz signal generated using a 25-bit counter
-- The module uses synchronous logic with reset support and is intended for 
-- timing control in video or display applications.
-- 
-- Dependencies: 
-- IEEE.STD_LOGIC_1164.ALL
-- IEEE.STD_LOGIC_ARITH.ALL
-- IEEE.STD_LOGIC_UNSIGNED.ALL
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - Added 1 Hz and 25 MHz clock generation logic
-- Additional Comments:
-- This module is part of the M2-FPGA educational project at the University 
-- of Montpellier, demonstrating clock division and timing signal generation.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity gen_pixel_clk is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           clk25 : out STD_LOGIC;
           clk_1hz : out STD_LOGIC);
end gen_pixel_clk;

architecture Behavioral of gen_pixel_clk is
signal compteur : STD_LOGIC_VECTOR(2 downto 0);
signal compteur2 : STD_LOGIC_VECTOR(24 downto 0);

begin

process(clk, rst) is
begin
    if rst = '1' then
        compteur <= "000";
        compteur2 <= "0000000000000000000000000";
    elsif clk'event and clk = '1' then
        compteur <= compteur + 1;
        compteur2 <= compteur2 + 1;
        
        if compteur2 < "0101111101011110000100000" then
            clk_1hz <= '1';
                           
        elsif compteur2 < "1011111010111100001000000" then
            clk_1hz <= '0';
        else
            clk_1hz <= '1';
            compteur2 <= "0000000000000000000000000";
        end if;
        
        if compteur < "001" then
            clk25 <= '1';
        elsif compteur < "011" then
            clk25 <= '0';
        else
            clk25 <= '1';
            compteur <= "000";
        end if;
        
    end if;
end process;

end Behavioral;