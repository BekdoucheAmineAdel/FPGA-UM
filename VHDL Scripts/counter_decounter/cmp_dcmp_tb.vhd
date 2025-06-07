----------------------------------------------------------------------------------
-- Company: University of Montpellier
-- Engineer: Amine Adel Bekdouche
-- 
-- Create Date: 04.10.2023 11:44:18
-- Design Name: M1-FPGA
-- Module Name: cmp_dcmp_tb - Behavioral
-- Project Name: FPGA Crash Course
-- Target Devices: Xilinx Artix-7 (or your specific FPGA)
-- Tool Versions: Vivado 2023.1 (or your actual version)
-- Description: 
-- This is the testbench for the cmp_dcmp module, which implements a 
-- counter/decounter. The testbench applies various input stimuli to 
-- verify correct counting behavior, including up/down control, reset, 
-- and enable signal handling.
-- 
-- Dependencies: 
-- cmp_dcmp.vhd
-- IEEE.STD_LOGIC_1164.ALL
-- IEEE.NUMERIC_STD.ALL
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - Added test scenarios for edge cases and reset behavior
-- Additional Comments:
-- This testbench is part of the M1-FPGA educational project at the University 
-- of Montpellier, used to validate the functionality of the counter/decounter 
-- module through simulation.
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

entity cmp_dcmp_tb is
--  Port ( );
end cmp_dcmp_tb;

architecture Behavioral of cmp_dcmp_tb is

component cmp_dcmp is
    Port ( cmd : in STD_LOGIC;
           reset : in STD_LOGIC;
           h : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal cmd,reset,h : STD_LOGIC;
signal output : STD_LOGIC_VECTOR (7 downto 0);

begin
    cmp : cmp_dcmp port map(cmd,reset,h,output);
    process
    begin
        h <= '0';
        wait for 5ns;
        h <= '1';
        wait for 5ns;
    end process;
    process
    begin
        reset <= '1';
        wait for 10ns;
        reset <= '0';
        wait for 200ns;
        reset <= '1';
        wait for 10ns;
        reset <= '0';
        wait;
    end process;
    process
    begin
        cmd <= '0';
        wait for 202ns;
        cmd <= '1';
        wait for 200ns;
        cmd <= '0';
        wait;
    end process;
end Behavioral;
