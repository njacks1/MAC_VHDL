library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mac_complete_circuit is
    Port ( CLK : in  STD_LOGIC;
           REGISTERLOAD   : in  STD_LOGIC_VECTOR (7 downto 0);
           S   : in  STD_LOGIC_VECTOR (9 downto 0);
           --DMD   : inout STD_LOGIC_VECTOR (15 downto 0);
           --PMD   : in STD_LOGIC_VECTOR (23 downto 0);
           AMF   : in STD_LOGIC_VECTOR (4 downto 0);
           --R   : inout STD_LOGIC_VECTOR (15 downto 0);
           --E : in STD_LOGIC_VECTOR(5 downto 0);
           DMD_select   : in STD_LOGIC;
           PMD_select   : in STD_LOGIC;
           MV   : out STD_LOGIC;
           --MAC_OUT   : out STD_LOGIC_VECTOR (15 downto 0));
           DISPLAY_1 : out STD_LOGIC_VECTOR(6 downto 0);
           DISPLAY_2 : out STD_LOGIC_VECTOR(6 downto 0);
       end mac_complete_circuit;

architecture struct of mac_complete_circuit is

    component Display is
        port(
            Input: in std_logic_vector(3 downto 0); --input from calc
            segmentSeven : out std_logic_vector(6 downto 0)); --7 bit output end Display_Ckt;
    end component;

    component Multiplier16 is
        Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
               B : in  STD_LOGIC_VECTOR (15 downto 0);
               X : out STD_LOGIC_VECTOR (31 downto 0));
    end component;

    component AdderSubtractor is
        Port ( AMF : in  STD_LOGIC_VECTOR(4 downto 0);
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
               X   : out STD_LOGIC_VECTOR (15 downto 0));
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
              output : out STD_LOGIC_VECTOR(7 downto 0));
    end component;

    component Register16 is
        Port( clk : in STD_LOGIC;
              load : in STD_LOGIC;
              input : in STD_LOGIC_VECTOR(15 downto 0);
              output : out STD_LOGIC_VECTOR(15 downto 0));
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
    signal MUX0_to_AY0_and_AY1 : STD_LOGIC_VECTOR(15 downto 0);
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
    signal MUX8_to_TSB2: STD_LOGIC_VECTOR(15 downto 0);

    --for simulation
    signal DMD_fake : STD_LOGIC_VECTOR(15 downto 0);
    signal PMD_fake : STD_LOGIC_VECTOR(23 downto 0);

    begin
        DMD_fake <= ("0000000000000011") when (DMD_select = '1') else ("0000000000000100");
        PMD_fake <= ("000000000000011000000000") when (PMD_select = '1') else ("000000000000010100000000");

        AX0 : Register16 port map(CLK, REGISTERLOAD(0), DMD_fake, AX0_to_MUX1);
        AX1 : Register16 port map(CLK, REGISTERLOAD(1), DMD_fake, AX1_to_MUX1);
        MUX1 : Multiplexer_2to1_16 port map(S(1), AX0_to_MUX1, AX1_to_MUX1, MUX1_to_TSB0_and_MUX2);
        --MUX2 : Multiplexer_2to1_16 port map(S(2), R, MUX1_to_TSB0_and_MUX2, MUX2_to_X);
        MUX2 : Multiplexer_2to1_16 port map('0', R, MUX1_to_TSB0_and_MUX2, MUX2_to_X);
        --TSB0 : TriStateBuffer16 port map(E(0), MUX1_to_TSB0_and_MUX2, DMD);
        TSB0 : TriStateBuffer16 port map('0', MUX1_to_TSB0_and_MUX2, DMD_fake);

        --MUX0 : Multiplexer_2to1_16 port map(S(0), DMD, PMD(23 downto 8), MUX0_to_AY0_and_AY1);
        MUX0 : Multiplexer_2to1_16 port map('0', DMD_fake, PMD_fake(23 downto 8), MUX0_to_AY0_and_AY1);
        AY0 : Register16 port map(CLK, REGISTERLOAD(2), MUX0_to_AY0_and_AY1, AY0_to_MUX3);
        AY1 : Register16 port map(CLK, REGISTERLOAD(3), MUX0_to_AY0_and_AY1, AY1_to_MUX3);
        MUX3 : Multiplexer_2to1_16 port map(S(3), AY0_to_MUX3, AY1_to_MUX3, MUX3_to_TSB1_and_MUX4);
        --MUX4 : Multiplexer_2to1_16 port map(S(4), MUX3_to_TSB1_and_MUX4, MF_TO_MUX4, MUX4_to_Y);
        MUX4 : Multiplexer_2to1_16 port map('1', MUX3_to_TSB1_and_MUX4, MF_TO_MUX4, MUX4_to_Y);
        --TSB1 : TriStateBuffer16 port map(E(1), MUX3_to_TSB1_and_MUX4, DMD);
        TSB1 : TriStateBuffer16 port map('0', MUX3_to_TSB1_and_MUX4, DMD_fake);

        --MR <= (MR0_to_TSB3 & MR1_to_TSB4 & MR2_to_TSB5);
	MR <= (MR2_to_TSB5 & MR1_to_TSB4 & MR0_to_TSB3);

        MULTIPLIER : Multiplier16 port map(MUX2_to_X, MUX4_to_Y, XxY_to_ADD_SUB);
        --ADDNSUB : AdderSubtractor port map(AMF, XxY_to_ADD_SUB, MR, MV, R2_to_MUX7, R1_to_MUX6_and_MF, R0_to_MUX5);
        ADDNSUB : AdderSubtractor port map(("000" & AMF(1 downto 0)), XxY_to_ADD_SUB, MR, MV, R2_to_MUX7, R1_to_MUX6_and_MF, R0_to_MUX5);
        --MFREG : Register16 port map(CLK, REGISTERLOAD(4), R1_to_MUX6_and_MF, MF_TO_MUX4);
        MFREG : Register16 port map(CLK, '1', R1_to_MUX6_and_MF, MF_TO_MUX4);

        --MUX5 : Multiplexer_2to1_16 port map(S(5), R0_to_MUX5, DMD, MUX5_to_MR0);
        MUX5 : Multiplexer_2to1_16 port map('1', R0_to_MUX5, DMD_fake, MUX5_to_MR0);
        --MUX6 : Multiplexer_2to1_16 port map(S(6), R1_to_MUX6_and_MF, DMD, MUX6_to_MR1);
        MUX6 : Multiplexer_2to1_16 port map('1', R1_to_MUX6_and_MF, DMD_fake, MUX6_to_MR1);
        --MUX7 : Multiplexer_2to1_8 port map(S(7), R2_to_MUX7, DMD, MUX7_to_MR2);
        MUX7 : Multiplexer_2to1_8 port map('1', R2_to_MUX7, DMD_fake, MUX7_to_MR2);

        MR0 : Register16 port map(CLK, REGISTERLOAD(5), MUX5_to_MR0, MR0_to_TSB3);
        MR1 : Register16 port map(CLK, REGISTERLOAD(6), MUX6_to_MR1, MR1_to_TSB4);
        MR2 : Register8 port map(CLK, REGISTERLOAD(7), MUX7_to_MR2(7 downto 0), MR2_to_TSB5);

        --MUX8 : Multiplexer_3to1_16 port map(S(9 downto 8), MR0_to_TSB3, MR1_to_TSB4, MR2_to_TSB5, MUX8_to_TSB2);
        MUX8 : Multiplexer_3to1_16 port map("00", MR0_to_TSB3, MR1_to_TSB4, MR2_to_TSB5, MUX8_to_TSB2);

        --TSB2 : TriStateBuffer16 port map(E(2), MUX8_to_TSB2, DMD);
        TSB2 : TriStateBuffer16 port map('0', MUX8_to_TSB2, DMD_fake);
        --TSB3 : TriStateBuffer16 port map(E(3), MR0_to_TSB3, MAC_OUT);
        TSB3 : TriStateBuffer16 port map('1', MR0_to_TSB3, MAC_OUT);
        --TSB4 : TriStateBuffer16 port map(E(4), MR1_to_TSB4, MAC_OUT);
        TSB4 : TriStateBuffer16 port map('0', MR1_to_TSB4, MAC_OUT);
        --TSB5 : TriStateBufferSpecial16 port map(E(5), MR2_to_TSB5, MAC_OUT);
        TSB5 : TriStateBufferSpecial16 port map('0', MR2_to_TSB5, MAC_OUT);

        DSP1 : Display port map(MAC_OUT(3 downto 0), DISPLAY_1);
        DSP2 : Display port map(MAC_OUT(7 downto 4), DISPLAY_2);

    end struct;
