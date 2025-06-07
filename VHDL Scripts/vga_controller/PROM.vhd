----------------------------------------------------------------------------------
-- Company: University of Montpellier
-- Engineer: Bekdouche Amine Adel
-- 
-- Create Date: [Insert actual date]
-- Design Name: M2-FPGA
-- Module Name: PROM - Behavioral
-- Project Name: FPGA Crash Course
-- Target Devices: Xilinx Artix-7 (or your specific FPGA)
-- Tool Versions: Vivado 2023.1 (or your actual version)
-- Description: 
-- This module implements a 16-word ROM (Read-Only Memory) with 32-bit wide 
-- output. It is used to store sprite pixel data for VGA display. The ROM is 
-- addressed using a 4-bit input and outputs a 32-bit vector representing a 
-- horizontal line of a sprite.
-- 
-- Inputs:
-- - addr: 4-bit address input to select a ROM line
-- 
-- Outputs:
-- - m: 32-bit output corresponding to the selected ROM line
-- 
-- Dependencies: 
-- IEEE.STD_LOGIC_1164.ALL
-- IEEE.STD_LOGIC_UNSIGNED.ALL
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - Added ROM content for sprite rendering
-- Additional Comments:
-- This ROM is part of the VGA sprite rendering system in the M2-FPGA project 
-- at the University of Montpellier.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PROM is
    Port ( addr : in STD_LOGIC_VECTOR (3 downto 0);
           m : out STD_LOGIC_VECTOR (0 to 31));
end PROM;

architecture Behavioral of PROM is
type rom_array is array (NATURAL range <>) of std_logic_vector(0 to 31);
constant rom:rom_array:= (
                            "0000000000000000",
                            "0111100000101010",
                            "0111101110101010",
                            "0111101010101010",
                            "0111101111111010",
                            "0111100000000000",
                            "0111111101111010",
                            "0111110001000010",
                            "0110000101111010",
                            "0110100100001010",
                            "0110111111111010",
                            "0000100000000000",
                            "0011100100111110",
                            "0000000000111110",
                            "0111111111111110",
                            "0000000000000000"
                         );
begin

process(addr)
    variable j: integer;
    begin
        j:= conv_integer(addr);
        m <= rom(j);
    end process;

end Behavioral;