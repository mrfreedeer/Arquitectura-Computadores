-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--		John Sebastián Luján Figueroa
-- 
-- Create Date: 	17:06:01 04/10/2018
-- Design Name: 	PSR File Design
-- Module Name:    	PSR - Behavioral 
-- Project Name: 	First Processor

--

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSR is
    Port (  icc : in STD_LOGIC_VECTOR (3 downto 0); -- NZVC
            nCWP : in STD_LOGIC;
            C : out STD_LOGIC;
            CWP : out STD_LOGIC -- Current Window Pointer
            );
end PSR;

architecture Behavioral of PSR is

begin

CWP <= nCWP;
C <= icc(0);

end Behavioral;