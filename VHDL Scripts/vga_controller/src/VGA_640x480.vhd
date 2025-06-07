----------------------------------------------------------------------------------
-- Company: University of Montpellier
-- Engineer: Bekdouche Amine Adel
-- 
-- Create Date: [Insert actual date if needed]
-- Design Name: M2-FPGA
-- Module Name: gen_pixel_clk - Behavioral
-- Project Name: FPGA Crash Course
-- Target Devices: Xilinx Artix-7 (or your specific FPGA)
-- Tool Versions: Vivado 2023.1 (or your actual version)
-- Description: 
-- This module generates two derived clock signals from a high-frequency input:
-- - clk25: a 25 MHz pixel clock for video timing
-- - clk_1hz: a 1 Hz signal for slow timing or blinking indicators
-- The design uses two counters to divide the input clock and includes a reset.
-- 
-- Dependencies: 
-- IEEE.STD_LOGIC_1164.ALL
-- IEEE.STD_LOGIC_ARITH.ALL
-- IEEE.STD_LOGIC_UNSIGNED.ALL
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - Added 25 MHz and 1 Hz clock generation logic
-- Additional Comments:
-- This module is part of the M2-FPGA educational project at the University 
-- of Montpellier, demonstrating clock division and timing signal generation.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity VGA_640x480 is
    Port ( clk25 : in STD_LOGIC;
           rst : in STD_LOGIC;
           hsync : out STD_LOGIC;
           vsync : out STD_LOGIC;
           hc : out STD_LOGIC_VECTOR (9 downto 0);
           vc : out STD_LOGIC_VECTOR (9 downto 0);
           vidon : out STD_LOGIC);
end VGA_640x480;

architecture Behavioral of VGA_640x480 is
-- definition of constantes
constant hpixels: std_logic_vector(9 downto 0) :="1100100000"; -- nombre de px sur une ligne = 800
constant vlines: std_logic_vector(9 downto 0) :="1000001001"; -- nombre (total) de ligne horizontale 521
constant hbp: std_logic_vector(9 downto 0) :="0010010000"; -- horizontal back porch = 128 + 16 = 144 (ou 96 + 48)
constant hfp: std_logic_vector(9 downto 0) :="1100010000"; -- horizontal front porch = 128 + 16 + 640 = 784
constant vbp: std_logic_vector(9 downto 0) :="0000011111"; -- vertical back porch = 2 + 29 = 31
constant vfp: std_logic_vector(9 downto 0) :="0111111111"; -- vertical front porch = 2 + 29 + 480 + 10 = 511
-- definition of signals
signal hcs : std_logic_vector(9 downto 0); -- :="0000000000" ; -- compteur horizontal / vertical
signal vcs: std_logic_vector(9 downto 0) ;-- :="0000000000" ; -- compteur horizontal / vertical
signal vsenable: std_logic := '0'; -- enable pour le compteur vertical

-- start of program
begin
    process(clk25, rst)
    begin
    
    if rst='1' then hcs <= "0000000000"; -- ou if rst='1' then hcs <= (other => '0');
    elsif rising_edge(clk25) then 
        if hcs = (hpixels - 1) then 
           hcs <= "0000000000";
           vsenable <='1';
        else 
           hcs <= (hcs + 1) ; 
           vsenable <='0';
        end if;
    end if;
    end process;
    
    -- Compteur pour le signal de synchro virticale vcs
    process(clk25, rst)
    begin
    if rst='1' then vcs <= "0000000000";
    elsif rising_edge(clk25) then 
        if vsenable='1' then
            if vcs =(vlines - 1) then
              vcs <= "0000000000";
            else
              vcs <=vcs + 1;
            end if;
        end if;
    end if;
    end process;
    
    -- Generation des signaux de sortie
    hsync <= '0' when hcs < 96 else '1';
    vsync <= '0' when vcs < 2 else '1';
    
    vidon <= '1' when ((hcs>=hbp) and (hcs<hfp) and (vcs>=vbp) and (vcs<vfp)) else '0';
    hc <= hcs;
    vc <= vcs;
	
	
end Behavioral;
