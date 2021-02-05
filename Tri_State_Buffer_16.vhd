library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tri_state_buffer_16 is
    Port ( en : in  STD_LOGIC;
           input : in  STD_LOGIC_VECTOR (15 downto 0);
           output : out STD_LOGIC_VECTOR (15 downto 0));
end tri_state_buffer_16;

architectural Behavioral of tri_state_buffer_16 is
  output <= input when (en = '1') else "ZZZZZZZZZZZZZZZZ";
end Behavioral;
