library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplexer_2to1_8 is
    Port ( SEL : in  STD_LOGIC;
           A   : in  STD_LOGIC_VECTOR (7 downto 0);
           B   : in  STD_LOGIC_VECTOR (7 downto 0);
           X   : out STD_LOGIC_VECTOR (7 downto 0));
end Multiplexer_2to1_8;

architecture Behavioral of Multiplexer_2to1_8 is
begin
    X <= A when (SEL = '1') else B(15 downto 8);
end Behavioral;
