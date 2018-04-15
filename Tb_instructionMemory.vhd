----------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	 	John Sebastián Luján Figueroa
-- 
-- Create Date:    	16:24:47 04/12/2018
-- Design Name: 	Tb_IntegratedPC File Design
-- Module Name:    	Tb_IntegratedPC - Behavioral 
-- Project Name: 	First Processor

--
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Tb_instructionMemory IS
END Tb_instructionMemory;
 
ARCHITECTURE behavior OF Tb_instructionMemory IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT instructionMemory
    PORT(
         address : IN  std_logic_vector(5 downto 0);
         reset : IN  std_logic;
         outInstruction : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal address : std_logic_vector(5 downto 0) := (others => '0');
   signal reset : std_logic := '0';

 	--Outputs
   signal outInstruction : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: instructionMemory PORT MAP (
          address => address,
          reset => reset,
          outInstruction => outInstruction
        );



   -- Stimulus process
   stim_proc: process
   begin	
	   
	reset <= '1';
	wait for 80 ns;
	   
	reset <= '0';
	address <= "000000";
     	wait for 100 ns;	

      wait;
   end process;

END;
