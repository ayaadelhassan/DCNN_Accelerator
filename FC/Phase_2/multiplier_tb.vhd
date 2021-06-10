LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.uniform;
USE ieee.math_real.floor;
ENTITY multiplication_test IS
END multiplication_test;

ARCHITECTURE testbench_a OF multiplication_test IS

    SIGNAL testa_16, testb_16 : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL testProd_16        : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL mulOpProd_16       : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL mulProdMod_16      : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL testClk            : STD_LOGIC;
    SIGNAL enable             : STD_LOGIC;
    SIGNAL reset              : STD_LOGIC;
    SIGNAL finished           : STD_LOGIC;
    CONSTANT clk_period       : TIME := 50 ps;
BEGIN

    --
    PROCESS
    BEGIN
        testClk <= '0';
        WAIT FOR clk_period/2;
        testClk <= '1';
        WAIT FOR clk_period/2;
    END PROCESS;

    PROCESS IS
        VARIABLE seed1 : POSITIVE;
        VARIABLE seed2 : POSITIVE;
        VARIABLE x     : real;
        VARIABLE y     : INTEGER;
        VARIABLE z     : INTEGER;
        VARIABLE res   : INTEGER;
    BEGIN
        seed1 := 1;
        seed2 := 1;
        enable <= '1';

        FOR k IN 0 TO 999 LOOP
            uniform(seed1, seed2, x);
            y := INTEGER(floor(x * 32035.0));
            uniform(seed1, seed2, x);
            z := INTEGER(floor(x * 32035.0));
            testa_16 <= STD_LOGIC_VECTOR(to_unsigned(y, 16));
            testb_16 <= STD_LOGIC_VECTOR(to_unsigned(z, 16));
            reset <= '1';
            WAIT FOR clk_period;
            reset <= '0';
            WAIT FOR clk_period;
            FOR c IN 0 TO 16 LOOP
                WAIT FOR clk_period;
            END LOOP;
            mulOpProd_16 <= STD_LOGIC_VECTOR(unsigned(testa_16) * unsigned(testb_16));
            WAIT FOR clk_period;
            ASSERT(signed(testProd_16) <= signed(mulProdMod_16)) REPORT "Output isn't correct for: " & INTEGER'IMAGE(y) & " * " & INTEGER'IMAGE(z) & ", Expected Output: " & INTEGER'IMAGE(to_integer(signed((mulProdMod_16)))) & ", Actual Output: " & INTEGER'IMAGE(to_integer(signed(testProd_16))) SEVERITY ERROR;
        END LOOP;

        WAIT;
    END PROCESS;
    -- Multiplier under Test
    uut_16 : ENTITY work.Multiplier PORT MAP (M => testa_16, R => testb_16, fixedMulResult => testProd_16, clk => testClk, finish => finished, enable => enable, reset => reset);

    uut_14 : ENTITY work.fixed_point_modification2 PORT MAP (result => mulOpProd_16, modifiedOut => mulProdMod_16);

END testbench_a;