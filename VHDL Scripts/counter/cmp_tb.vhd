----------------------------------------------------------------------------------
-- Company: University of Montpellier
-- Engineer: Bekdouche Amine Adel
-- 
-- Create Date: 04.10.2023 11:16:44
-- Design Name: M1-FPGA
-- Module Name: compteur_tb - Behavioral
-- Project Name: FPGA Crash Course
-- Target Devices: Xilinx Artix-7 (or your specific FPGA)
-- Tool Versions: Vivado 2023.1 (or your actual version)
-- Description: 
-- This is the testbench for the compteur module. It simulates the behavior of 
-- an 8-bit synchronous counter with reset. The testbench generates a clock 
-- signal and applies a reset pulse to verify correct counting behavior.
-- 
-- Dependencies: 
-- compteur.vhd
-- IEEE.STD_LOGIC_1164.ALL
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - Added clock generation and reset stimulus
-- Additional Comments:
-- This testbench is part of the M1-FPGA educational project at the University 
-- of Montpellier, used to validate the compteur module through simulation.
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

entity compteur_tb is
--  Port ( );
end compteur_tb;

architecture Behavioral of compteur_tb is

component compteur is
    Port ( h: in STD_LOGIC;
            reset : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal reset,h : STD_LOGIC;
signal output : STD_LOGIC_VECTOR (7 downto 0);
begin
    cmp : compteur port map (h,reset,output);
    
    process
    begin
        h <= '1';
        wait for 1 ns;
        h <= '0';
        wait for 1 ns;
    end process;
    
    process
    begin
        reset <= '0';
        wait for 50ns;
        reset <= '1';
        wait for 10ns;
    end process;
    
end Behavioral;
