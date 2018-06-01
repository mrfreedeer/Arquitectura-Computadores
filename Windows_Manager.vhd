----------------------------------------------------------------------------------

-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--					John Sebastián Luján Figueroa
-- 
-- Create Date: 		16:53:58 04/26/2018 
-- Design Name: 		Windows_Manager File Design
-- Module Name:    	Windows_Manager - Behavioral 
-- Project Name: 		Third Processor

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_arith.all;

entity Windows_Manager is
    Port ( RS1 : in  STD_LOGIC_VECTOR (4 downto 0);
           RS2 : in  STD_LOGIC_VECTOR (4 downto 0);
           RD : in  STD_LOGIC_VECTOR (4 downto 0);
           OP : in  STD_LOGIC_VECTOR (1 downto 0);
           OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
           CWP : in  STD_LOGIC;
           nRS1 : out  STD_LOGIC_VECTOR (5 downto 0);
           nRS2 : out STD_LOGIC_VECTOR (5 downto 0);
           nRD : out  STD_LOGIC_VECTOR (5 downto 0);
           o7 : out  STD_LOGIC_VECTOR (5 downto 0);
			  nCWP : out STD_LOGIC);
end Windows_Manager;

architecture Behavioral of Windows_Manager is
begin
	process(RS1, RS2, RD, OP, OP3, CWP)
	variable nCWP_aux : std_logic;
	begin
		if OP = "10" then
			if (OP3 = "111100")  then -- SAVE
				nCWP_aux := '0';
			elsif (OP3 = "111101") then -- RESTORE
				nCWP_aux := '1';
			else
				nCWP_aux := CWP;
			end if;
			nCWP <= nCWP_aux;
		end if;
		
		
		if ( RS1>= "11000" and RS1 <= "11111") then
			nRS1 <=conv_std_logic_vector(conv_integer(RS1) - conv_integer(CWP)* 16, 6) ;
		elsif (RS1>= "10000" and RS1 <= "10111") then
			nRS1 <= conv_std_logic_vector(conv_integer(RS1) + conv_integer(CWP) * 16,6) ;
		elsif ( RS1>= "01000" and RS1 <= "01111") then
			nRS1 <= conv_std_logic_vector(conv_integer(RS1) + conv_integer(CWP) * 16,6) ;
		else 
			nRS1(4 downto 0) <=  RS1;
			nRS1 (5) <= '0';
		end if;
		
		if ( RS2>= "11000" and RS2 <= "11111") then
			nRS2 <=conv_std_logic_vector(conv_integer(RS2) - conv_integer(CWP)* 16, 6) ;
		elsif (RS2>= "10000" and RS2 <= "10111") then
			nRS2 <= conv_std_logic_vector(conv_integer(RS2) + conv_integer(CWP) * 16,6) ;
		elsif ( RS2>= "01000" and RS2 <= "01111") then
			nRS2 <= conv_std_logic_vector(conv_integer(RS2) + conv_integer(CWP) * 16,6) ;
		else 
			nRS2(4 downto 0) <=  RS2;
			nRS2 (5) <= '0';
		end if;
		
		if ( RD>= "11000" and RD <= "11111") then
			nRD <=conv_std_logic_vector(conv_integer(RD) - conv_integer(nCWP_aux)* 16, 6) ;
		elsif (RD>= "10000" and RD <= "10111") then
			nRD <= conv_std_logic_vector(conv_integer(RD) + conv_integer(nCWP_aux) * 16,6) ;
		elsif ( RD>= "01000" and RD <= "01111") then
			nRD <= conv_std_logic_vector(conv_integer(RD) + conv_integer(nCWP_aux) * 16,6) ;
		else 
			nRD(4 downto 0) <=  RD;
			nRD (5) <= '0';
		end if;
		
		if ( nCWP_aux = '0') then
			o7 <= "001111";
		else
			o7 <= "011111";
		end if;

	end process;

end Behavioral;

