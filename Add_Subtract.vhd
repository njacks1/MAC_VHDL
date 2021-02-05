
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_subtractor is
    Port ( AMF : in  STD_LOGIC;
           P   : in  STD_LOGIC_VECTOR (31 downto 0);
           MR   : in  STD_LOGIC_VECTOR (39 downto 0);
           MV   : out STD_LOGIC;
           R2   : out STD_LOGIC_VECTOR (7 downto 0);
           R1   : out STD_LOGIC_VECTOR (15 downto 0);
           R0   : out STD_LOGIC_VECTOR (15 downto 0));
end adder_subtractor;

architecture Behavioral of adder_subtractor is
  if(AMF == "00000") then
    
  elsif(AMF == "00001") then
  
  elsif(AMF == "00010") then
  
  else 
  
  end if;
end Behavioral;
