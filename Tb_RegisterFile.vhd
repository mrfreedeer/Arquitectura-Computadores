----------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--					John Sebastián Luján Figueroa
-- 
-- Create Date: 		16:13:07 04/10/2018 
-- Design Name: 		Register File Design
-- Module Name:    	Test Bench RegisterFile - Behavioral 
-- Project Name: 		Segmented Processor
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Tb_RegisterFile IS
END Tb_RegisterFile;
 
ARCHITECTURE behavior OF Tb_RegisterFile IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterFile
    PORT(
         rs1 : IN  std_logic_vector(4 downto 0);
         rs2 : IN  std_logic_vector(4 downto 0);
         rd : IN  std_logic_vector(4 downto 0);
         DWR : IN  std_logic_vector(31 downto 0);
         reset : IN  std_logic;
         CRS1 : OUT  std_logic_vector(31 downto 0);
         CRS2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rs1 : std_logic_vector(4 downto 0) := (others => '0');
   signal rs2 : std_logic_vector(4 downto 0) := (others => '0');
   signal rd : std_logic_vector(4 downto 0) := (others => '0');
   signal DWR : std_logic_vector(31 downto 0) := (others => '0');
   signal reset : std_logic := '0';

 	--Outputs
   signal CRS1 : std_logic_vector(31 downto 0);
   signal CRS2 : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile PORT MAP (
          rs1 => rs1,
          rs2 => rs2,
          rd => rd,
          DWR => DWR,
          reset => reset,
          CRS1 => CRS1,
          CRS2 => CRS2
        );



   -- Stimulus process
   stim_proc: process
   begin		
      	reset <= '1';
      	-- hold reset state for 100 ns.
      	wait for 100 ns;	
	   
      	reset <= '0';
      	rd <= "11111";
      	DWR <= X"0D00C000";
	wait for 100 ns;	
		
	rd <= "00111";
	DWR <= X"00ACAA00";
	wait for 100 ns;	
		
	rs1 <= "11111";
	rs2 <= "00111";
	wait for 100 ns;	
		
	rd <= "00000";
	DWR <= X"FFFFFFFF";
	wait for 100 ns;	
	
	rs1 <= "00000";
	rs2 <= "00111";
	wait for 100 ns;	
		
      

      wait;
   end process;

END;
