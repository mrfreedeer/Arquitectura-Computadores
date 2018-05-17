----------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	 	John Sebastián Luján Figueroa
-- 
-- Create Date:    	16:13:07 04/10/2018 
-- Design Name: 	Tb_MUX2x1 File Design
-- Module Name:    	Tb_MUX2x1 - Behavioral 
-- Project Name: 	Third Processor
---------------------------------------------------------------------------------


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

ENTITY Tb_MUX2x1 IS
END Tb_MUX2x1;
 
ARCHITECTURE behavior OF Tb_MUX2x1 IS 
 

 
    COMPONENT MUX2x1
    PORT(
         i : IN  std_logic;
         in0 : IN  std_logic_vector(31 downto 0);
         in1 : IN  std_logic_vector(31 downto 0);
         RMUX : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal i : std_logic := '0';
   signal in0 : std_logic_vector(31 downto 0) := (others => '0');
   signal in1 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal RMUX : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX2x1 PORT MAP (
          i => i,
          in0 => in0,
          in1 => in1,
          RMUX => RMUX
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      i<='1';
      in0<=(others => '1');
      in1<=(others => '0');
      wait for 100 ns;
      i<='0';

      -- insert stimulus here 

      wait;
   end process;

END;
