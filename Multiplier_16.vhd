
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplier16 is
    Port (
           A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : in  STD_LOGIC_VECTOR (15 downto 0);
           X : out STD_LOGIC_VECTOR (31 downto 0));
end Multiplier16;

architecture Behavioral of Multiplier16 is
        begin
            process(A, B)
              begin
                X <= A*B;
              end process;
        end Behavioral;
