library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplexer_2to1_8 is
    Port ( SEL : in  STD_LOGIC;
           A   : in  STD_LOGIC_VECTOR (7 downto 0);
           B   : in  STD_LOGIC_VECTOR (15 downto 0);
           X   : out STD_LOGIC_VECTOR (15 downto 0));
end Multiplexer_2to1_8;

--Need to get rid of all this
--Just use a 16 bit multiplexer and pad the A input when going to the MUX

architecture Behavioral of Multiplexer_2to1_8 is
begin
    X <= ("00000000" & A) when (SEL = '1') else (B);
end Behavioral;
