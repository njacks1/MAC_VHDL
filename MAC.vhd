library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mac_complete_circuit is
    Port ( CLK : in  STD_LOGIC;
           REGISTERLOAD   : in  STD_LOGIC_VECTOR (31 downto 0);
           S   : in  STD_LOGIC_VECTOR (39 downto 0);
           DMD   : in STD_LOGIC;
           PMD   : in STD_LOGIC_VECTOR (7 downto 0);
           AMF   : in STD_LOGIC_VECTOR (15 downto 0);
           R   : in STD_LOGIC_VECTOR (15 downto 0);
           MV   : out STD_LOGIC_VECTOR (15 downto 0);
           MAC_OUT   : out STD_LOGIC_VECTOR (15 downto 0));
       end mac_complete_circuit;

architecture struct of mac_complete_circuit is

    component multiplier_16 is
        Port (
               A : in  STD_LOGIC_VECTOR (15 downto 0);
               B : in  STD_LOGIC_VECTOR (15 downto 0);
               X : out STD_LOGIC_VECTOR (31 downto 0));
    end component;

    component adder_subtractor is
        ( AMF : in  STD_LOGIC;
               P   : in  STD_LOGIC_VECTOR (31 downto 0);
               MR   : in  STD_LOGIC_VECTOR (39 downto 0);
               MV   : out STD_LOGIC;
               R2   : out STD_LOGIC_VECTOR (7 downto 0);
               R1   : out STD_LOGIC_VECTOR (15 downto 0);
               R0   : out STD_LOGIC_VECTOR (15 downto 0));
    end component;

    component mux_2to1_8 is
        Port ( SEL : in  STD_LOGIC;
               A   : in  STD_LOGIC_VECTOR (7 downto 0);
               B   : in  STD_LOGIC_VECTOR (15 downto 0);
               X   : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    component mux_2to1_16 is
        Port ( SEL : in  STD_LOGIC;
               A   : in  STD_LOGIC_VECTOR (15 downto 0);
               B   : in  STD_LOGIC_VECTOR (15 downto 0);
               X   : out STD_LOGIC_VECTOR (15 downto 0));
    end component;

    component Register_8 is
        Port(
          clk : in STD_LOGIC;
          load : in STD_LOGIC;
          input : in STD_LOGIC_VECTOR(7 downto 0);
          output : in STD_LOGIC_VECTOR(7 downto 0));
    end component;

    component Register_16 is
        Port(
          clk : in STD_LOGIC;
          load : in STD_LOGIC;
          input : in STD_LOGIC_VECTOR(15 downto 0);
          output : in STD_LOGIC_VECTOR(15 downto 0));
    end component;

    component tri_state_buffer_16 is
        Port ( en : in  STD_LOGIC;
               input : in  STD_LOGIC_VECTOR (15 downto 0);
               output : out STD_LOGIC_VECTOR (15 downto 0));
    end component;

    begin

    end struct;
