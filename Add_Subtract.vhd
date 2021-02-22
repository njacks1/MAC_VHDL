library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--in the simualtion branch

entity AdderSubtractor is
    Port ( AMF : in  STD_LOGIC_VECTOR(4 downto 0);
           P   : in  STD_LOGIC_VECTOR (31 downto 0);
           MR   : in  STD_LOGIC_VECTOR (39 downto 0);
           MV   : out STD_LOGIC;
           R2   : out STD_LOGIC_VECTOR (7 downto 0);
           R1   : out STD_LOGIC_VECTOR (15 downto 0);
           R0   : out STD_LOGIC_VECTOR (15 downto 0));
end AdderSubtractor;

architecture Behavioral of AdderSubtractor is
    signal accum : STD_LOGIC_VECTOR(39 downto 0);

    begin
      process(AMF, P)
        begin
          if(AMF = "00000") then
             accum <= "0000000000000000000000000000000000000000";
         elsif(AMF = "00001") then
            accum <= ("00000000" & P);
          elsif(AMF = "00010") then
              accum <= MR + ("00000000" & P);
         else
              accum <= MR - ("00000000" & P);
          end if;

         if (accum(39 downto 32) = "11111111") or (accum(39 downto 32) = "00000000") then
              MV <= '0';
          else
              MV <= '1';
          end if;

          if(accum(31) = '1') then
            accum(39 downto 32) <= "11111111";
          else
             accum(39 downto 32) <= "00000000";
          end if;
      end process;
        R2 <= accum(39 downto 32);
        R1 <= accum(31 downto 16);
        R0 <= accum(15 downto 0);
    end Behavioral;
