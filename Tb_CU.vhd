----------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--		John Sebastián Luján Figueroa
-- 
-- Create Date:    	17:06:40 04/10/2018
-- Design Name: 	Tb_CU File Design
-- Module Name:   	Tb_CU - Behavioral 
-- Project Name: 	First Processor
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Tb_CU IS
END Tb_CU;
 
ARCHITECTURE behavior OF Tb_CU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CU
    PORT(
         OP : IN  std_logic_vector(1 downto 0);
         OP3 : IN  std_logic_vector(5 downto 0);
         ALUOP : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal OP : std_logic_vector(1 downto 0) := (others => '0');
   signal OP3 : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal ALUOP : std_logic_vector(5 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CU PORT MAP (
          OP => OP,
          OP3 => OP3,
          ALUOP => ALUOP
        );


   -- Stimulus process
   stim_proc: process
   begin		
	
		OP <= "00";
      -- hold reset state for 100 ns.
      wait for 100 ns;

		
		OP <= "01";
		OP3 <= "000000";
      wait for 100 ns;	
		
		OP <= "01";
		OP3 <= "000001";
      wait for 100 ns;	
		
		OP <= "01";
		OP3 <= "000010";
      wait for 100 ns;	
		
		OP <= "01";
		OP3 <= "000011";
      wait for 100 ns;	
		
		OP <= "01";
		OP3 <= "000100";
      wait for 100 ns;	
		
		OP <= "01";
		OP3 <= "000101";
      wait for 100 ns;	
		
		OP <= "01";
		OP3 <= "000110";
      wait for 100 ns;	

		OP <= "01";
		OP3 <= "000111";
      wait for 100 ns;	


      -- insert stimulus here 

      wait;
   end process;

END;
