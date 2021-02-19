library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplexer_3to1_16 is
    Port ( SEL : in  STD_LOGIC_VECTOR (1 downto 0);
           A   : in  STD_LOGIC_VECTOR (15 downto 0);
           B   : in  STD_LOGIC_VECTOR (15 downto 0);
           C   : in  STD_LOGIC_VECTOR (7 downto 0);
           X   : out STD_LOGIC_VECTOR (15 downto 0));
end Multiplexer_3to1_16;

architecture Behavioral of Multiplexer_3to1_16 is
begin
  process(SEL, A, B, C)
    begin
    if(SEL = "00") then
        X <= A;
    elsif (SEL = "01") then
        X <= B;
    elsif (SEL = "10") then
        X <= "00000000" & C;
    else
        X <= "ZZZZZZZZZZZZZZZZ";
    end if;
  end process;
end Behavioral;
