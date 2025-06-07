----------------------------------------------------------------------------------
-- Company: University of Montpellier
-- Engineer: Bekdouche Amine Adel
-- 
-- Create Date: [Insert actual date]
-- Design Name: M2-FPGA
-- Module Name: VGA_PROM - Behavioral
-- Project Name: FPGA Crash Course
-- Target Devices: Xilinx Artix-7 (or your specific FPGA)
-- Tool Versions: Vivado 2023.1 (or your actual version)
-- Description: 
-- This module implements a sprite renderer for VGA display using a ROM-based 
-- pixel pattern. The sprite can be moved across the screen using directional 
-- switches (sw). The module calculates the ROM address and pixel index based 
-- on the current horizontal and vertical counters (HC, VC), and outputs a 
-- 12-bit RGB signal when the sprite is visible and video is on.
-- 
-- Inputs:
-- - clk_1hz: Clock signal for sprite movement
-- - HC, VC: Horizontal and vertical pixel counters
-- - VIDON: Video enable signal
-- - M: 32-bit ROM data input
-- - sw: 4-bit switch input for movement direction
-- 
-- Outputs:
-- - ROM_ADDR4: Lower 4 bits of ROM address for external access
-- - RGB: 12-bit RGB output for VGA display
-- 
-- Dependencies: 
-- IEEE.STD_LOGIC_1164.ALL
-- IEEE.STD_LOGIC_UNSIGNED.ALL
-- IEEE.NUMERIC_STD.ALL
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - Added sprite movement and pixel rendering logic
-- Additional Comments:
-- This module is part of the M2-FPGA educational project at the University 
-- of Montpellier, demonstrating sprite rendering and control on VGA.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VGA_PROM is
    Port ( clk_1hz : in STD_LOGIC;
           HC : in STD_LOGIC_VECTOR (9 downto 0);
           VC : in STD_LOGIC_VECTOR (9 downto 0);
           VIDON : in STD_LOGIC;
           M : in STD_LOGIC_VECTOR (0 to 31);
           ROM_ADDR4 : out STD_LOGIC_VECTOR (3 downto 0);
           RGB : out STD_LOGIC_VECTOR (11 downto 0);
           sw : in STD_LOGIC_VECTOR (3 downto 0));
end VGA_PROM;

architecture Behavioral of VGA_PROM is

constant hbp: std_logic_vector(9 downto 0) :="0010010000"; -- horizontal back porch = 128 + 16 = 144 (ou 96 + 48)
constant vbp: std_logic_vector(9 downto 0) :="0000011111"; -- vertical back porch = 2 + 29 = 31
constant height: std_logic_vector(9 downto 0) :="0000010000"; -- 16 lines
constant width: std_logic_vector(9 downto 0) := "0000100000"; -- 32 pixels

constant dx: std_logic_vector(9 downto 0) :="0000001000"; -- 64
constant dy: std_logic_vector(8 downto 0) :="000001000"; -- 48

signal rom_addr : STD_LOGIC_VECTOR (9 downto 0);
signal rom_pix : STD_LOGIC_VECTOR (9 downto 0); 
signal spriteon : STD_LOGIC;
signal rgb_sig : STD_LOGIC_VECTOR (2 downto 0);

signal x : STD_LOGIC_VECTOR (9 downto 0):= "0000000000";
signal y : STD_LOGIC_VECTOR (8 downto 0):= "000000000";

begin
   game : process(clk_1hz,sw)
   begin
        if clk_1hz'event and clk_1hz = '1' then
            case sw is
                when "0001" => x <= x+dx; y <= y;
                when "0010" => x <= x-dx; y <= y;
                when "0100" => x <= x; y <= y-dy;
                when "1000" => x <= x; y <= y+dy;
                when "0101" => x <= x+dx; y <= y-dy;
                when "1001" => x <= x+dx; y <= y+dy;
                when "0110" => x <= x-dx; y <= y-dy;
                when "1010" => x <= x-dx; y <= y+dy;
                when others => x <= x; y <= y;
            end case;
        end if;
   end process;

   calculate_addr_pix : process(VC, HC, rom_addr, VIDON, spriteon, rom_pix)
    variable j: integer;
    begin
        j:= conv_integer(rom_pix);
        rgb_sig <= M(j)&M(j)&M(j);
        
        if spriteon = '1' and VIDON = '1' then
            RGB <= rgb_sig(0)&rgb_sig(0)&rgb_sig(0)&rgb_sig(0)&rgb_sig(1)&rgb_sig(1)&rgb_sig(1)&rgb_sig(1)&rgb_sig(2)&rgb_sig(2)&rgb_sig(2)&rgb_sig(2);
        else
            RGB <= "000000000000";
        end if;
    end process;

    rom_addr <= VC-vbp-y;
    rom_pix <= HC-hbp-x;
    
    ROM_ADDR4 <= rom_addr(3 downto 0);
    
    spriteon <= '1' when ((HC > hbp+x)
    and (HC < hbp+width+x) 
    and (VC > vbp+y)
    and (VC < vbp+height+y)) else '0';
    
end Behavioral;