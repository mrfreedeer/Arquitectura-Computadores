----------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	 	John Sebastián Luján Figueroa
-- 
-- Create Date:    	16:13:07 04/10/2018 
-- Design Name: 	Tb_MUX File Design
-- Module Name:    	Tb_MUX - Behavioral 
-- Project Name: 	Third Processor
---------------------------------------------------------------------------------


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

ENTITY Tb_MUX IS
END Tb_MUX;
 
ARCHITECTURE behavior OF Tb_MUX IS 
 

 
    COMPONENT MUX
    PORT(
         i : IN  std_logic;
         CRS2 : IN  std_logic_vector(31 downto 0);
         IMM : IN  std_logic_vector(31 downto 0);
         RMUX : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal i : std_logic := '0';
   signal CRS2 : std_logic_vector(31 downto 0) := (others => '0');
   signal IMM : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal RMUX : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX PORT MAP (
          i => i,
          CRS2 => CRS2,
          IMM => IMM,
          RMUX => RMUX
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      i<='1';
      CRS2<=(others => '1');
      IMM<=(others => '0');
      wait for 100 ns;
      i<='0';

      -- insert stimulus here 

      wait;
   end process;

END;
