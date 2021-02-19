library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TriStateBufferSpecial16 is
    Port ( en : in  STD_LOGIC;
           input : in  STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (15 downto 0));
end TriStateBufferSpecial16;

architecture Behavioral of TriStateBufferSpecial16 is
begin
  output <= ("00000000" & input) when (en = '1') else "ZZZZZZZZZZZZZZZZ";
end Behavioral;
