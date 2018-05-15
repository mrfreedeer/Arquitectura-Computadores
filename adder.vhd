----------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	 	John Sebastián Luján Figueroa
-- 
-- Create Date:    	16:13:07 04/10/2018 
-- Design Name: 	adder File Design
-- Module Name:    	adder - Behavioral 
-- Project Name: 	Second Processor
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity adder is
    Port ( A : in  STD_LOGIC_VECTOR(31 downto 0);
           B : in  STD_LOGIC_VECTOR(31 downto 0);
           C : out  STD_LOGIC_VECTOR(31 downto 0));
end adder;

architecture adder_arq of adder is

begin
C <= STD_LOGIC_VECTOR(UNSIGNED(A) + UNSIGNED(B));

end adder_arq;

