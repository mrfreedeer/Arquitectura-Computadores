--------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--		John Sebastián Luján Figueroa
-- 
-- Create Date: 	16:33:21 04/26/2018
-- Design Name: 	PSR_Modifier File Design
-- Module Name:   PSR_Modifier - Behavioral 
-- Project Name: 	First Processor

--

----------------------------------------------------------------------------------


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Tb_PSR_Modifier IS
END Tb_PSR_Modifier;
 
ARCHITECTURE behavior OF Tb_PSR_Modifier IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PSR_Modifier
    PORT(
         CRS1 : IN  std_logic_vector(31 downto 0);
         RMUX : IN  std_logic_vector(31 downto 0);
         ALUOP : IN  std_logic_vector(5 downto 0);
         DWR : IN  std_logic_vector(31 downto 0);
         icc : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CRS1 : std_logic_vector(31 downto 0) := (others => '0');
   signal RMUX : std_logic_vector(31 downto 0) := (others => '0');
   signal ALUOP : std_logic_vector(5 downto 0) := (others => '0');
   signal DWR : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal icc : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSR_Modifier PORT MAP (
          CRS1 => CRS1,
          RMUX => RMUX,
          ALUOP => ALUOP,
          DWR => DWR,
          icc => icc
        );

   -- Clock process definitions
   -- Stimulus process
   stim_proc: process
   begin		
		CRS1 <= X"0FFFFFFF";
		RMUX <= X"0DA11111";
		ALUOP <=  "010001";
		DWR <= X"FFFFFFFF";
      -- hold reset state for 100 ns.
      wait for 40 ns;	
		
		CRS1 <= X"AFAF1111";
		RMUX <= X"ADADADAD";
		ALUOP <= "010000";
		DWR <= X"5D5CBEBE";
		
		wait for 100 ns;
   

      -- insert stimulus here 

      wait;
   end process;

END;
