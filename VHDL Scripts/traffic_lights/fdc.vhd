----------------------------------------------------------------------------------
-- Company: University of Montpellier
-- Engineer: Bekdouche Amine Adel
-- 
-- Create Date: 11.10.2023 10:15:43
-- Design Name: M1-FPGA
-- Module Name: fdc - Behavioral
-- Project Name: FPGA Crash Course
-- Target Devices: Xilinx Artix-7 (or your specific FPGA)
-- Tool Versions: Vivado 2023.1 (or your actual version)
-- Description: 
-- This module implements a finite state machine (FSM) for controlling traffic 
-- lights at a 4-way intersection. It manages vehicle signals and pedestrian 
-- crossing requests using input buttons (bph for horizontal, bpv for vertical).
-- The FSM cycles through states to allow safe and timed transitions between 
-- vehicle and pedestrian phases, ensuring proper synchronization.
-- 
-- Dependencies: 
-- IEEE.STD_LOGIC_1164.ALL
-- IEEE.STD_LOGIC_ARITH.ALL
-- IEEE.STD_LOGIC_UNSIGNED.ALL
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - FSM logic implemented for traffic and pedestrian control
-- Additional Comments:
-- This module is part of the M1-FPGA educational project at the University 
-- of Montpellier, designed to demonstrate FSM-based traffic light control.
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

entity fdc is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           bph : in STD_LOGIC;
           bpv : in STD_LOGIC;
           vh : out STD_LOGIC;
           vv : out STD_LOGIC;
           yh : out STD_LOGIC;
           yv : out STD_LOGIC;
           rh : out STD_LOGIC;
           rv : out STD_LOGIC);
end fdc;

architecture Behavioral of fdc is

type StateType is (ETA_VH,ETA_YH,ETA_PH,ETA_VV,ETA_YV,ETA_PV);

signal temp : STD_LOGIC_VECTOR (3 downto 0);
signal present_state, next_state : StateType;

begin
    ----------------------------------------------
    state_clk : process(clk,rst)
    begin
        if rst = '1' then
            temp <= "0000";
            present_state <= ETA_VH;
        elsif clk'event and clk='1' then
            temp <= temp + 1;
            present_state <= next_state;
            if present_state /= next_state then
               temp <= "0000";
            end if;
        end if;
    end process state_clk;
    ----------------------------------------------
    state_switcher : process(present_state,temp,bph,bpv)
    begin    
        case present_state is
            when ETA_VH =>  vv <= '0';
                            yv <= '0';
                            rv <= '1';
                            vh <= '1';
                            yh <= '0';
                            rh <= '0';
                            if temp = "1110" then
                                next_state <= ETA_YH;
                            elsif bph = '1' then
                                next_state <= ETA_PH;
                            else
                                next_state <= ETA_VH;
                            end if;
            when ETA_YH =>  vv <= '0';
                            yv <= '0';
                            rv <= '1';
                            vh <= '0';
                            yh <= '1';
                            rh <= '0';
                            if temp = "0010" then
                                next_state <= ETA_VV;
                            else
                                next_state <= ETA_YH;
                            end if;
            when ETA_PH =>  vv <= '0';
                            yv <= '0';
                            rv <= '1';
                            vh <= '1';
                            yh <= '0';
                            rh <= '0';
                            if temp = "0011" then
                                next_state <= ETA_YH;
                            else
                                next_state <= ETA_PH;
                            end if;
            when ETA_VV =>  vv <= '1';
                            yv <= '0';
                            rv <= '0';
                            vh <= '0';
                            yh <= '0';
                            rh <= '1';
                            if temp = "1110" then
                                next_state <= ETA_YV;
                            elsif bpv = '1' then
                                next_state <= ETA_PV;
                            else
                                next_state <= ETA_VV;
                            end if;
            when ETA_YV =>  vv <= '0';
                            yv <= '1';
                            rv <= '0';
                            vh <= '0';
                            yh <= '0';
                            rh <= '0';
                            if temp = "0010" then
                                next_state <= ETA_VH;
                            else
                                next_state <= ETA_YV;
                            end if;
            when others =>  vv <= '1';
                            yv <= '0';
                            rv <= '0';
                            vh <= '0';
                            yh <= '0';
                            rh <= '1';
                            if temp = "0011" then
                                next_state <= ETA_YV;
                            else
                                next_state <= ETA_PV;
                            end if;
        end case;
    end process state_switcher;
    ----------------------------------------------
end Behavioral;
