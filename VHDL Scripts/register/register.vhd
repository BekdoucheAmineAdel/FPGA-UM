----------------------------------------------------------------------------------
-- Company: University of Montpellier
-- Engineer: Bekdouche Amine Adel
-- 
-- Create Date: 04.10.2023 12:11:46
-- Design Name: M1-FPGA
-- Module Name: registre - Behavioral
-- Project Name: FPGA Crash Course
-- Target Devices: Xilinx Artix-7 (or your specific FPGA)
-- Tool Versions: Vivado 2023.1 (or your actual version)
-- Description: 
-- This module implements a synchronous register. It stores input data on the 
-- rising edge of the clock when enabled. The register can be used for temporary 
-- data storage, pipelining, or interfacing between modules.
-- 
-- Dependencies: 
-- IEEE.STD_LOGIC_1164.ALL
-- IEEE.NUMERIC_STD.ALL (if using vector operations)
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - Added asynchronous reset functionality
-- Additional Comments:
-- This module is part of the M1-FPGA educational project at the University 
-- of Montpellier, designed to demonstrate basic register design in VHDL.
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

entity registre is
    Port ( h : in STD_LOGIC;
           cmd : in STD_LOGIC_VECTOR (1 downto 0);
           input : in STD_LOGIC_VECTOR (3 downto 0);
           output : out STD_LOGIC_VECTOR (3 downto 0);
           reset : in STD_LOGIC);
end registre;

architecture Behavioral of registre is

signal temp : STD_LOGIC_VECTOR (3 downto 0);
begin
    process
    begin
        if reset = '1' then
         temp <= "0000";
        elsif h'event and h = '1' then
            case cmd is
                when "00" => temp <= input;
                when "01" => temp <= '0'&temp(3 downto 1);
                when "10" => temp <= temp(2 downto 0)&'0';
                when others => temp <= temp;
            end case;
        end if;
    
    end process;
    output <= temp;
end Behavioral;
