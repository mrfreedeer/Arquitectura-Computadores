----------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	 	John Sebastián Luján Figueroa
-- 
-- Create Date:    	16:13:07 04/10/2018 
-- Design Name: 	Tb_ALU File Design
-- Module Name:    	Tb-ALU - Behavioral 
-- Project Name: 	First Processor

--
----------------------------------------------------------------------------------



LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Tb_ALU IS
END Tb_ALU;
 
ARCHITECTURE behavior OF Tb_ALU IS 

 
    COMPONENT ALU
    PORT(
         CRS1 : IN  std_logic_vector(31 downto 0);
         RMUX : IN  std_logic_vector(31 downto 0);
         ALUOP : IN  std_logic_vector(5 downto 0);
         DWR : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CRS1 : std_logic_vector(31 downto 0) := (others => '0');
   signal RMUX : std_logic_vector(31 downto 0) := (others => '0');
   signal ALUOP : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal DWR : std_logic_vector(31 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          CRS1 => CRS1,
          RMUX => RMUX,
          ALUOP => ALUOP,
          DWR => DWR
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      CRS1<=X"0000000A";
		RMUX<=X"0000000D";
		ALUOP<="000000";
      wait for 100 ns;
		ALUOP<="000001";
      wait for 100 ns;
		ALUOP<="000010";
      wait for 100 ns;
		ALUOP<="000011";
      wait for 100 ns;
		ALUOP<="000100";
      wait for 100 ns;
		ALUOP<="000101";
      wait for 100 ns;
		ALUOP<="000110";
      wait for 100 ns;
		ALUOP<="000111";

      -- insert stimulus here 

      wait;
   end process;

END;
