library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Test_Bench is
end Test_Bench;

architecture Behavioral of Test_Bench is
    component elevator_controller is
        Port (
            gnd        : in  std_logic;
            One       : in  std_logic;
            Two        : in  std_logic;
            Three       : in  std_logic;
            Four       : in  std_logic;
            DoorOpen  : out std_logic;
            DoorClose : out std_logic;
            Up        : out std_logic;
            Down      : out std_logic;
            Cnt       : out std_logic_vector(2 downto 0);
            Rst       : in  std_logic;
            Clk       : in  std_logic
        );
    end component;

    signal gnd,One,Two, Three, Four : std_logic := '0';
    signal DoorOpen,DoorClose  : std_logic;
    signal Up        : std_logic;
    signal Down      : std_logic;
    signal Cnt       : std_logic_vector(2 downto 0);
    signal Rst       : std_logic := '0';
    signal Clk       : std_logic := '0';
    constant clk_period : time := 20 ns;

begin

 uut: elevator_controller
port map (
    gnd => gnd,One => One,Two => Two,Three => Three,Four => Four,
    DoorOpen => DoorOpen,DoorClose => DoorClose,
    Up => Up,Down => Down,
    Cnt => Cnt,Rst => Rst,Clk => Clk);
    utt : process
    begin
        Clk <= '0';
        wait for clk_period / 2;
        Clk <= '1';
        wait for clk_period / 2;
    end process;

    stimuli : process
    begin
        -- reset
        Rst <= '1';gnd  <= '0';One <= '0';Two  <= '0';Three <= '0';Four <= '0';
        wait for clk_period * 5;
        -- go to floor 1
       Rst <= '0';One <= '1';wait for clk_period * 5;

        -- go to floor 2
       Two  <= '1';One <= '0';
       wait for clk_period * 5;

        -- go to floor 3
       Three <= '1';Two  <= '0';
      wait for clk_period * 5;

        -- go to floor 4
        Four <= '1';Three <= '0';
        wait for clk_period * 5;
        -- go to ground floor
        gnd  <= '0';Four <= '1';
        wait for clk_period * 5;

        -- reset again
        Rst <= '0';gnd  <= '0';
        wait for clk_period * 5;

        -- go to floor 2, then floor 3, then floor 1
        Rst <= '0';Two  <= '1';
        wait for clk_period * 5;
        Three <= '1';Two  <= '0';
        wait for clk_period * 5;
        One <= '1';Three <= '0';
        wait for clk_period * 5;

        -- end of test
        wait;
    end process;

end Behavioral;

