library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register_16 is
  Port(
    clk : in STD_LOGIC;
    load : in STD_LOGIC;
    --clear?
    --clear : in STD_LOGIC;
    input : in STD_LOGIC_VECTOR(15 downto 0);
    output : in STD_LOGIC_VECTOR(15 downto 0);
  );
end Register_16

architecture Behavioral of Register_16 is
Signal storage : STD_LOGIC_VECTOR(15 donwto 0);
begin
  process(clk, input, load)
  begin
    if(load = '1' and Clk'event and Clk = '1') then
      storage <= input;
    elsif(Clk'event and Clk - '0') then
      output <= storage;
    end if;
  end process;
end Behavioral;
