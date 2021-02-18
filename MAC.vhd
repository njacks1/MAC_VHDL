library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mac_complete_circuit is
    Port ( CLK : in  STD_LOGIC;
           REGISTERLOAD   : in  STD_LOGIC_VECTOR (7 downto 0);
           S   : in  STD_LOGIC_VECTOR (9 downto 0);
           DMD   : in STD_LOGIC_VECTOR (15 downto 0);
           PMD   : in STD_LOGIC_VECTOR (23 downto 0);
           AMF   : in STD_LOGIC_VECTOR (4 downto 0);
           R   : in STD_LOGIC_VECTOR (15 downto 0);
           E : in STD_LOGIC_VECTOR(5 downto 0);
           MV   : out STD_LOGIC;
           MAC_OUT   : out STD_LOGIC_VECTOR (15 downto 0));
       end mac_complete_circuit;

architecture struct of mac_complete_circuit is

    component Multiplier16 is
        Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
               B : in  STD_LOGIC_VECTOR (15 downto 0);
               X : out STD_LOGIC_VECTOR (31 downto 0));
    end component;

    component AdderSubtractor is
        Port ( AMF : in  STD_LOGIC;
               P   : in  STD_LOGIC_VECTOR (31 downto 0);
               MR   : in  STD_LOGIC_VECTOR (39 downto 0);
               MV   : out STD_LOGIC;
               R2   : out STD_LOGIC_VECTOR (7 downto 0);
               R1   : out STD_LOGIC_VECTOR (15 downto 0);
               R0   : out STD_LOGIC_VECTOR (15 downto 0));
    end component;

    component Multiplexer_2to1_8 is
        Port ( SEL : in  STD_LOGIC;
               A   : in  STD_LOGIC_VECTOR (7 downto 0);
               B   : in  STD_LOGIC_VECTOR (15 downto 0);
               X   : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    component Multiplexer_2to1_16 is
        Port ( SEL : in  STD_LOGIC;
               A   : in  STD_LOGIC_VECTOR (15 downto 0);
               B   : in  STD_LOGIC_VECTOR (15 downto 0);
               X   : out STD_LOGIC_VECTOR (15 downto 0));
    end component;

    component Multiplexer_3to1_16 is
        Port ( SEL : in  STD_LOGIC_VECTOR (1 downto 0);
               A   : in  STD_LOGIC_VECTOR (15 downto 0);
               B   : in  STD_LOGIC_VECTOR (15 downto 0);
               C   : in  STD_LOGIC_VECTOR (7 downto 0);
               X   : out STD_LOGIC_VECTOR (15 downto 0));
    end component;

    component Register8 is
        Port( clk : in STD_LOGIC;
              load : in STD_LOGIC;
              input : in STD_LOGIC_VECTOR(7 downto 0);
              output : in STD_LOGIC_VECTOR(7 downto 0));
    end component;

    component Register16 is
        Port( clk : in STD_LOGIC;
              load : in STD_LOGIC;
              input : in STD_LOGIC_VECTOR(15 downto 0);
              output : in STD_LOGIC_VECTOR(15 downto 0));
    end component;

    component TriStateBuffer16 is
        Port ( en : in  STD_LOGIC;
               input : in  STD_LOGIC_VECTOR (15 downto 0);
               output : out STD_LOGIC_VECTOR (15 downto 0));
    end component;

    component TriStateBufferSpecial16 is
        Port ( en : in  STD_LOGIC;
               input : in  STD_LOGIC_VECTOR (7 downto 0);
               output : out STD_LOGIC_VECTOR (15 downto 0));
    end component;

    signal AX0_to_MUX1 : STD_LOGIC_VECTOR(15 downto 0);
    signal AX1_to_MUX1 : STD_LOGIC_VECTOR(15 downto 0);
    signal MUX1_to_TSB0_and_MUX2 : STD_LOGIC_VECTOR(15 downto 0);
    signal MUX2_to_X : STD_LOGIC_VECTOR(15 downto 0);
    signal AY0_to_MUX3 : STD_LOGIC_VECTOR(15 downto 0);
    signal AY1_to_MUX3 : STD_LOGIC_VECTOR(15 downto 0);
    signal MUX3_to_TSB1_and_MUX4 : STD_LOGIC_VECTOR(15 downto 0);
    signal MUX4_to_Y : STD_LOGIC_VECTOR(15 downto 0);
    signal XxY_to_ADD_SUB : STD_LOGIC_VECTOR(31 downto 0);
    signal MR : STD_LOGIC_VECTOR(39 downto 0);
    signal R0_to_MUX5 : STD_LOGIC_VECTOR(15 downto 0);
    signal R1_to_MUX6_and_MF : STD_LOGIC_VECTOR(15 downto 0);
    signal R2_to_MUX7 : STD_LOGIC_VECTOR(7 downto 0);
    signal MF_TO_MUX4 : STD_LOGIC_VECTOR(15 downto 0);
    signal MUX5_to_MR0 : STD_LOGIC_VECTOR(15 downto 0);
    signal MUX6_to_MR1 : STD_LOGIC_VECTOR(15 downto 0);
    signal MUX7_to_MR2 : STD_LOGIC_VECTOR(15 downto 0);
    signal MR0_to_TSB3 : STD_LOGIC_VECTOR(15 downto 0);
    signal MR1_to_TSB4 : STD_LOGIC_VECTOR(15 downto 0);
    signal MR2_to_TSB5: STD_LOGIC_VECTOR(7 downto 0);
    signal MUX8_to_TSB2: STD_LOGIC_VECTOR(7 downto 0);

    begin

        AX0 : Register16 port map(CLK, REGISTERLOAD(0), DMD, AX0_to_MUX1);
        AX1 : Register16 port map(CLK, REGISTERLOAD(1), DMD, AX1_to_MUX1);
        MUX1 : Multiplexer_2to1_16 port map(S(1), AX0_to_MUX1, AX1_to_MUX1, MUX1_to_TSB0_and_MUX2);
        MUX2 : Multiplexer_2to1_16 port map(S(2), R, MUX1_to_TSB0_and_MUX2, MUX2_to_X);
        TSB0 : TriStateBuffer16 port map(E(0), MUX1_to_TSB0_and_MUX2, DMD);

        MUX0 : Multiplexer_2to1_16 port map(S(0), DMD, PMD(23 downto 8), MUX0_to_AY0_and_AY1);
        AY0 : Register16 port map(CLK, REGISTERLOAD(2), MUX0_to_AY0_and_AY1, AY0_to_MUX3);
        AY1 : Register16 port map(CLK, REGISTERLOAD(3), MUX0_to_AY0_and_AY1, AY1_to_MUX3);
        MUX3 : Multiplexer_2to1_16 port map(S(3), AY0_to_MUX3, AY1_to_MUX3, MUX3_to_TSB1_and_MUX4);
        MUX4 : Multiplexer_2to1_16 port map(S(4), MUX3_to_TSB1_and_MUX4, MF_TO_MUX4, MUX4_to_Y);
        TSB1 : TriStateBuffer16 port map(E(1), MUX3_to_TSB1_and_MUX4, DMD);

        MULTIPLIER : Multiplier16 port map(MUX2_to_X, MUX4_to_Y, XxY_to_ADD_SUB);
        ADDNSUB : AdderSubtractor port map(AMF, XxY_to_ADD_SUB, MR, MV, R2_to_MUX7, R1_to_MUX6_and_MF, R0_to_MUX5);
        MFREG : Register16 port map(CLK, REGISTERLOAD(4), R1_to_MUX6_and_MF, MF_TO_MUX4);

        MUX5 : Multiplexer_2to1_16 port map(S(5), R0_to_MUX5, DMD, MUX5_to_MR0);
        MUX6 : Multiplexer_2to1_16 port map(S(6), R1_to_MUX6_and_MF, DMD, MUX6_to_MR1);
        MUX7 : Multiplexer_2to1_8 port map(S(7), R2_to_MUX7, DMD(15 downto 8), MUX7_to_MR2);

        MR0 : Register16 port map(CLK, REGISTERLOAD(5), MUX5_to_MR0, MR0_to_TSB3);
        MR1 : Register16 port map(CLK, REGISTERLOAD(6), MUX6_to_MR1, MR1_to_TSB4);
        MR2 : Register8 port map(CLK, REGISTERLOAD(7), MUX7_to_MR2, MR2_to_TSB5);

        MUX8 : Multiplexer_3to1_16 port map(S(9 downto 8), MR0_to_TSB3, MR1_to_TSB4, MR2_to_TSB5, MUX8_to_TSB2);

        TSB2 : TriStateBuffer16 port map(E(2), MUX8_to_TSB2, DMD);
        TSB3 : TriStateBuffer16 port map(E(3), MR0_to_TSB3, R);
        TSB4 : TriStateBuffer16 port map(E(4), MR1_to_TSB4, R);
        TSB5 : TriStateBufferSpecial16 port map(E(5), MR2_to_TSB5, R);

    end struct;
