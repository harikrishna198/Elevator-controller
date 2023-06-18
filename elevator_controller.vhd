library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity elevator_controller is
    Port (
        gnd,one,two,three,four: in  std_logic;
        DoorOpen,DoorClose  : out std_logic;
        Up,Down        : out std_logic;
        Cnt       : out std_logic_vector(2 downto 0);
        Rst       : in  std_logic;
        Clk       : in  std_logic
    );
end elevator_controller;

architecture Behavioral of elevator_controller is
    signal count : std_logic_vector(2 downto 0);
    signal destination  : std_logic_vector(2 downto 0);
begin
    process (Clk)
    begin
        if (Rst = '1') then
            count <= "000";
            destination  <= "000";
            DoorOpen  <= '0';
            DoorClose <= '1';
            Up        <= '0';
            Down      <= '0';
        elsif (Clk'event and Clk = '1') then
            if (count = "000" and gnd = '1') then
                DoorOpen  <= '1';
                DoorClose <= '0';
                destination <= "000";
            elsif (count = "000" and (One = '1' or Two = '1' or Three = '1' or Four = '1')) then
                DoorOpen  <= '1';
                DoorClose <= '0';
                Up <= '1';
                Down <= '0';
                if (One = '1') then
                    destination <= "001";
                elsif (Two = '1') then
                    destination <= "010";
                elsif (Three = '1') then
                    destination <= "011";
                elsif (Four = '1') then
                    destination <= "100";
                end if;
            elsif (count = destination) then
                DoorOpen  <= '0';
                DoorClose <= '1';
                Up        <= '0';
                Down      <= '0';
            elsif (count < destination) then
                count <= count + "001";
                Up   <= '1';
                Down <= '0';
            elsif (count > destination) then
                count <= count - "001";
                Up   <= '0';
                Down <= '1';
            end if;
        end if;
    end process;
    Cnt <= count;
end Behavioral;
