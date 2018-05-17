----------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	 				John Sebastián Luján Figueroa
-- 
-- Create Date:    	16:13:07 04/10/2018 
-- Design Name: 		Tb_SEU_13 File Design
-- Module Name:    	Tb_SEU_13 - Behavioral 
-- Project Name: 		Third Processor
----------------------------------------------------------------------------------




LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Tb_SEU_13 IS
END Tb_SEU_13;
 
ARCHITECTURE behavior OF Tb_SEU_13 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SEU_13
    PORT(
         imm13 : IN  std_logic_vector(12 downto 0);
         exto : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal imm13 : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal exto : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SEU_13 PORT MAP (
          imm13 => imm13,
          exto => exto
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
  
	imm13 <= "0110100010110";
      	wait for 20 ns;
	imm13 <= "1110100010110";
      	wait for 20 ns;

      wait;
   end process;

END;
