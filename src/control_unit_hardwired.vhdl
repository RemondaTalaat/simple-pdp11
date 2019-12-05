-- Auto generated file, any edits will be lost --
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit_hardwired is
    port (
        clk: in std_logic;
        ir_data, flags_data: in std_logic_vector(15 downto 0);

        alu_eq_r, alu_asr, alu_c_eq_0, alu_out, alu_r_not_l, alu_r_xnor_l, alu_r_plus_1, alu_r_plus_l_plus_c, alu_r_minus_1, alu_r_minus_l_minus_c, alu_rlc, alu_rol, alu_ror, alu_rrc, alu_r_or_l, alu_zero, alu_not_r, flags_in, flags_out, hardware_address_out_l, ir_addr_out, mar_in, mar_out, mdr_in, mdr_out, pc_in, pc_out, r_dst_in, r_dst_out, r_src_in, r_src_out, rd, tmp0_in, tmp0_out, tmp1_in, tmp1_out, wr: out std_logic
    );
end entity; 


architecture rtl of control_unit_hardwired is
    -- if set, do no operation
    signal hlt: integer := 0;
    signal end_flag: integer := 0;

    -- from 0 -> n-1, where n is the number of lines for the microprogram
    signal timer: integer := 0;

    -- increment number of clk ticks, when it reachs MAX_CLK_TICKS increment timer and reset clk_ticks
    constant MAX_CLK_TICKS := 4;
    signal clk_ticks: integer := 0;

    -- TODO: fix these assumptions according to the scheme
    alias carry_flag: std_logic is flags_data(0);
    alias zero_flag: std_logic is flags_data(1);
    alias neg_flag: std_logic is flags_data(2);
    alias par_flag: std_logic is flags_data(3);
    alias overfl_flag: std_logic is flags_data(4);

    procedure zero_all_out is
    begin
        alu_eq_r <= '0'; alu_asr <= '0'; alu_c_eq_0 <= '0'; alu_out <= '0'; alu_r_not_l <= '0'; alu_r_xnor_l <= '0'; alu_r_plus_1 <= '0'; alu_r_plus_l_plus_c <= '0'; alu_r_minus_1 <= '0'; alu_r_minus_l_minus_c <= '0'; alu_rlc <= '0'; alu_rol <= '0'; alu_ror <= '0'; alu_rrc <= '0'; alu_r_or_l <= '0'; alu_zero <= '0'; alu_not_r <= '0'; flags_in <= '0'; flags_out <= '0'; hardware_address_out_l <= '0'; ir_addr_out <= '0'; mar_in <= '0'; mar_out <= '0'; mdr_in <= '0'; mdr_out <= '0'; pc_in <= '0'; pc_out <= '0'; r_dst_in <= '0'; r_dst_out <= '0'; r_src_in <= '0'; r_src_out <= '0'; rd <= '0'; tmp0_in <= '0'; tmp0_out <= '0'; tmp1_in <= '0'; tmp1_out <= '0'; wr <= '0';
    end procedure;

    procedure execute_instr is
    begin
        case ir_data is
            -- TODO generate 'when cases' useing opcodes
        end case;
    end procedure;

    -- MOV R R
    procedure mov_r_r is
    begin
        case timer is
            when 0 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV R (R)+
    procedure mov_r_r_plus is
    begin
        case timer is
            when 0 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV R -(R)
    procedure mov_r_minus_r is
    begin
        case timer is
            when 0 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV R X(R)
    procedure mov_r_x_r is
    begin
        case timer is
            when 0 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV R @R
    procedure mov_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 1 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV R @(R)+
    procedure mov_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV R @-(R)
    procedure mov_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV R @X(R)
    procedure mov_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 6 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV (R)+ R
    procedure mov_r_plus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV (R)+ (R)+
    procedure mov_r_plus_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV (R)+ -(R)
    procedure mov_r_plus_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV (R)+ X(R)
    procedure mov_r_plus_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV (R)+ @R
    procedure mov_r_plus_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV (R)+ @(R)+
    procedure mov_r_plus_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV (R)+ @-(R)
    procedure mov_r_plus_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 4 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV (R)+ @X(R)
    procedure mov_r_plus_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 8 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV -(R) R
    procedure mov_minus_r_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV -(R) (R)+
    procedure mov_minus_r_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV -(R) -(R)
    procedure mov_minus_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV -(R) X(R)
    procedure mov_minus_r_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV -(R) @R
    procedure mov_minus_r_at_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 3 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV -(R) @(R)+
    procedure mov_minus_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV -(R) @-(R)
    procedure mov_minus_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 4 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV -(R) @X(R)
    procedure mov_minus_r_at_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 8 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV X(R) R
    procedure mov_x_r_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV X(R) (R)+
    procedure mov_x_r_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV X(R) -(R)
    procedure mov_x_r_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV X(R) X(R)
    procedure mov_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV X(R) @R
    procedure mov_x_r_at_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV X(R) @(R)+
    procedure mov_x_r_at_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 7 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 8 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV X(R) @-(R)
    procedure mov_x_r_at_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 8 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV X(R) @X(R)
    procedure mov_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 8 => alu_out <= '1'; pc_in <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 12 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @R R
    procedure mov_at_r_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @R (R)+
    procedure mov_at_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @R -(R)
    procedure mov_at_r_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @R X(R)
    procedure mov_at_r_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @R @R
    procedure mov_at_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @R @(R)+
    procedure mov_at_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @R @-(R)
    procedure mov_at_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 4 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @R @X(R)
    procedure mov_at_r_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 8 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @(R)+ R
    procedure mov_at_r_plus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @(R)+ (R)+
    procedure mov_at_r_plus_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @(R)+ -(R)
    procedure mov_at_r_plus_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @(R)+ X(R)
    procedure mov_at_r_plus_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @(R)+ @R
    procedure mov_at_r_plus_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 4 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @(R)+ @(R)+
    procedure mov_at_r_plus_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 4 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @(R)+ @-(R)
    procedure mov_at_r_plus_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @(R)+ @X(R)
    procedure mov_at_r_plus_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @-(R) R
    procedure mov_at_minus_r_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @-(R) (R)+
    procedure mov_at_minus_r_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @-(R) -(R)
    procedure mov_at_minus_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @-(R) X(R)
    procedure mov_at_minus_r_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @-(R) @R
    procedure mov_at_minus_r_at_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 4 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @-(R) @(R)+
    procedure mov_at_minus_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 4 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @-(R) @-(R)
    procedure mov_at_minus_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @-(R) @X(R)
    procedure mov_at_minus_r_at_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @X(R) R
    procedure mov_at_x_r_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @X(R) (R)+
    procedure mov_at_x_r_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @X(R) -(R)
    procedure mov_at_x_r_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @X(R) X(R)
    procedure mov_at_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @X(R) @R
    procedure mov_at_x_r_at_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 8 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @X(R) @(R)+
    procedure mov_at_x_r_at_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 8 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @X(R) @-(R)
    procedure mov_at_x_r_at_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- MOV @X(R) @X(R)
    procedure mov_at_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 9 => alu_out <= '1'; pc_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 13 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD R R
    procedure add_r_r is
    begin
        case timer is
            when 0 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; r_src_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD R (R)+
    procedure add_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 3 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD R -(R)
    procedure add_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; r_src_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD R X(R)
    procedure add_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => r_src_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD R @R
    procedure add_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 2 => r_src_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 3 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD R @(R)+
    procedure add_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_src_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 4 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD R @-(R)
    procedure add_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_src_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 4 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD R @X(R)
    procedure add_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => r_src_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 8 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD (R)+ R
    procedure add_r_plus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 4 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD (R)+ (R)+
    procedure add_r_plus_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD (R)+ -(R)
    procedure add_r_plus_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD (R)+ X(R)
    procedure add_r_plus_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD (R)+ @R
    procedure add_r_plus_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 5 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD (R)+ @(R)+
    procedure add_r_plus_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD (R)+ @-(R)
    procedure add_r_plus_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD (R)+ @X(R)
    procedure add_r_plus_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD -(R) R
    procedure add_minus_r_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; r_src_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD -(R) (R)+
    procedure add_minus_r_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => r_src_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD -(R) -(R)
    procedure add_minus_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; r_src_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD -(R) X(R)
    procedure add_minus_r_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => r_src_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD -(R) @R
    procedure add_minus_r_at_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => r_src_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 5 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD -(R) @(R)+
    procedure add_minus_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_src_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD -(R) @-(R)
    procedure add_minus_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_src_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD -(R) @X(R)
    procedure add_minus_r_at_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => r_src_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD X(R) R
    procedure add_x_r_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 8 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD X(R) (R)+
    procedure add_x_r_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 8 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 9 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD X(R) -(R)
    procedure add_x_r_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_r_minus_1 <= '1';
            when 7 => alu_out <= '1';
            when 8 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 10 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD X(R) X(R)
    procedure add_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 8 => alu_out <= '1'; pc_in <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 12 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 13 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD X(R) @R
    procedure add_x_r_at_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD X(R) @(R)+
    procedure add_x_r_at_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD X(R) @-(R)
    procedure add_x_r_at_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD X(R) @X(R)
    procedure add_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 8 => alu_out <= '1'; pc_in <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 13 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 14 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @R R
    procedure add_at_r_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 4 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @R (R)+
    procedure add_at_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @R -(R)
    procedure add_at_r_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @R X(R)
    procedure add_at_r_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @R @R
    procedure add_at_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 5 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @R @(R)+
    procedure add_at_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @R @-(R)
    procedure add_at_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @R @X(R)
    procedure add_at_r_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @(R)+ R
    procedure add_at_r_plus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @(R)+ (R)+
    procedure add_at_r_plus_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @(R)+ -(R)
    procedure add_at_r_plus_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1';
            when 4 => alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 7 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @(R)+ X(R)
    procedure add_at_r_plus_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @(R)+ @R
    procedure add_at_r_plus_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @(R)+ @(R)+
    procedure add_at_r_plus_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @(R)+ @-(R)
    procedure add_at_r_plus_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @(R)+ @X(R)
    procedure add_at_r_plus_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 11 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @-(R) R
    procedure add_at_minus_r_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @-(R) (R)+
    procedure add_at_minus_r_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @-(R) -(R)
    procedure add_at_minus_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1';
            when 4 => alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 7 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @-(R) X(R)
    procedure add_at_minus_r_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @-(R) @R
    procedure add_at_minus_r_at_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @-(R) @(R)+
    procedure add_at_minus_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @-(R) @-(R)
    procedure add_at_minus_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @-(R) @X(R)
    procedure add_at_minus_r_at_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 11 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @X(R) R
    procedure add_at_x_r_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 9 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @X(R) (R)+
    procedure add_at_x_r_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 9 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 10 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @X(R) -(R)
    procedure add_at_x_r_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_r_minus_1 <= '1';
            when 8 => alu_out <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 11 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @X(R) X(R)
    procedure add_at_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 9 => alu_out <= '1'; pc_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 13 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 14 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @X(R) @R
    procedure add_at_x_r_at_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @X(R) @(R)+
    procedure add_at_x_r_at_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 11 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @X(R) @-(R)
    procedure add_at_x_r_at_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 11 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADD @X(R) @X(R)
    procedure add_at_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 9 => alu_out <= '1'; pc_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 13 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 14 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 15 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC R R
    procedure adc_r_r is
    begin
        case timer is
            when 0 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => r_dst_out <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; r_src_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC R (R)+
    procedure adc_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 3 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC R -(R)
    procedure adc_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; r_src_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC R X(R)
    procedure adc_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => r_src_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC R @R
    procedure adc_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 2 => r_src_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 3 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC R @(R)+
    procedure adc_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_src_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 4 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC R @-(R)
    procedure adc_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_src_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 4 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC R @X(R)
    procedure adc_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => r_src_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 8 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC (R)+ R
    procedure adc_r_plus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 4 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC (R)+ (R)+
    procedure adc_r_plus_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC (R)+ -(R)
    procedure adc_r_plus_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC (R)+ X(R)
    procedure adc_r_plus_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC (R)+ @R
    procedure adc_r_plus_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 5 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC (R)+ @(R)+
    procedure adc_r_plus_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC (R)+ @-(R)
    procedure adc_r_plus_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC (R)+ @X(R)
    procedure adc_r_plus_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC -(R) R
    procedure adc_minus_r_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; r_src_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC -(R) (R)+
    procedure adc_minus_r_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => r_src_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC -(R) -(R)
    procedure adc_minus_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; r_src_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC -(R) X(R)
    procedure adc_minus_r_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => r_src_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC -(R) @R
    procedure adc_minus_r_at_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => r_src_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 5 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC -(R) @(R)+
    procedure adc_minus_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_src_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC -(R) @-(R)
    procedure adc_minus_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_src_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC -(R) @X(R)
    procedure adc_minus_r_at_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => r_src_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC X(R) R
    procedure adc_x_r_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => r_dst_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 8 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC X(R) (R)+
    procedure adc_x_r_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 8 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 9 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC X(R) -(R)
    procedure adc_x_r_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_r_minus_1 <= '1';
            when 7 => alu_out <= '1';
            when 8 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => r_dst_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 10 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC X(R) X(R)
    procedure adc_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 8 => alu_out <= '1'; pc_in <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 12 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 13 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC X(R) @R
    procedure adc_x_r_at_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC X(R) @(R)+
    procedure adc_x_r_at_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC X(R) @-(R)
    procedure adc_x_r_at_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC X(R) @X(R)
    procedure adc_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 8 => alu_out <= '1'; pc_in <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 13 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 14 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @R R
    procedure adc_at_r_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 4 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @R (R)+
    procedure adc_at_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @R -(R)
    procedure adc_at_r_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @R X(R)
    procedure adc_at_r_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @R @R
    procedure adc_at_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 5 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @R @(R)+
    procedure adc_at_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @R @-(R)
    procedure adc_at_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @R @X(R)
    procedure adc_at_r_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @(R)+ R
    procedure adc_at_r_plus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => r_dst_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @(R)+ (R)+
    procedure adc_at_r_plus_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @(R)+ -(R)
    procedure adc_at_r_plus_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1';
            when 4 => alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => r_dst_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 7 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @(R)+ X(R)
    procedure adc_at_r_plus_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @(R)+ @R
    procedure adc_at_r_plus_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @(R)+ @(R)+
    procedure adc_at_r_plus_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @(R)+ @-(R)
    procedure adc_at_r_plus_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @(R)+ @X(R)
    procedure adc_at_r_plus_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 11 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @-(R) R
    procedure adc_at_minus_r_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => r_dst_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @-(R) (R)+
    procedure adc_at_minus_r_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @-(R) -(R)
    procedure adc_at_minus_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1';
            when 4 => alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => r_dst_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 7 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @-(R) X(R)
    procedure adc_at_minus_r_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @-(R) @R
    procedure adc_at_minus_r_at_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @-(R) @(R)+
    procedure adc_at_minus_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @-(R) @-(R)
    procedure adc_at_minus_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @-(R) @X(R)
    procedure adc_at_minus_r_at_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 11 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @X(R) R
    procedure adc_at_x_r_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => r_dst_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 9 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @X(R) (R)+
    procedure adc_at_x_r_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 9 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 10 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @X(R) -(R)
    procedure adc_at_x_r_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_r_minus_1 <= '1';
            when 8 => alu_out <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => r_dst_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 11 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @X(R) X(R)
    procedure adc_at_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 9 => alu_out <= '1'; pc_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 13 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 14 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @X(R) @R
    procedure adc_at_x_r_at_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @X(R) @(R)+
    procedure adc_at_x_r_at_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 11 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @X(R) @-(R)
    procedure adc_at_x_r_at_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 11 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ADC @X(R) @X(R)
    procedure adc_at_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 9 => alu_out <= '1'; pc_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 13 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 14 => tmp1_out <= '1'; alu_r_plus_l_plus_c <= '1';
            when 15 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB R R
    procedure sub_r_r is
    begin
        case timer is
            when 0 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 2 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB R (R)+
    procedure sub_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 4 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB R -(R)
    procedure sub_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 4 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB R X(R)
    procedure sub_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 8 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB R @R
    procedure sub_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 4 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB R @(R)+
    procedure sub_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 5 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB R @-(R)
    procedure sub_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 5 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB R @X(R)
    procedure sub_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB (R)+ R
    procedure sub_r_plus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 4 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB (R)+ (R)+
    procedure sub_r_plus_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 8 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB (R)+ -(R)
    procedure sub_r_plus_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB (R)+ X(R)
    procedure sub_r_plus_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 11 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 12 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB (R)+ @R
    procedure sub_r_plus_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 8 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB (R)+ @(R)+
    procedure sub_r_plus_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB (R)+ @-(R)
    procedure sub_r_plus_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB (R)+ @X(R)
    procedure sub_r_plus_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 13 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB -(R) R
    procedure sub_minus_r_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 4 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB -(R) (R)+
    procedure sub_minus_r_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB -(R) -(R)
    procedure sub_minus_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB -(R) X(R)
    procedure sub_minus_r_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB -(R) @R
    procedure sub_minus_r_at_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 4 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB -(R) @(R)+
    procedure sub_minus_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 5 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB -(R) @-(R)
    procedure sub_minus_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 5 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB -(R) @X(R)
    procedure sub_minus_r_at_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 9 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 11 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB X(R) R
    procedure sub_x_r_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 8 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB X(R) (R)+
    procedure sub_x_r_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 8 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 11 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 12 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB X(R) -(R)
    procedure sub_x_r_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_r_minus_1 <= '1';
            when 7 => alu_out <= '1';
            when 8 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 10 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB X(R) X(R)
    procedure sub_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 8 => alu_out <= '1'; pc_in <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 12 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 13 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 14 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 15 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 16 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB X(R) @R
    procedure sub_x_r_at_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 11 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 12 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB X(R) @(R)+
    procedure sub_x_r_at_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 13 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB X(R) @-(R)
    procedure sub_x_r_at_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 13 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB X(R) @X(R)
    procedure sub_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 8 => alu_out <= '1'; pc_in <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 13 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 14 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 15 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 16 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 17 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @R R
    procedure sub_at_r_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 4 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @R (R)+
    procedure sub_at_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 8 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @R -(R)
    procedure sub_at_r_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @R X(R)
    procedure sub_at_r_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 11 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 12 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @R @R
    procedure sub_at_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 8 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @R @(R)+
    procedure sub_at_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @R @-(R)
    procedure sub_at_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @R @X(R)
    procedure sub_at_r_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 13 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @(R)+ R
    procedure sub_at_r_plus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @(R)+ (R)+
    procedure sub_at_r_plus_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 9 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @(R)+ -(R)
    procedure sub_at_r_plus_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1';
            when 4 => alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 7 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @(R)+ X(R)
    procedure sub_at_r_plus_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 13 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @(R)+ @R
    procedure sub_at_r_plus_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @(R)+ @(R)+
    procedure sub_at_r_plus_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 9 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @(R)+ @-(R)
    procedure sub_at_r_plus_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 9 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @(R)+ @X(R)
    procedure sub_at_r_plus_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 11 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 13 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 14 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @-(R) R
    procedure sub_at_minus_r_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @-(R) (R)+
    procedure sub_at_minus_r_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 9 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @-(R) -(R)
    procedure sub_at_minus_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1';
            when 4 => alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 7 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @-(R) X(R)
    procedure sub_at_minus_r_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 13 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @-(R) @R
    procedure sub_at_minus_r_at_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @-(R) @(R)+
    procedure sub_at_minus_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 9 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @-(R) @-(R)
    procedure sub_at_minus_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 9 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @-(R) @X(R)
    procedure sub_at_minus_r_at_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 11 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 13 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 14 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @X(R) R
    procedure sub_at_x_r_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 9 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @X(R) (R)+
    procedure sub_at_x_r_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 13 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @X(R) -(R)
    procedure sub_at_x_r_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_r_minus_1 <= '1';
            when 8 => alu_out <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 11 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @X(R) X(R)
    procedure sub_at_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 9 => alu_out <= '1'; pc_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 13 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 14 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 15 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 16 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 17 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @X(R) @R
    procedure sub_at_x_r_at_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 13 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @X(R) @(R)+
    procedure sub_at_x_r_at_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 11 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 13 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 14 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @X(R) @-(R)
    procedure sub_at_x_r_at_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 11 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 13 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 14 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUB @X(R) @X(R)
    procedure sub_at_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 9 => alu_out <= '1'; pc_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 13 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 14 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 15 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 16 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 17 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when 18 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC R R
    procedure subc_r_r is
    begin
        case timer is
            when 0 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => r_dst_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 2 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC R (R)+
    procedure subc_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 4 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC R -(R)
    procedure subc_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 4 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC R X(R)
    procedure subc_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 8 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC R @R
    procedure subc_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 4 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC R @(R)+
    procedure subc_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 5 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC R @-(R)
    procedure subc_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 5 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC R @X(R)
    procedure subc_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC (R)+ R
    procedure subc_r_plus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 4 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC (R)+ (R)+
    procedure subc_r_plus_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 8 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC (R)+ -(R)
    procedure subc_r_plus_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC (R)+ X(R)
    procedure subc_r_plus_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 11 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 12 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC (R)+ @R
    procedure subc_r_plus_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 8 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC (R)+ @(R)+
    procedure subc_r_plus_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC (R)+ @-(R)
    procedure subc_r_plus_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC (R)+ @X(R)
    procedure subc_r_plus_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 13 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC -(R) R
    procedure subc_minus_r_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 4 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC -(R) (R)+
    procedure subc_minus_r_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC -(R) -(R)
    procedure subc_minus_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC -(R) X(R)
    procedure subc_minus_r_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC -(R) @R
    procedure subc_minus_r_at_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 4 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC -(R) @(R)+
    procedure subc_minus_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 5 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC -(R) @-(R)
    procedure subc_minus_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 5 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC -(R) @X(R)
    procedure subc_minus_r_at_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 9 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 11 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC X(R) R
    procedure subc_x_r_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => r_dst_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 8 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC X(R) (R)+
    procedure subc_x_r_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 8 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 11 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 12 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC X(R) -(R)
    procedure subc_x_r_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_r_minus_1 <= '1';
            when 7 => alu_out <= '1';
            when 8 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => r_dst_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 10 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC X(R) X(R)
    procedure subc_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 8 => alu_out <= '1'; pc_in <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 12 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 13 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 14 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 15 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 16 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC X(R) @R
    procedure subc_x_r_at_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 11 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 12 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC X(R) @(R)+
    procedure subc_x_r_at_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 13 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC X(R) @-(R)
    procedure subc_x_r_at_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 13 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC X(R) @X(R)
    procedure subc_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 8 => alu_out <= '1'; pc_in <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 13 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 14 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 15 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 16 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 17 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @R R
    procedure subc_at_r_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 4 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @R (R)+
    procedure subc_at_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 8 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @R -(R)
    procedure subc_at_r_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @R X(R)
    procedure subc_at_r_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 11 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 12 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @R @R
    procedure subc_at_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 8 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @R @(R)+
    procedure subc_at_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @R @-(R)
    procedure subc_at_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @R @X(R)
    procedure subc_at_r_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 13 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @(R)+ R
    procedure subc_at_r_plus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => r_dst_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @(R)+ (R)+
    procedure subc_at_r_plus_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 9 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @(R)+ -(R)
    procedure subc_at_r_plus_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1';
            when 4 => alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => r_dst_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 7 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @(R)+ X(R)
    procedure subc_at_r_plus_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 13 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @(R)+ @R
    procedure subc_at_r_plus_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @(R)+ @(R)+
    procedure subc_at_r_plus_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @(R)+ @-(R)
    procedure subc_at_r_plus_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @(R)+ @X(R)
    procedure subc_at_r_plus_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 11 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 13 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 14 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @-(R) R
    procedure subc_at_minus_r_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => r_dst_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @-(R) (R)+
    procedure subc_at_minus_r_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 9 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @-(R) -(R)
    procedure subc_at_minus_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1';
            when 4 => alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => r_dst_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 7 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @-(R) X(R)
    procedure subc_at_minus_r_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 13 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @-(R) @R
    procedure subc_at_minus_r_at_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @-(R) @(R)+
    procedure subc_at_minus_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @-(R) @-(R)
    procedure subc_at_minus_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @-(R) @X(R)
    procedure subc_at_minus_r_at_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 11 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 13 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 14 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @X(R) R
    procedure subc_at_x_r_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => r_dst_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 9 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @X(R) (R)+
    procedure subc_at_x_r_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 13 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @X(R) -(R)
    procedure subc_at_x_r_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_r_minus_1 <= '1';
            when 8 => alu_out <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => r_dst_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 11 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @X(R) X(R)
    procedure subc_at_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 9 => alu_out <= '1'; pc_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 13 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 14 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 15 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 16 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 17 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @X(R) @R
    procedure subc_at_x_r_at_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 13 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @X(R) @(R)+
    procedure subc_at_x_r_at_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 11 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 13 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 14 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @X(R) @-(R)
    procedure subc_at_x_r_at_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 11 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 13 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 14 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- SUBC @X(R) @X(R)
    procedure subc_at_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 9 => alu_out <= '1'; pc_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 13 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 14 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 15 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 16 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 17 => tmp1_out <= '1'; alu_r_minus_l_minus_c <= '1';
            when 18 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND R R
    procedure and_r_r is
    begin
        case timer is
            when 0 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => r_dst_out <= '1'; alu_r_not_l <= '1'; alu_out <= '1'; r_src_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND R (R)+
    procedure and_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_r_not_l <= '1';
            when 3 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND R -(R)
    procedure and_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_r_not_l <= '1'; alu_out <= '1'; r_src_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND R X(R)
    procedure and_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => r_src_out <= '1'; alu_r_not_l <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND R @R
    procedure and_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 2 => r_src_out <= '1'; alu_r_not_l <= '1';
            when 3 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND R @(R)+
    procedure and_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_src_out <= '1'; alu_r_not_l <= '1';
            when 4 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND R @-(R)
    procedure and_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_src_out <= '1'; alu_r_not_l <= '1';
            when 4 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND R @X(R)
    procedure and_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => r_src_out <= '1'; alu_r_not_l <= '1';
            when 8 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND (R)+ R
    procedure and_r_plus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_r_not_l <= '1';
            when 4 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND (R)+ (R)+
    procedure and_r_plus_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND (R)+ -(R)
    procedure and_r_plus_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_r_not_l <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND (R)+ X(R)
    procedure and_r_plus_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND (R)+ @R
    procedure and_r_plus_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 5 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND (R)+ @(R)+
    procedure and_r_plus_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND (R)+ @-(R)
    procedure and_r_plus_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND (R)+ @X(R)
    procedure and_r_plus_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND -(R) R
    procedure and_minus_r_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_r_not_l <= '1'; alu_out <= '1'; r_src_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND -(R) (R)+
    procedure and_minus_r_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => r_src_out <= '1'; alu_r_not_l <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND -(R) -(R)
    procedure and_minus_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_r_not_l <= '1'; alu_out <= '1'; r_src_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND -(R) X(R)
    procedure and_minus_r_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => r_src_out <= '1'; alu_r_not_l <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND -(R) @R
    procedure and_minus_r_at_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => r_src_out <= '1'; alu_r_not_l <= '1';
            when 5 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND -(R) @(R)+
    procedure and_minus_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_src_out <= '1'; alu_r_not_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND -(R) @-(R)
    procedure and_minus_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_src_out <= '1'; alu_r_not_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND -(R) @X(R)
    procedure and_minus_r_at_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => r_src_out <= '1'; alu_r_not_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND X(R) R
    procedure and_x_r_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => r_dst_out <= '1'; alu_r_not_l <= '1';
            when 8 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND X(R) (R)+
    procedure and_x_r_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 8 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 9 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND X(R) -(R)
    procedure and_x_r_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_r_minus_1 <= '1';
            when 7 => alu_out <= '1';
            when 8 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => r_dst_out <= '1'; alu_r_not_l <= '1';
            when 10 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND X(R) X(R)
    procedure and_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 8 => alu_out <= '1'; pc_in <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 12 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 13 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND X(R) @R
    procedure and_x_r_at_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND X(R) @(R)+
    procedure and_x_r_at_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND X(R) @-(R)
    procedure and_x_r_at_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND X(R) @X(R)
    procedure and_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 8 => alu_out <= '1'; pc_in <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 13 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 14 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @R R
    procedure and_at_r_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_r_not_l <= '1';
            when 4 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @R (R)+
    procedure and_at_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @R -(R)
    procedure and_at_r_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_r_not_l <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @R X(R)
    procedure and_at_r_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @R @R
    procedure and_at_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 5 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @R @(R)+
    procedure and_at_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @R @-(R)
    procedure and_at_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @R @X(R)
    procedure and_at_r_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @(R)+ R
    procedure and_at_r_plus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => r_dst_out <= '1'; alu_r_not_l <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @(R)+ (R)+
    procedure and_at_r_plus_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @(R)+ -(R)
    procedure and_at_r_plus_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1';
            when 4 => alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => r_dst_out <= '1'; alu_r_not_l <= '1';
            when 7 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @(R)+ X(R)
    procedure and_at_r_plus_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @(R)+ @R
    procedure and_at_r_plus_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @(R)+ @(R)+
    procedure and_at_r_plus_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @(R)+ @-(R)
    procedure and_at_r_plus_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @(R)+ @X(R)
    procedure and_at_r_plus_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 11 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @-(R) R
    procedure and_at_minus_r_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => r_dst_out <= '1'; alu_r_not_l <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @-(R) (R)+
    procedure and_at_minus_r_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @-(R) -(R)
    procedure and_at_minus_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1';
            when 4 => alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => r_dst_out <= '1'; alu_r_not_l <= '1';
            when 7 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @-(R) X(R)
    procedure and_at_minus_r_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @-(R) @R
    procedure and_at_minus_r_at_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @-(R) @(R)+
    procedure and_at_minus_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @-(R) @-(R)
    procedure and_at_minus_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @-(R) @X(R)
    procedure and_at_minus_r_at_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 11 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @X(R) R
    procedure and_at_x_r_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => r_dst_out <= '1'; alu_r_not_l <= '1';
            when 9 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @X(R) (R)+
    procedure and_at_x_r_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 9 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 10 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @X(R) -(R)
    procedure and_at_x_r_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_r_minus_1 <= '1';
            when 8 => alu_out <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => r_dst_out <= '1'; alu_r_not_l <= '1';
            when 11 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @X(R) X(R)
    procedure and_at_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 9 => alu_out <= '1'; pc_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 13 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 14 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @X(R) @R
    procedure and_at_x_r_at_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @X(R) @(R)+
    procedure and_at_x_r_at_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 11 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @X(R) @-(R)
    procedure and_at_x_r_at_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 11 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- AND @X(R) @X(R)
    procedure and_at_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 9 => alu_out <= '1'; pc_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 13 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 14 => tmp1_out <= '1'; alu_r_not_l <= '1';
            when 15 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR R R
    procedure or_r_r is
    begin
        case timer is
            when 0 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => r_dst_out <= '1'; alu_r_or_l <= '1'; alu_out <= '1'; r_src_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR R (R)+
    procedure or_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_r_or_l <= '1';
            when 3 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR R -(R)
    procedure or_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_r_or_l <= '1'; alu_out <= '1'; r_src_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR R X(R)
    procedure or_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => r_src_out <= '1'; alu_r_or_l <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR R @R
    procedure or_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 2 => r_src_out <= '1'; alu_r_or_l <= '1';
            when 3 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR R @(R)+
    procedure or_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_src_out <= '1'; alu_r_or_l <= '1';
            when 4 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR R @-(R)
    procedure or_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_src_out <= '1'; alu_r_or_l <= '1';
            when 4 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR R @X(R)
    procedure or_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => r_src_out <= '1'; alu_r_or_l <= '1';
            when 8 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR (R)+ R
    procedure or_r_plus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_r_or_l <= '1';
            when 4 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR (R)+ (R)+
    procedure or_r_plus_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR (R)+ -(R)
    procedure or_r_plus_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_r_or_l <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR (R)+ X(R)
    procedure or_r_plus_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR (R)+ @R
    procedure or_r_plus_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 5 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR (R)+ @(R)+
    procedure or_r_plus_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR (R)+ @-(R)
    procedure or_r_plus_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR (R)+ @X(R)
    procedure or_r_plus_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR -(R) R
    procedure or_minus_r_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_r_or_l <= '1'; alu_out <= '1'; r_src_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR -(R) (R)+
    procedure or_minus_r_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => r_src_out <= '1'; alu_r_or_l <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR -(R) -(R)
    procedure or_minus_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_r_or_l <= '1'; alu_out <= '1'; r_src_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR -(R) X(R)
    procedure or_minus_r_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => r_src_out <= '1'; alu_r_or_l <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR -(R) @R
    procedure or_minus_r_at_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => r_src_out <= '1'; alu_r_or_l <= '1';
            when 5 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR -(R) @(R)+
    procedure or_minus_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_src_out <= '1'; alu_r_or_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR -(R) @-(R)
    procedure or_minus_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_src_out <= '1'; alu_r_or_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR -(R) @X(R)
    procedure or_minus_r_at_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => r_src_out <= '1'; alu_r_or_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR X(R) R
    procedure or_x_r_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => r_dst_out <= '1'; alu_r_or_l <= '1';
            when 8 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR X(R) (R)+
    procedure or_x_r_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 8 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 9 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR X(R) -(R)
    procedure or_x_r_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_r_minus_1 <= '1';
            when 7 => alu_out <= '1';
            when 8 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => r_dst_out <= '1'; alu_r_or_l <= '1';
            when 10 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR X(R) X(R)
    procedure or_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 8 => alu_out <= '1'; pc_in <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 12 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 13 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR X(R) @R
    procedure or_x_r_at_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR X(R) @(R)+
    procedure or_x_r_at_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR X(R) @-(R)
    procedure or_x_r_at_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR X(R) @X(R)
    procedure or_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 8 => alu_out <= '1'; pc_in <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 13 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 14 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @R R
    procedure or_at_r_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_r_or_l <= '1';
            when 4 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @R (R)+
    procedure or_at_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @R -(R)
    procedure or_at_r_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_r_or_l <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @R X(R)
    procedure or_at_r_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @R @R
    procedure or_at_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 5 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @R @(R)+
    procedure or_at_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @R @-(R)
    procedure or_at_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @R @X(R)
    procedure or_at_r_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @(R)+ R
    procedure or_at_r_plus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => r_dst_out <= '1'; alu_r_or_l <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @(R)+ (R)+
    procedure or_at_r_plus_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @(R)+ -(R)
    procedure or_at_r_plus_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1';
            when 4 => alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => r_dst_out <= '1'; alu_r_or_l <= '1';
            when 7 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @(R)+ X(R)
    procedure or_at_r_plus_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @(R)+ @R
    procedure or_at_r_plus_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @(R)+ @(R)+
    procedure or_at_r_plus_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @(R)+ @-(R)
    procedure or_at_r_plus_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @(R)+ @X(R)
    procedure or_at_r_plus_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 11 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @-(R) R
    procedure or_at_minus_r_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => r_dst_out <= '1'; alu_r_or_l <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @-(R) (R)+
    procedure or_at_minus_r_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @-(R) -(R)
    procedure or_at_minus_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1';
            when 4 => alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => r_dst_out <= '1'; alu_r_or_l <= '1';
            when 7 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @-(R) X(R)
    procedure or_at_minus_r_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @-(R) @R
    procedure or_at_minus_r_at_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @-(R) @(R)+
    procedure or_at_minus_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @-(R) @-(R)
    procedure or_at_minus_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @-(R) @X(R)
    procedure or_at_minus_r_at_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 11 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @X(R) R
    procedure or_at_x_r_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => r_dst_out <= '1'; alu_r_or_l <= '1';
            when 9 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @X(R) (R)+
    procedure or_at_x_r_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 9 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 10 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @X(R) -(R)
    procedure or_at_x_r_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_r_minus_1 <= '1';
            when 8 => alu_out <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => r_dst_out <= '1'; alu_r_or_l <= '1';
            when 11 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @X(R) X(R)
    procedure or_at_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 9 => alu_out <= '1'; pc_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 13 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 14 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @X(R) @R
    procedure or_at_x_r_at_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @X(R) @(R)+
    procedure or_at_x_r_at_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 11 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @X(R) @-(R)
    procedure or_at_x_r_at_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 11 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- OR @X(R) @X(R)
    procedure or_at_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 9 => alu_out <= '1'; pc_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 13 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 14 => tmp1_out <= '1'; alu_r_or_l <= '1';
            when 15 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR R R
    procedure xnor_r_r is
    begin
        case timer is
            when 0 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => r_dst_out <= '1'; alu_r_xnor_l <= '1'; alu_out <= '1'; r_src_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR R (R)+
    procedure xnor_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_r_xnor_l <= '1';
            when 3 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR R -(R)
    procedure xnor_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_r_xnor_l <= '1'; alu_out <= '1'; r_src_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR R X(R)
    procedure xnor_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => r_src_out <= '1'; alu_r_xnor_l <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR R @R
    procedure xnor_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 2 => r_src_out <= '1'; alu_r_xnor_l <= '1';
            when 3 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR R @(R)+
    procedure xnor_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_src_out <= '1'; alu_r_xnor_l <= '1';
            when 4 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR R @-(R)
    procedure xnor_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_src_out <= '1'; alu_r_xnor_l <= '1';
            when 4 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR R @X(R)
    procedure xnor_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => r_src_out <= '1'; alu_r_xnor_l <= '1';
            when 8 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR (R)+ R
    procedure xnor_r_plus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_r_xnor_l <= '1';
            when 4 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR (R)+ (R)+
    procedure xnor_r_plus_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR (R)+ -(R)
    procedure xnor_r_plus_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_r_xnor_l <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR (R)+ X(R)
    procedure xnor_r_plus_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR (R)+ @R
    procedure xnor_r_plus_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 5 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR (R)+ @(R)+
    procedure xnor_r_plus_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR (R)+ @-(R)
    procedure xnor_r_plus_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR (R)+ @X(R)
    procedure xnor_r_plus_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR -(R) R
    procedure xnor_minus_r_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_r_xnor_l <= '1'; alu_out <= '1'; r_src_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR -(R) (R)+
    procedure xnor_minus_r_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => r_src_out <= '1'; alu_r_xnor_l <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR -(R) -(R)
    procedure xnor_minus_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_r_xnor_l <= '1'; alu_out <= '1'; r_src_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR -(R) X(R)
    procedure xnor_minus_r_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => r_src_out <= '1'; alu_r_xnor_l <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR -(R) @R
    procedure xnor_minus_r_at_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => r_src_out <= '1'; alu_r_xnor_l <= '1';
            when 5 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR -(R) @(R)+
    procedure xnor_minus_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_src_out <= '1'; alu_r_xnor_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR -(R) @-(R)
    procedure xnor_minus_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_src_out <= '1'; alu_r_xnor_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR -(R) @X(R)
    procedure xnor_minus_r_at_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => r_src_out <= '1'; alu_r_xnor_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR X(R) R
    procedure xnor_x_r_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => r_dst_out <= '1'; alu_r_xnor_l <= '1';
            when 8 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR X(R) (R)+
    procedure xnor_x_r_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 8 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 9 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR X(R) -(R)
    procedure xnor_x_r_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_r_minus_1 <= '1';
            when 7 => alu_out <= '1';
            when 8 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => r_dst_out <= '1'; alu_r_xnor_l <= '1';
            when 10 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR X(R) X(R)
    procedure xnor_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 8 => alu_out <= '1'; pc_in <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 12 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 13 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR X(R) @R
    procedure xnor_x_r_at_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR X(R) @(R)+
    procedure xnor_x_r_at_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR X(R) @-(R)
    procedure xnor_x_r_at_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR X(R) @X(R)
    procedure xnor_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 8 => alu_out <= '1'; pc_in <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 13 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 14 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @R R
    procedure xnor_at_r_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_r_xnor_l <= '1';
            when 4 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @R (R)+
    procedure xnor_at_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @R -(R)
    procedure xnor_at_r_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_r_xnor_l <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @R X(R)
    procedure xnor_at_r_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 9 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @R @R
    procedure xnor_at_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 5 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @R @(R)+
    procedure xnor_at_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @R @-(R)
    procedure xnor_at_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @R @X(R)
    procedure xnor_at_r_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @(R)+ R
    procedure xnor_at_r_plus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => r_dst_out <= '1'; alu_r_xnor_l <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @(R)+ (R)+
    procedure xnor_at_r_plus_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @(R)+ -(R)
    procedure xnor_at_r_plus_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1';
            when 4 => alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => r_dst_out <= '1'; alu_r_xnor_l <= '1';
            when 7 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @(R)+ X(R)
    procedure xnor_at_r_plus_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @(R)+ @R
    procedure xnor_at_r_plus_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @(R)+ @(R)+
    procedure xnor_at_r_plus_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @(R)+ @-(R)
    procedure xnor_at_r_plus_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @(R)+ @X(R)
    procedure xnor_at_r_plus_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 11 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @-(R) R
    procedure xnor_at_minus_r_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => r_dst_out <= '1'; alu_r_xnor_l <= '1';
            when 5 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @-(R) (R)+
    procedure xnor_at_minus_r_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 6 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @-(R) -(R)
    procedure xnor_at_minus_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1';
            when 4 => alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => r_dst_out <= '1'; alu_r_xnor_l <= '1';
            when 7 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @-(R) X(R)
    procedure xnor_at_minus_r_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @-(R) @R
    procedure xnor_at_minus_r_at_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 6 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @-(R) @(R)+
    procedure xnor_at_minus_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @-(R) @-(R)
    procedure xnor_at_minus_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @-(R) @X(R)
    procedure xnor_at_minus_r_at_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 11 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @X(R) R
    procedure xnor_at_x_r_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => r_dst_out <= '1'; alu_r_xnor_l <= '1';
            when 9 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @X(R) (R)+
    procedure xnor_at_x_r_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 9 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 10 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @X(R) -(R)
    procedure xnor_at_x_r_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_r_minus_1 <= '1';
            when 8 => alu_out <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => r_dst_out <= '1'; alu_r_xnor_l <= '1';
            when 11 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @X(R) X(R)
    procedure xnor_at_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 9 => alu_out <= '1'; pc_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 13 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 14 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @X(R) @R
    procedure xnor_at_x_r_at_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 10 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @X(R) @(R)+
    procedure xnor_at_x_r_at_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 11 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @X(R) @-(R)
    procedure xnor_at_x_r_at_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 11 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- XNOR @X(R) @X(R)
    procedure xnor_at_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 9 => alu_out <= '1'; pc_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 13 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 14 => tmp1_out <= '1'; alu_r_xnor_l <= '1';
            when 15 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP R R
    procedure cmp_r_r is
    begin
        case timer is
            when 0 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP R (R)+
    procedure cmp_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP R -(R)
    procedure cmp_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP R X(R)
    procedure cmp_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP R @R
    procedure cmp_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP R @(R)+
    procedure cmp_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP R @-(R)
    procedure cmp_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP R @X(R)
    procedure cmp_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP (R)+ R
    procedure cmp_r_plus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP (R)+ (R)+
    procedure cmp_r_plus_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP (R)+ -(R)
    procedure cmp_r_plus_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP (R)+ X(R)
    procedure cmp_r_plus_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 11 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP (R)+ @R
    procedure cmp_r_plus_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP (R)+ @(R)+
    procedure cmp_r_plus_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP (R)+ @-(R)
    procedure cmp_r_plus_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP (R)+ @X(R)
    procedure cmp_r_plus_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP -(R) R
    procedure cmp_minus_r_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP -(R) (R)+
    procedure cmp_minus_r_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP -(R) -(R)
    procedure cmp_minus_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP -(R) X(R)
    procedure cmp_minus_r_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP -(R) @R
    procedure cmp_minus_r_at_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 4 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP -(R) @(R)+
    procedure cmp_minus_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 5 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP -(R) @-(R)
    procedure cmp_minus_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 5 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP -(R) @X(R)
    procedure cmp_minus_r_at_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 9 => r_src_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP X(R) R
    procedure cmp_x_r_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP X(R) (R)+
    procedure cmp_x_r_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 8 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 11 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP X(R) -(R)
    procedure cmp_x_r_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_r_minus_1 <= '1';
            when 7 => alu_out <= '1';
            when 8 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP X(R) X(R)
    procedure cmp_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 8 => alu_out <= '1'; pc_in <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 12 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 13 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 14 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 15 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP X(R) @R
    procedure cmp_x_r_at_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 11 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP X(R) @(R)+
    procedure cmp_x_r_at_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP X(R) @-(R)
    procedure cmp_x_r_at_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP X(R) @X(R)
    procedure cmp_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 6 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 8 => alu_out <= '1'; pc_in <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 13 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 14 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 15 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 16 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @R R
    procedure cmp_at_r_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @R (R)+
    procedure cmp_at_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @R -(R)
    procedure cmp_at_r_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @R X(R)
    procedure cmp_at_r_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 11 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @R @R
    procedure cmp_at_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @R @(R)+
    procedure cmp_at_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @R @-(R)
    procedure cmp_at_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @R @X(R)
    procedure cmp_at_r_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 2 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 3 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; pc_in <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @(R)+ R
    procedure cmp_at_r_plus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @(R)+ (R)+
    procedure cmp_at_r_plus_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @(R)+ -(R)
    procedure cmp_at_r_plus_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1';
            when 4 => alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @(R)+ X(R)
    procedure cmp_at_r_plus_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @(R)+ @R
    procedure cmp_at_r_plus_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @(R)+ @(R)+
    procedure cmp_at_r_plus_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 9 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @(R)+ @-(R)
    procedure cmp_at_r_plus_at_minus_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 9 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @(R)+ @X(R)
    procedure cmp_at_r_plus_at_x_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 11 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 13 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @-(R) R
    procedure cmp_at_minus_r_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @-(R) (R)+
    procedure cmp_at_minus_r_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @-(R) -(R)
    procedure cmp_at_minus_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1';
            when 4 => alu_out <= '1';
            when 5 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @-(R) X(R)
    procedure cmp_at_minus_r_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @-(R) @R
    procedure cmp_at_minus_r_at_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 6 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 8 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @-(R) @(R)+
    procedure cmp_at_minus_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 9 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @-(R) @-(R)
    procedure cmp_at_minus_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 9 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @-(R) @X(R)
    procedure cmp_at_minus_r_at_x_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 1 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 3 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 5 => alu_out <= '1'; pc_in <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 11 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 13 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @X(R) R
    procedure cmp_at_x_r_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @X(R) (R)+
    procedure cmp_at_x_r_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @X(R) -(R)
    procedure cmp_at_x_r_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_r_minus_1 <= '1';
            when 8 => alu_out <= '1';
            when 9 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => r_dst_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @X(R) X(R)
    procedure cmp_at_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 9 => alu_out <= '1'; pc_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 13 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 14 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 15 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 16 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @X(R) @R
    procedure cmp_at_x_r_at_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 9 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 10 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 12 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @X(R) @(R)+
    procedure cmp_at_x_r_at_r_plus is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 11 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 13 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @X(R) @-(R)
    procedure cmp_at_x_r_at_minus_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 8 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 9 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 10 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 11 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 13 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CMP @X(R) @X(R)
    procedure cmp_at_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 7 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 9 => alu_out <= '1'; pc_in <= '1';
            when 10 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 11 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 12 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 13 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 14 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 15 => tmp1_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 16 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp1_in <= '1';
            when 17 => tmp1_out <= '1'; alu_c_eq_0 <= '1'; alu_r_minus_l_minus_c <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- INC @X(R) R
    procedure inc_at_x_r_r is
    begin
        case timer is
            when 0 => alu_r_plus_1 <= '1';
            when 1 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- INC @X(R) (R)+
    procedure inc_at_x_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => tmp0_out <= '1'; alu_r_plus_1 <= '1';
            when 3 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- INC @X(R) -(R)
    procedure inc_at_x_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_r_plus_1 <= '1';
            when 3 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- INC @X(R) X(R)
    procedure inc_at_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp0_out <= '1'; alu_r_plus_1 <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- INC @X(R) @R
    procedure inc_at_x_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 2 => tmp0_out <= '1'; alu_r_plus_1 <= '1';
            when 3 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- INC @X(R) @(R)+
    procedure inc_at_x_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- INC @X(R) @-(R)
    procedure inc_at_x_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_plus_1 <= '1';
            when 4 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- INC @X(R) @X(R)
    procedure inc_at_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp0_out <= '1'; alu_r_plus_1 <= '1';
            when 8 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- DEC @X(R) R
    procedure dec_at_x_r_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- DEC @X(R) (R)+
    procedure dec_at_x_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => tmp0_out <= '1'; alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- DEC @X(R) -(R)
    procedure dec_at_x_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- DEC @X(R) X(R)
    procedure dec_at_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp0_out <= '1'; alu_r_minus_1 <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- DEC @X(R) @R
    procedure dec_at_x_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 2 => tmp0_out <= '1'; alu_r_minus_1 <= '1';
            when 3 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- DEC @X(R) @(R)+
    procedure dec_at_x_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_minus_1 <= '1';
            when 4 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- DEC @X(R) @-(R)
    procedure dec_at_x_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_r_minus_1 <= '1';
            when 4 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- DEC @X(R) @X(R)
    procedure dec_at_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp0_out <= '1'; alu_r_minus_1 <= '1';
            when 8 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CLR @X(R) R
    procedure clr_at_x_r_r is
    begin
        case timer is
            when 0 => alu_zero <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CLR @X(R) (R)+
    procedure clr_at_x_r_r_plus is
    begin
        case timer is
            when 0 => alu_zero <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CLR @X(R) -(R)
    procedure clr_at_x_r_minus_r is
    begin
        case timer is
            when 0 => alu_zero <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CLR @X(R) X(R)
    procedure clr_at_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1';
            when 5 => alu_zero <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CLR @X(R) @R
    procedure clr_at_x_r_at_r is
    begin
        case timer is
            when 0 => r_dst_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1';
            when 1 => alu_zero <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CLR @X(R) @(R)+
    procedure clr_at_x_r_at_r_plus is
    begin
        case timer is
            when 0 => r_dst_out <= '1'; alu_eq_r <= '1'; mar_in <= '1';
            when 1 => alu_zero <= '1'; mdr_in <= '1'; wr <= '1';
            when 2 => alu_r_plus_1 <= '1';
            when 3 => alu_out <= '1';
            when 4 => alu_zero <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CLR @X(R) @-(R)
    procedure clr_at_x_r_at_minus_r is
    begin
        case timer is
            when 0 => r_dst_out <= '1'; alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1'; mar_in <= '1';
            when 1 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1';
            when 2 => alu_zero <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- CLR @X(R) @X(R)
    procedure clr_at_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1';
            when 5 => alu_zero <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- INV @X(R) R
    procedure inv_at_x_r_r is
    begin
        case timer is
            when 0 => alu_not_r <= '1';
            when 1 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- INV @X(R) (R)+
    procedure inv_at_x_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => tmp0_out <= '1'; alu_not_r <= '1';
            when 3 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- INV @X(R) -(R)
    procedure inv_at_x_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1';
            when 2 => alu_not_r <= '1';
            when 3 => alu_out <= '1'; r_dst_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- INV @X(R) X(R)
    procedure inv_at_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 6 => tmp0_out <= '1'; alu_not_r <= '1';
            when 7 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- INV @X(R) @R
    procedure inv_at_x_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 2 => tmp0_out <= '1'; alu_not_r <= '1';
            when 3 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- INV @X(R) @(R)+
    procedure inv_at_x_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_not_r <= '1';
            when 4 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- INV @X(R) @-(R)
    procedure inv_at_x_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 3 => tmp0_out <= '1'; alu_not_r <= '1';
            when 4 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- INV @X(R) @X(R)
    procedure inv_at_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 7 => tmp0_out <= '1'; alu_not_r <= '1';
            when 8 => alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- LSR @X(R) R
    procedure lsr_at_x_r_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_c_eq_0 <= '1'; alu_rrc <= '1';
            when 1 => alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- LSR @X(R) (R)+
    procedure lsr_at_x_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_c_eq_0 <= '1'; alu_rrc <= '1';
            when 1 => alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- LSR @X(R) -(R)
    procedure lsr_at_x_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_c_eq_0 <= '1'; alu_rrc <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- LSR @X(R) X(R)
    procedure lsr_at_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_rrc <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- LSR @X(R) @R
    procedure lsr_at_x_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1';
            when 2 => alu_c_eq_0 <= '1'; alu_rrc <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- LSR @X(R) @(R)+
    procedure lsr_at_x_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1';
            when 3 => alu_c_eq_0 <= '1'; alu_rrc <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- LSR @X(R) @-(R)
    procedure lsr_at_x_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1';
            when 3 => alu_c_eq_0 <= '1'; alu_rrc <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- LSR @X(R) @X(R)
    procedure lsr_at_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1';
            when 7 => alu_c_eq_0 <= '1'; alu_rrc <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ROR @X(R) R
    procedure ror_at_x_r_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_ror <= '1';
            when 1 => alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ROR @X(R) (R)+
    procedure ror_at_x_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_ror <= '1';
            when 1 => alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ROR @X(R) -(R)
    procedure ror_at_x_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_ror <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ROR @X(R) X(R)
    procedure ror_at_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1';
            when 6 => alu_ror <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ROR @X(R) @R
    procedure ror_at_x_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1';
            when 2 => alu_ror <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ROR @X(R) @(R)+
    procedure ror_at_x_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1';
            when 3 => alu_ror <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ROR @X(R) @-(R)
    procedure ror_at_x_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1';
            when 3 => alu_ror <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ROR @X(R) @X(R)
    procedure ror_at_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1';
            when 7 => alu_ror <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- RRC @X(R) R
    procedure rrc_at_x_r_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_rrc <= '1';
            when 1 => alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- RRC @X(R) (R)+
    procedure rrc_at_x_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_rrc <= '1';
            when 1 => alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- RRC @X(R) -(R)
    procedure rrc_at_x_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_rrc <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- RRC @X(R) X(R)
    procedure rrc_at_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1';
            when 6 => alu_rrc <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- RRC @X(R) @R
    procedure rrc_at_x_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1';
            when 2 => alu_rrc <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- RRC @X(R) @(R)+
    procedure rrc_at_x_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1';
            when 3 => alu_rrc <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- RRC @X(R) @-(R)
    procedure rrc_at_x_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1';
            when 3 => alu_rrc <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- RRC @X(R) @X(R)
    procedure rrc_at_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1';
            when 7 => alu_rrc <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ASR @X(R) R
    procedure asr_at_x_r_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_asr <= '1';
            when 1 => alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ASR @X(R) (R)+
    procedure asr_at_x_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_asr <= '1';
            when 1 => alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ASR @X(R) -(R)
    procedure asr_at_x_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_asr <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ASR @X(R) X(R)
    procedure asr_at_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1';
            when 6 => alu_asr <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ASR @X(R) @R
    procedure asr_at_x_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1';
            when 2 => alu_asr <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ASR @X(R) @(R)+
    procedure asr_at_x_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1';
            when 3 => alu_asr <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ASR @X(R) @-(R)
    procedure asr_at_x_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1';
            when 3 => alu_asr <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ASR @X(R) @X(R)
    procedure asr_at_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1';
            when 7 => alu_asr <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- LSL @X(R) R
    procedure lsl_at_x_r_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_c_eq_0 <= '1'; alu_rlc <= '1';
            when 1 => alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- LSL @X(R) (R)+
    procedure lsl_at_x_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_c_eq_0 <= '1'; alu_rlc <= '1';
            when 1 => alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- LSL @X(R) -(R)
    procedure lsl_at_x_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_c_eq_0 <= '1'; alu_rlc <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- LSL @X(R) X(R)
    procedure lsl_at_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1';
            when 6 => alu_c_eq_0 <= '1'; alu_rlc <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- LSL @X(R) @R
    procedure lsl_at_x_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1';
            when 2 => alu_c_eq_0 <= '1'; alu_rlc <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- LSL @X(R) @(R)+
    procedure lsl_at_x_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1';
            when 3 => alu_c_eq_0 <= '1'; alu_rlc <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- LSL @X(R) @-(R)
    procedure lsl_at_x_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1';
            when 3 => alu_c_eq_0 <= '1'; alu_rlc <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- LSL @X(R) @X(R)
    procedure lsl_at_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1';
            when 7 => alu_c_eq_0 <= '1'; alu_rlc <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ROL @X(R) R
    procedure rol_at_x_r_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_rol <= '1';
            when 1 => alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ROL @X(R) (R)+
    procedure rol_at_x_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_rol <= '1';
            when 1 => alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ROL @X(R) -(R)
    procedure rol_at_x_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_rol <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ROL @X(R) X(R)
    procedure rol_at_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1';
            when 6 => alu_rol <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ROL @X(R) @R
    procedure rol_at_x_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1';
            when 2 => alu_rol <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ROL @X(R) @(R)+
    procedure rol_at_x_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1';
            when 3 => alu_rol <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ROL @X(R) @-(R)
    procedure rol_at_x_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1';
            when 3 => alu_rol <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- ROL @X(R) @X(R)
    procedure rol_at_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1';
            when 7 => alu_rol <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- RLC @X(R) R
    procedure rlc_at_x_r_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_rlc <= '1';
            when 1 => alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- RLC @X(R) (R)+
    procedure rlc_at_x_r_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_rlc <= '1';
            when 1 => alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- RLC @X(R) -(R)
    procedure rlc_at_x_r_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_rlc <= '1'; alu_out <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- RLC @X(R) X(R)
    procedure rlc_at_x_r_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1';
            when 6 => alu_rlc <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- RLC @X(R) @R
    procedure rlc_at_x_r_at_r is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; alu_eq_r <= '1';
            when 2 => alu_rlc <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- RLC @X(R) @(R)+
    procedure rlc_at_x_r_at_r_plus is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mar_out <= '1'; alu_r_plus_1 <= '1'; alu_out <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1';
            when 3 => alu_rlc <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- RLC @X(R) @-(R)
    procedure rlc_at_x_r_at_minus_r is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 2 => mdr_out <= '1'; alu_eq_r <= '1';
            when 3 => alu_rlc <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- RLC @X(R) @X(R)
    procedure rlc_at_x_r_at_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 6 => mdr_out <= '1'; alu_eq_r <= '1';
            when 7 => alu_rlc <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- BR
    procedure br is
    begin
        case timer is
            when 0 => ir_addr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 1 => pc_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- BEQ
    procedure beq is
    begin
        case timer is
            when 0 => if not (zero_flag = '1') then end_flag := 1; end if;
            when 1 => ir_addr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 2 => pc_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 3 => alu_out <= '1'; pc_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- BNE
    procedure bne is
    begin
        case timer is
            when 0 => if not (zero_flag = '0') then end_flag := 1; end if;
            when 1 => ir_addr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 2 => pc_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 3 => alu_out <= '1'; pc_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- BLO
    procedure blo is
    begin
        case timer is
            when 0 => if not (carry_flag = '0') then end_flag := 1; end if;
            when 1 => ir_addr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 2 => pc_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 3 => alu_out <= '1'; pc_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- BLS
    procedure bls is
    begin
        case timer is
            when 0 => if not (carry_flag = '0' or zero_flag = '1') then end_flag := 1; end if;
            when 1 => ir_addr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 2 => pc_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 3 => alu_out <= '1'; pc_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- BHI
    procedure bhi is
    begin
        case timer is
            when 0 => if not (carry_flag = '1') then end_flag := 1; end if;
            when 1 => ir_addr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 2 => pc_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 3 => alu_out <= '1'; pc_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- BHS
    procedure bhs is
    begin
        case timer is
            when 0 => if not (carry_flag = '1' or zero_flag = '1') then end_flag := 1; end if;
            when 1 => ir_addr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 2 => pc_out <= '1'; alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1';
            when 3 => alu_out <= '1'; pc_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- HLT
    procedure hlt is
    begin
        case timer is
            when others => end_flag := 1;
        end case;
    end procedure;

    -- NOP
    procedure nop is
    begin
        case timer is
            when others => end_flag := 1;
        end case;
    end procedure;

    -- JSR X(R)
    procedure jsr_x_r is
    begin
        case timer is
            when 0 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => pc_out <= '1'; alu_r_plus_1 <= '1';
            when 2 => alu_out <= '1'; pc_in <= '1';
            when 3 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 4 => alu_c_eq_0 <= '1'; alu_r_plus_l_plus_c <= '1'; alu_out <= '1'; tmp0_in <= '1';
            when 5 => alu_r_minus_1 <= '1';
            when 6 => alu_out <= '1'; mar_in <= '1';
            when 7 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1'; wr <= '1';
            when 8 => tmp0_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; pc_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- RTS
    procedure rts is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; pc_in <= '1';
            when 2 => alu_r_plus_1 <= '1';
            when 3 => alu_out <= '1'; mar_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- INT
    procedure int is
    begin
        case timer is
            when 0 => alu_r_minus_1 <= '1';
            when 1 => alu_out <= '1'; mar_in <= '1';
            when 2 => flags_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 3 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 4 => alu_r_minus_1 <= '1';
            when 5 => alu_out <= '1'; mar_in <= '1';
            when 6 => pc_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; mdr_in <= '1';
            when 7 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 8 => pc_in <= '1'; hardware_address_out_l <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;

    -- IRET
    procedure iret is
    begin
        case timer is
            when 0 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 1 => mdr_out <= '1'; pc_in <= '1';
            when 2 => alu_r_plus_1 <= '1';
            when 3 => alu_out <= '1'; mar_in <= '1';
            when 4 => alu_eq_r <= '1'; alu_out <= '1'; mar_in <= '1'; rd <= '1';
            when 5 => mdr_out <= '1'; alu_eq_r <= '1'; alu_out <= '1'; flags_in <= '1';
            when 6 => alu_r_plus_1 <= '1';
            when 7 => alu_out <= '1'; mar_in <= '1';
            when others => end_flag := 1;
        end case;
    end procedure;
begin

    process (clk)
    begin
        if hlt = 0 and rising_edge(clk) then
            clk_ticks := clk_ticks + 1;

            if clk_ticks = MAX_CLK_TICKS then
                clk_ticks := 0;

                zero_all_out();
                execute_instr();
            end if;

            if end = 1 then
                end_flag := 0;
                timer := 0;
                zero_all_out();
            end if;
        end if;
    end process;

end architecture;
