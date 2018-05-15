----------------------------------------------------------------------------------

-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	 				John Sebastián Luján Figueroa
-- 
-- Create Date:    	19:15:31 05/14/2018
-- Design Name: 		DataMemory File Design
-- Module Name:    	DataMemory - Behavioral 
-- Project Name: 		Third Processor

----------------------------------------------------------------------------------




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DataMemory is Port (
    dataIn : in  STD_LOGIC_VECTOR (31 downto 0);
    address : in  STD_LOGIC_VECTOR (31 downto 0);
    reset : in  STD_LOGIC;
    wrEnMem : in  STD_LOGIC;
    rdEnMem : in  STD_LOGIC;
    dataOut : out  STD_LOGIC_VECTOR (31 downto 0));
 end DataMemory;

architecture Behavioral of DataMemory is

type ram_type is array(0 to 63) of std_logic_vector (31 downto 0);

signal DM: ram_type := (others => x"00000000");
begin
	process(reset, dataIn, address, wrEnMem, rdEnMem)
		begin
		if (reset = '1') then
			DM <= (others => X"00000000");
			dataOut <=  (others => '0');
		elsif (wrEnMem = '1') then
            DM(conv_integer(address)) <= dataIn;
        elsif (rdEnMem = '1') then
            dataOut <= DM(conv_integer(address));
        else
            dataOut <=  (others => '0');
		end if;
	end process;
end Behavioral;

