----------------------------------------------------------------------------------
-- Company: University of Montpellier
-- Engineer: Bekdouche Amine Adel
-- 
-- Create Date: 04.10.2023 12:17:50
-- Design Name: M1-FPGA
-- Module Name: registre_tb - Behavioral
-- Project Name: FPGA Crash Course
-- Target Devices: Xilinx Artix-7 (or your specific FPGA)
-- Tool Versions: Vivado 2023.1 (or your actual version)
-- Description: 
-- This is the testbench for the registre module. It simulates the behavior of a 
-- 4-bit synchronous register with command control. The testbench applies various 
-- input combinations and clock cycles to verify correct data storage, command 
-- execution, and reset behavior.
-- 
-- Dependencies: 
-- registre.vhd
-- IEEE.STD_LOGIC_1164.ALL
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - Added test scenarios for command inputs and reset
-- Additional Comments:
-- This testbench is part of the M1-FPGA educational project at the University 
-- of Montpellier, used to validate the registre module through simulation.
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

entity registre_tb is
--  Port ( );
end registre_tb;

architecture Behavioral of registre_tb is

component registre is
    Port ( h : in STD_LOGIC;
           cmd : in STD_LOGIC_VECTOR (1 downto 0);
           input : in STD_LOGIC_VECTOR (3 downto 0);
           output : out STD_LOGIC_VECTOR (3 downto 0);
           reset : in STD_LOGIC);
end component;

signal h,reset : STD_LOGIC;
signal cmd : STD_LOGIC_VECTOR (1 downto 0);
signal input,output : STD_LOGIC_VECTOR (3 downto 0);

begin
    cmp : registre port map (h,cmd,input,output,reset);
    
    process
    begin
     h <= '0';
     wait for 5ns;
     h <= '1';
     wait for 5ns;
    end process;
    
    process
    begin
     cmd <= "00";
     input <= "0010";
     wait for 10ns;
     cmd <= "01";
     wait for 10ns;
     cmd <= "10";
     wait for 10ns;
     cmd <= "11";
     wait;
    end process;
    
    process
    begin
     reset <= '0';
     wait for 20ns;
     reset <= '1';
     wait for 10ns;
     reset <= '0';
     wait;
    end process;
    
end Behavioral;
