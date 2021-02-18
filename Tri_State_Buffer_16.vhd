library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TriStateBuffer16 is
    Port ( en : in  STD_LOGIC;
           input : in  STD_LOGIC_VECTOR (15 downto 0);
           output : out STD_LOGIC_VECTOR (15 downto 0));
end TriStateBuffer16;

architectural Behavioral of TriStateBuffer16 is
  output <= input when (en = '1') else "ZZZZZZZZZZZZZZZZ";
end Behavioral;
