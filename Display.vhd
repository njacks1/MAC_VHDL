library ieee;
use ieee.std_logic_signed.all;
use ieee.std_logic_1164.all;

entity Display is
port(
Input: in std_logic_vector(3 downto 0); --input from calc
segmentSeven : out std_logic_vector(6 downto 0)); --7 bit output end Display_Ckt;
end Display;

Architecture behav_display of Display is
begin
process (Input)
Begin
 case Input is
 when"0000"=> segmentSeven <= "1000000";--"0000001"; -- 0
 when"0001"=> segmentSeven <= "1111001";--"1001111"; -- 1
 when"0010"=> segmentSeven <= "0100100";--"0010010"; -- 2
 when"0011"=> segmentSeven <= "0110000";--"0000110"; -- 3
 when"0100"=> segmentSeven <= "0011001";--"1001100"; -- 4
 when"0101"=> segmentSeven <= "0010010";--"0100100"; -- 5
 when"0110"=> segmentSeven <= "0000010";--"0100000"; -- 6
 when"0111"=> segmentSeven <= "1111000";--"0001111"; -- 7
 when"1000"=> segmentSeven <= "0000000"; -- 8
 when"1001"=> segmentSeven <= "0010000";--"0000100"; -- 9
 when"1010"=> segmentSeven <= "0001000";--"0001000"; -- 10 A
 when"1011"=> segmentSeven <= "0000011";--"1100000"; -- 11 b
 when"1100"=> segmentSeven <= "1000110";--"0110001"; -- 12 c
 when"1101"=> segmentSeven <= "0100001";--"1000010"; -- 13 d
 when"1110"=> segmentSeven <= "0000110";--"0110000"; -- 14 e
 when"1111"=> segmentSeven <= "0001110";--"0111000"; -- 15 f
 when others => segmentSeven <= "1111111";
end case;
end process;
end behav_display;