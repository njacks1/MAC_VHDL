
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplier_16 is
    Port (
           A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : in  STD_LOGIC_VECTOR (15 downto 0);
           X : out STD_LOGIC_VECTOR (31 downto 0));
end multiplier_16;

architecture Behavioral of mux_2to1 is
begin
    process(A, B)
      begin
        X <= A*B;
      end process;
end Behavioral;