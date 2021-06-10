/*
 * Created by 
   ../bin/Linux-x86_64-O/oasysGui 19.2-p002 on Wed May  5 19:01:24 2021
 * (C) Mentor Graphics Corporation
 */
/* CheckSum: 1894647967 */

module fixed_point_modification(result, modifiedOut);
   input [31:0]result;
   output [15:0]modifiedOut;

   wire n_0_0;
   wire n_0_1;
   wire n_0_2;
   wire n_0_3;
   wire n_0_4;
   wire n_0_5;
   wire n_0_6;
   wire n_0_7;
   wire n_0_8;
   wire n_0_9;
   wire n_0_10;
   wire n_0_11;
   wire n_0_12;
   wire n_0_13;
   wire n_0_14;
   wire n_0_15;
   wire n_0_16;
   wire n_0_17;
   wire n_0_18;
   wire n_0_19;
   wire n_0_20;
   wire n_0_21;
   wire n_0_22;
   wire n_0_23;
   wire n_0_24;

   HA_X1 i_0_0 (.A(result[27]), .B(result[26]), .CO(n_0_0), .S());
   HA_X1 i_0_1 (.A(result[28]), .B(n_0_0), .CO(n_0_1), .S());
   HA_X1 i_0_2 (.A(result[29]), .B(n_0_1), .CO(n_0_2), .S());
   HA_X1 i_0_3 (.A(result[30]), .B(n_0_2), .CO(n_0_3), .S());
   HA_X1 i_0_4 (.A(result[31]), .B(n_0_3), .CO(n_0_4), .S());
   INV_X1 i_0_5 (.A(result[31]), .ZN(n_0_5));
   OR4_X1 i_0_6 (.A1(result[28]), .A2(result[27]), .A3(result[26]), .A4(
      result[29]), .ZN(n_0_6));
   OAI21_X1 i_0_7 (.A(n_0_5), .B1(n_0_6), .B2(result[30]), .ZN(n_0_7));
   INV_X1 i_0_8 (.A(n_0_4), .ZN(n_0_8));
   OAI221_X1 i_0_9 (.A(n_0_7), .B1(n_0_8), .B2(result[31]), .C1(n_0_4), .C2(
      n_0_5), .ZN(n_0_9));
   INV_X1 i_0_10 (.A(result[11]), .ZN(n_0_10));
   OAI21_X1 i_0_11 (.A(n_0_7), .B1(n_0_9), .B2(n_0_10), .ZN(modifiedOut[0]));
   INV_X1 i_0_12 (.A(result[12]), .ZN(n_0_11));
   OAI21_X1 i_0_13 (.A(n_0_7), .B1(n_0_9), .B2(n_0_11), .ZN(modifiedOut[1]));
   INV_X1 i_0_14 (.A(result[13]), .ZN(n_0_12));
   OAI21_X1 i_0_15 (.A(n_0_7), .B1(n_0_9), .B2(n_0_12), .ZN(modifiedOut[2]));
   INV_X1 i_0_16 (.A(result[14]), .ZN(n_0_13));
   OAI21_X1 i_0_17 (.A(n_0_7), .B1(n_0_9), .B2(n_0_13), .ZN(modifiedOut[3]));
   INV_X1 i_0_18 (.A(result[15]), .ZN(n_0_14));
   OAI21_X1 i_0_19 (.A(n_0_7), .B1(n_0_9), .B2(n_0_14), .ZN(modifiedOut[4]));
   INV_X1 i_0_20 (.A(result[16]), .ZN(n_0_15));
   OAI21_X1 i_0_21 (.A(n_0_7), .B1(n_0_9), .B2(n_0_15), .ZN(modifiedOut[5]));
   INV_X1 i_0_22 (.A(result[17]), .ZN(n_0_16));
   OAI21_X1 i_0_23 (.A(n_0_7), .B1(n_0_9), .B2(n_0_16), .ZN(modifiedOut[6]));
   INV_X1 i_0_24 (.A(result[18]), .ZN(n_0_17));
   OAI21_X1 i_0_25 (.A(n_0_7), .B1(n_0_9), .B2(n_0_17), .ZN(modifiedOut[7]));
   INV_X1 i_0_26 (.A(result[19]), .ZN(n_0_18));
   OAI21_X1 i_0_27 (.A(n_0_7), .B1(n_0_9), .B2(n_0_18), .ZN(modifiedOut[8]));
   INV_X1 i_0_28 (.A(result[20]), .ZN(n_0_19));
   OAI21_X1 i_0_29 (.A(n_0_7), .B1(n_0_9), .B2(n_0_19), .ZN(modifiedOut[9]));
   INV_X1 i_0_30 (.A(result[21]), .ZN(n_0_20));
   OAI21_X1 i_0_31 (.A(n_0_7), .B1(n_0_9), .B2(n_0_20), .ZN(modifiedOut[10]));
   INV_X1 i_0_32 (.A(result[22]), .ZN(n_0_21));
   OAI21_X1 i_0_33 (.A(n_0_7), .B1(n_0_9), .B2(n_0_21), .ZN(modifiedOut[11]));
   INV_X1 i_0_34 (.A(result[23]), .ZN(n_0_22));
   OAI21_X1 i_0_35 (.A(n_0_7), .B1(n_0_9), .B2(n_0_22), .ZN(modifiedOut[12]));
   INV_X1 i_0_36 (.A(result[24]), .ZN(n_0_23));
   OAI21_X1 i_0_37 (.A(n_0_7), .B1(n_0_9), .B2(n_0_23), .ZN(modifiedOut[13]));
   INV_X1 i_0_38 (.A(result[25]), .ZN(n_0_24));
   OAI21_X1 i_0_39 (.A(n_0_7), .B1(n_0_9), .B2(n_0_24), .ZN(modifiedOut[14]));
endmodule

module datapath__0_6(M, p_0);
   input [15:0]M;
   output [15:0]p_0;

   XOR2_X1 i_0 (.A(M[1]), .B(M[0]), .Z(p_0[1]));
   AND2_X1 i_1 (.A1(n_13), .A2(n_0), .ZN(p_0[2]));
   OAI21_X1 i_2 (.A(M[2]), .B1(M[1]), .B2(M[0]), .ZN(n_0));
   XOR2_X1 i_3 (.A(M[3]), .B(n_13), .Z(p_0[3]));
   XOR2_X1 i_4 (.A(M[4]), .B(n_12), .Z(p_0[4]));
   XOR2_X1 i_5 (.A(M[5]), .B(n_11), .Z(p_0[5]));
   AND2_X1 i_6 (.A1(n_10), .A2(n_1), .ZN(p_0[6]));
   OAI21_X1 i_7 (.A(M[6]), .B1(n_11), .B2(M[5]), .ZN(n_1));
   XOR2_X1 i_8 (.A(M[7]), .B(n_10), .Z(p_0[7]));
   XOR2_X1 i_9 (.A(M[8]), .B(n_9), .Z(p_0[8]));
   AND2_X1 i_10 (.A1(n_8), .A2(n_2), .ZN(p_0[9]));
   OAI21_X1 i_11 (.A(M[9]), .B1(n_9), .B2(M[8]), .ZN(n_2));
   XOR2_X1 i_12 (.A(M[10]), .B(n_8), .Z(p_0[10]));
   XOR2_X1 i_13 (.A(M[11]), .B(n_7), .Z(p_0[11]));
   XOR2_X1 i_14 (.A(M[12]), .B(n_6), .Z(p_0[12]));
   XNOR2_X1 i_15 (.A(M[13]), .B(n_5), .ZN(p_0[13]));
   XNOR2_X1 i_16 (.A(M[14]), .B(n_4), .ZN(p_0[14]));
   XNOR2_X1 i_17 (.A(M[15]), .B(n_3), .ZN(p_0[15]));
   NOR4_X1 i_18 (.A1(n_6), .A2(M[12]), .A3(M[13]), .A4(M[14]), .ZN(n_3));
   NOR3_X1 i_19 (.A1(n_6), .A2(M[12]), .A3(M[13]), .ZN(n_4));
   NOR2_X1 i_20 (.A1(n_6), .A2(M[12]), .ZN(n_5));
   OR2_X1 i_21 (.A1(n_7), .A2(M[11]), .ZN(n_6));
   OR2_X1 i_22 (.A1(n_8), .A2(M[10]), .ZN(n_7));
   OR3_X1 i_23 (.A1(n_9), .A2(M[8]), .A3(M[9]), .ZN(n_8));
   OR2_X1 i_24 (.A1(n_10), .A2(M[7]), .ZN(n_9));
   OR3_X1 i_25 (.A1(n_11), .A2(M[5]), .A3(M[6]), .ZN(n_10));
   OR2_X1 i_26 (.A1(n_12), .A2(M[4]), .ZN(n_11));
   OR2_X1 i_27 (.A1(n_13), .A2(M[3]), .ZN(n_12));
   OR3_X1 i_28 (.A1(M[2]), .A2(M[1]), .A3(M[0]), .ZN(n_13));
endmodule

module datapath__0_7(S, P, p_0);
   input [32:0]S;
   input [32:0]P;
   output [32:0]p_0;

   FA_X1 i_17 (.A(S[17]), .B(P[17]), .CI(1'b0), .CO(n_0), .S(p_0[17]));
   FA_X1 i_18 (.A(S[18]), .B(P[18]), .CI(n_0), .CO(n_1), .S(p_0[18]));
   FA_X1 i_19 (.A(S[19]), .B(P[19]), .CI(n_1), .CO(n_2), .S(p_0[19]));
   FA_X1 i_20 (.A(S[20]), .B(P[20]), .CI(n_2), .CO(n_3), .S(p_0[20]));
   FA_X1 i_21 (.A(S[21]), .B(P[21]), .CI(n_3), .CO(n_4), .S(p_0[21]));
   FA_X1 i_22 (.A(S[22]), .B(P[22]), .CI(n_4), .CO(n_5), .S(p_0[22]));
   FA_X1 i_23 (.A(S[23]), .B(P[23]), .CI(n_5), .CO(n_6), .S(p_0[23]));
   FA_X1 i_24 (.A(S[24]), .B(P[24]), .CI(n_6), .CO(n_7), .S(p_0[24]));
   FA_X1 i_25 (.A(S[25]), .B(P[25]), .CI(n_7), .CO(n_8), .S(p_0[25]));
   FA_X1 i_26 (.A(S[26]), .B(P[26]), .CI(n_8), .CO(n_9), .S(p_0[26]));
   FA_X1 i_27 (.A(S[27]), .B(P[27]), .CI(n_9), .CO(n_10), .S(p_0[27]));
   FA_X1 i_28 (.A(S[28]), .B(P[28]), .CI(n_10), .CO(n_11), .S(p_0[28]));
   FA_X1 i_29 (.A(S[29]), .B(P[29]), .CI(n_11), .CO(n_12), .S(p_0[29]));
   FA_X1 i_30 (.A(S[30]), .B(P[30]), .CI(n_12), .CO(n_13), .S(p_0[30]));
   FA_X1 i_31 (.A(S[31]), .B(P[31]), .CI(n_13), .CO(n_14), .S(p_0[31]));
   XNOR2_X1 i_32 (.A(S[32]), .B(P[32]), .ZN(n_15));
   XNOR2_X1 i_33 (.A(n_15), .B(n_14), .ZN(p_0[32]));
endmodule

module datapath__0_8(A, P, p_0);
   input [32:0]A;
   input [32:0]P;
   output [32:0]p_0;

   FA_X1 i_17 (.A(A[17]), .B(P[17]), .CI(1'b0), .CO(n_0), .S(p_0[17]));
   FA_X1 i_18 (.A(A[18]), .B(P[18]), .CI(n_0), .CO(n_1), .S(p_0[18]));
   FA_X1 i_19 (.A(A[19]), .B(P[19]), .CI(n_1), .CO(n_2), .S(p_0[19]));
   FA_X1 i_20 (.A(A[20]), .B(P[20]), .CI(n_2), .CO(n_3), .S(p_0[20]));
   FA_X1 i_21 (.A(A[21]), .B(P[21]), .CI(n_3), .CO(n_4), .S(p_0[21]));
   FA_X1 i_22 (.A(A[22]), .B(P[22]), .CI(n_4), .CO(n_5), .S(p_0[22]));
   FA_X1 i_23 (.A(A[23]), .B(P[23]), .CI(n_5), .CO(n_6), .S(p_0[23]));
   FA_X1 i_24 (.A(A[24]), .B(P[24]), .CI(n_6), .CO(n_7), .S(p_0[24]));
   FA_X1 i_25 (.A(A[25]), .B(P[25]), .CI(n_7), .CO(n_8), .S(p_0[25]));
   FA_X1 i_26 (.A(A[26]), .B(P[26]), .CI(n_8), .CO(n_9), .S(p_0[26]));
   FA_X1 i_27 (.A(A[27]), .B(P[27]), .CI(n_9), .CO(n_10), .S(p_0[27]));
   FA_X1 i_28 (.A(A[28]), .B(P[28]), .CI(n_10), .CO(n_11), .S(p_0[28]));
   FA_X1 i_29 (.A(A[29]), .B(P[29]), .CI(n_11), .CO(n_12), .S(p_0[29]));
   FA_X1 i_30 (.A(A[30]), .B(P[30]), .CI(n_12), .CO(n_13), .S(p_0[30]));
   FA_X1 i_31 (.A(A[31]), .B(P[31]), .CI(n_13), .CO(n_14), .S(p_0[31]));
   XNOR2_X1 i_32 (.A(A[32]), .B(P[32]), .ZN(n_15));
   XNOR2_X1 i_33 (.A(n_15), .B(n_14), .ZN(p_0[32]));
endmodule

module Multiplier(M, R, fixedMulResult, clk, finish, enable, reset);
   input [15:0]M;
   input [15:0]R;
   output [15:0]fixedMulResult;
   input clk;
   output finish;
   input enable;
   input reset;

   wire n_0_114;
   wire n_0_8;
   wire n_0_9;
   wire n_0_10;
   wire n_0_11;
   wire n_0_12;
   wire n_0_13;
   wire n_0_14;
   wire n_0_15;
   wire n_0_16;
   wire n_0_17;
   wire n_0_18;
   wire n_0_19;
   wire n_0_20;
   wire n_0_21;
   wire n_0_22;
   wire n_0_39;
   wire n_0_40;
   wire n_0_41;
   wire n_0_42;
   wire n_0_43;
   wire n_0_44;
   wire n_0_45;
   wire n_0_46;
   wire n_0_47;
   wire n_0_48;
   wire n_0_49;
   wire n_0_50;
   wire n_0_51;
   wire n_0_52;
   wire n_0_53;
   wire n_0_54;
   wire n_0_71;
   wire n_0_72;
   wire n_0_73;
   wire n_0_74;
   wire n_0_75;
   wire n_0_76;
   wire n_0_77;
   wire n_0_78;
   wire n_0_79;
   wire n_0_80;
   wire n_0_81;
   wire n_0_82;
   wire n_0_83;
   wire n_0_84;
   wire n_0_85;
   wire n_0_86;
   wire n_0_0_2;
   wire n_0_0_0;
   wire n_0_0_3;
   wire n_0_0_1;
   wire n_0_0_4;
   wire n_0_0_5;
   wire n_0_0;
   wire n_0_1;
   wire n_0_2;
   wire n_0_3;
   wire n_0_4;
   wire n_0_5;
   wire n_0_6;
   wire n_0_7;
   wire n_0_23;
   wire n_0_24;
   wire n_0_25;
   wire n_0_26;
   wire n_0_27;
   wire n_0_28;
   wire n_0_29;
   wire n_0_30;
   wire n_0_31;
   wire n_0_32;
   wire n_0_33;
   wire n_0_34;
   wire n_0_35;
   wire n_0_36;
   wire n_0_37;
   wire n_0_38;
   wire n_0_55;
   wire n_0_56;
   wire n_0_58;
   wire n_0_59;
   wire n_0_60;
   wire n_0_61;
   wire n_0_62;
   wire n_0_63;
   wire n_0_64;
   wire n_0_65;
   wire n_0_66;
   wire n_0_67;
   wire n_0_68;
   wire n_0_69;
   wire n_0_70;
   wire n_0_87;
   wire n_0_88;
   wire n_0_89;
   wire n_0_0_6;
   wire n_0_90;
   wire n_0_0_7;
   wire n_0_91;
   wire n_0_0_8;
   wire n_0_92;
   wire n_0_0_9;
   wire n_0_93;
   wire n_0_0_10;
   wire n_0_94;
   wire n_0_0_11;
   wire n_0_95;
   wire n_0_0_12;
   wire n_0_96;
   wire n_0_0_13;
   wire n_0_97;
   wire n_0_0_14;
   wire n_0_98;
   wire n_0_0_15;
   wire n_0_99;
   wire n_0_0_16;
   wire n_0_100;
   wire n_0_0_17;
   wire n_0_101;
   wire n_0_0_18;
   wire n_0_102;
   wire n_0_0_19;
   wire n_0_103;
   wire n_0_0_20;
   wire n_0_104;
   wire n_0_0_21;
   wire n_0_105;
   wire n_0_0_22;
   wire n_0_0_23;
   wire n_0_0_24;
   wire n_0_57;
   wire n_0_0_25;
   wire n_0_0_26;
   wire n_0_0_27;
   wire n_0_107;
   wire n_0_0_28;
   wire n_0_0_29;
   wire n_0_106;
   wire n_0_0_30;
   wire n_0_108;
   wire n_0_109;
   wire n_0_110;
   wire n_0_0_31;
   wire n_0_0_32;
   wire n_0_0_33;
   wire n_0_0_34;
   wire n_0_0_35;
   wire n_0_111;
   wire [31:0]mulResult;
   wire [17:0]i;
   wire [32:0]P;
   wire n_0_115;
   wire [32:0]S;
   wire [32:0]A;
   wire n_0_112;
   wire n_0_113;

   fixed_point_modification fp (.result({fixedMulResult[15], mulResult[30], 
      mulResult[29], mulResult[28], mulResult[27], mulResult[26], mulResult[25], 
      mulResult[24], mulResult[23], mulResult[22], mulResult[21], mulResult[20], 
      mulResult[19], mulResult[18], mulResult[17], mulResult[16], mulResult[15], 
      mulResult[14], mulResult[13], mulResult[12], mulResult[11], uc_0, uc_1, 
      uc_2, uc_3, uc_4, uc_5, uc_6, uc_7, uc_8, uc_9, uc_10}), .modifiedOut({
      uc_11, fixedMulResult[14], fixedMulResult[13], fixedMulResult[12], 
      fixedMulResult[11], fixedMulResult[10], fixedMulResult[9], 
      fixedMulResult[8], fixedMulResult[7], fixedMulResult[6], fixedMulResult[5], 
      fixedMulResult[4], fixedMulResult[3], fixedMulResult[2], fixedMulResult[1], 
      fixedMulResult[0]}));
   DFF_X1 finish_reg (.D(n_0_114), .CK(clk), .Q(finish), .QN());
   MUX2_X1 finish_reg_enable_mux_0 (.A(finish), .B(n_0_109), .S(n_0_110), 
      .Z(n_0_114));
   datapath__0_6 i_0_6 (.M(M), .p_0({n_0_22, n_0_21, n_0_20, n_0_19, n_0_18, 
      n_0_17, n_0_16, n_0_15, n_0_14, n_0_13, n_0_12, n_0_11, n_0_10, n_0_9, 
      n_0_8, uc_12}));
   datapath__0_7 i_0_7 (.S({S[32], S[31], S[30], S[29], S[28], S[27], S[26], 
      S[25], S[24], S[23], S[22], S[21], S[20], S[19], S[18], S[17], uc_13, 
      uc_14, uc_15, uc_16, uc_17, uc_18, uc_19, uc_20, uc_21, uc_22, uc_23, 
      uc_24, uc_25, uc_26, uc_27, uc_28, uc_29}), .P({P[32], P[31], P[30], P[29], 
      P[28], P[27], P[26], P[25], P[24], P[23], P[22], P[21], P[20], P[19], 
      P[18], P[17], uc_30, uc_31, uc_32, uc_33, uc_34, uc_35, uc_36, uc_37, 
      uc_38, uc_39, uc_40, uc_41, uc_42, uc_43, uc_44, uc_45, uc_46}), .p_0({
      n_0_54, n_0_53, n_0_52, n_0_51, n_0_50, n_0_49, n_0_48, n_0_47, n_0_46, 
      n_0_45, n_0_44, n_0_43, n_0_42, n_0_41, n_0_40, n_0_39, uc_47, uc_48, 
      uc_49, uc_50, uc_51, uc_52, uc_53, uc_54, uc_55, uc_56, uc_57, uc_58, 
      uc_59, uc_60, uc_61, uc_62, uc_63}));
   datapath__0_8 i_0_8 (.A({A[32], A[31], A[30], A[29], A[28], A[27], A[26], 
      A[25], A[24], A[23], A[22], A[21], A[20], A[19], A[18], S[17], uc_64, 
      uc_65, uc_66, uc_67, uc_68, uc_69, uc_70, uc_71, uc_72, uc_73, uc_74, 
      uc_75, uc_76, uc_77, uc_78, uc_79, uc_80}), .P({P[32], P[31], P[30], P[29], 
      P[28], P[27], P[26], P[25], P[24], P[23], P[22], P[21], P[20], P[19], 
      P[18], P[17], uc_81, uc_82, uc_83, uc_84, uc_85, uc_86, uc_87, uc_88, 
      uc_89, uc_90, uc_91, uc_92, uc_93, uc_94, uc_95, uc_96, uc_97}), .p_0({
      n_0_86, n_0_85, n_0_84, n_0_83, n_0_82, n_0_81, n_0_80, n_0_79, n_0_78, 
      n_0_77, n_0_76, n_0_75, n_0_74, n_0_73, n_0_72, n_0_71, uc_98, uc_99, 
      uc_100, uc_101, uc_102, uc_103, uc_104, uc_105, uc_106, uc_107, uc_108, 
      uc_109, uc_110, uc_111, uc_112, uc_113, uc_114}));
   HA_X1 i_0_0_0 (.A(i[1]), .B(i[0]), .CO(n_0_0_0), .S(n_0_0_2));
   HA_X1 i_0_0_1 (.A(i[2]), .B(n_0_0_0), .CO(n_0_0_1), .S(n_0_0_3));
   HA_X1 i_0_0_2 (.A(i[3]), .B(n_0_0_1), .CO(n_0_0_5), .S(n_0_0_4));
   NOR2_X1 i_0_0_3 (.A1(i[0]), .A2(reset), .ZN(n_0_0));
   AND2_X1 i_0_0_4 (.A1(n_0_0_34), .A2(n_0_0_2), .ZN(n_0_1));
   AND2_X1 i_0_0_5 (.A1(n_0_0_34), .A2(n_0_0_3), .ZN(n_0_2));
   AND2_X1 i_0_0_6 (.A1(n_0_0_34), .A2(n_0_0_4), .ZN(n_0_3));
   AND2_X1 i_0_0_7 (.A1(n_0_0_34), .A2(n_0_0_5), .ZN(n_0_4));
   AND2_X1 i_0_0_8 (.A1(P[12]), .A2(n_0_0_30), .ZN(n_0_5));
   AND2_X1 i_0_0_9 (.A1(P[13]), .A2(n_0_0_30), .ZN(n_0_6));
   AND2_X1 i_0_0_10 (.A1(P[14]), .A2(n_0_0_30), .ZN(n_0_7));
   AND2_X1 i_0_0_11 (.A1(P[15]), .A2(n_0_0_30), .ZN(n_0_23));
   AND2_X1 i_0_0_12 (.A1(P[16]), .A2(n_0_0_30), .ZN(n_0_24));
   NOR2_X1 i_0_0_13 (.A1(n_0_0_33), .A2(n_0_106), .ZN(n_0_25));
   AND2_X1 i_0_0_14 (.A1(P[18]), .A2(n_0_0_30), .ZN(n_0_26));
   AND2_X1 i_0_0_15 (.A1(P[19]), .A2(n_0_0_30), .ZN(n_0_27));
   AND2_X1 i_0_0_16 (.A1(P[20]), .A2(n_0_0_30), .ZN(n_0_28));
   AND2_X1 i_0_0_17 (.A1(P[21]), .A2(n_0_0_30), .ZN(n_0_29));
   AND2_X1 i_0_0_18 (.A1(P[22]), .A2(n_0_0_30), .ZN(n_0_30));
   AND2_X1 i_0_0_19 (.A1(P[23]), .A2(n_0_0_30), .ZN(n_0_31));
   AND2_X1 i_0_0_20 (.A1(P[24]), .A2(n_0_0_30), .ZN(n_0_32));
   AND2_X1 i_0_0_21 (.A1(P[25]), .A2(n_0_0_30), .ZN(n_0_33));
   AND2_X1 i_0_0_22 (.A1(P[26]), .A2(n_0_0_30), .ZN(n_0_34));
   AND2_X1 i_0_0_23 (.A1(P[27]), .A2(n_0_0_30), .ZN(n_0_35));
   AND2_X1 i_0_0_24 (.A1(P[28]), .A2(n_0_0_30), .ZN(n_0_36));
   AND2_X1 i_0_0_25 (.A1(P[29]), .A2(n_0_0_30), .ZN(n_0_37));
   AND2_X1 i_0_0_26 (.A1(P[30]), .A2(n_0_0_30), .ZN(n_0_38));
   AND2_X1 i_0_0_27 (.A1(P[31]), .A2(n_0_0_30), .ZN(n_0_55));
   AND2_X1 i_0_0_28 (.A1(P[32]), .A2(n_0_0_30), .ZN(n_0_56));
   MUX2_X1 i_0_0_29 (.A(P[2]), .B(R[0]), .S(reset), .Z(n_0_58));
   MUX2_X1 i_0_0_30 (.A(P[3]), .B(R[1]), .S(reset), .Z(n_0_59));
   MUX2_X1 i_0_0_31 (.A(P[4]), .B(R[2]), .S(reset), .Z(n_0_60));
   MUX2_X1 i_0_0_32 (.A(P[5]), .B(R[3]), .S(reset), .Z(n_0_61));
   MUX2_X1 i_0_0_33 (.A(P[6]), .B(R[4]), .S(reset), .Z(n_0_62));
   MUX2_X1 i_0_0_34 (.A(P[7]), .B(R[5]), .S(reset), .Z(n_0_63));
   MUX2_X1 i_0_0_35 (.A(P[8]), .B(R[6]), .S(reset), .Z(n_0_64));
   MUX2_X1 i_0_0_36 (.A(P[9]), .B(R[7]), .S(reset), .Z(n_0_65));
   MUX2_X1 i_0_0_37 (.A(P[10]), .B(R[8]), .S(reset), .Z(n_0_66));
   MUX2_X1 i_0_0_38 (.A(P[11]), .B(R[9]), .S(reset), .Z(n_0_67));
   MUX2_X1 i_0_0_39 (.A(P[12]), .B(R[10]), .S(reset), .Z(n_0_68));
   MUX2_X1 i_0_0_40 (.A(P[13]), .B(R[11]), .S(reset), .Z(n_0_69));
   MUX2_X1 i_0_0_41 (.A(P[14]), .B(R[12]), .S(reset), .Z(n_0_70));
   MUX2_X1 i_0_0_42 (.A(P[15]), .B(R[13]), .S(reset), .Z(n_0_87));
   MUX2_X1 i_0_0_43 (.A(P[16]), .B(R[14]), .S(reset), .Z(n_0_88));
   AOI21_X1 i_0_0_44 (.A(n_0_0_6), .B1(n_0_0_28), .B2(n_0_0_33), .ZN(n_0_89));
   OAI222_X1 i_0_0_45 (.A1(n_0_71), .A2(n_0_0_26), .B1(n_0_0_23), .B2(n_0_39), 
      .C1(n_0_0_34), .C2(R[15]), .ZN(n_0_0_6));
   INV_X1 i_0_0_46 (.A(n_0_0_7), .ZN(n_0_90));
   AOI222_X1 i_0_0_47 (.A1(P[18]), .A2(n_0_0_28), .B1(n_0_0_27), .B2(n_0_72), 
      .C1(n_0_0_24), .C2(n_0_40), .ZN(n_0_0_7));
   INV_X1 i_0_0_48 (.A(n_0_0_8), .ZN(n_0_91));
   AOI222_X1 i_0_0_49 (.A1(P[19]), .A2(n_0_0_28), .B1(n_0_0_27), .B2(n_0_73), 
      .C1(n_0_0_24), .C2(n_0_41), .ZN(n_0_0_8));
   INV_X1 i_0_0_50 (.A(n_0_0_9), .ZN(n_0_92));
   AOI222_X1 i_0_0_51 (.A1(P[20]), .A2(n_0_0_28), .B1(n_0_0_27), .B2(n_0_74), 
      .C1(n_0_0_24), .C2(n_0_42), .ZN(n_0_0_9));
   INV_X1 i_0_0_52 (.A(n_0_0_10), .ZN(n_0_93));
   AOI222_X1 i_0_0_53 (.A1(P[21]), .A2(n_0_0_28), .B1(n_0_0_27), .B2(n_0_75), 
      .C1(n_0_0_24), .C2(n_0_43), .ZN(n_0_0_10));
   INV_X1 i_0_0_54 (.A(n_0_0_11), .ZN(n_0_94));
   AOI222_X1 i_0_0_55 (.A1(P[22]), .A2(n_0_0_28), .B1(n_0_0_27), .B2(n_0_76), 
      .C1(n_0_0_24), .C2(n_0_44), .ZN(n_0_0_11));
   INV_X1 i_0_0_56 (.A(n_0_0_12), .ZN(n_0_95));
   AOI222_X1 i_0_0_57 (.A1(P[23]), .A2(n_0_0_28), .B1(n_0_0_27), .B2(n_0_77), 
      .C1(n_0_0_24), .C2(n_0_45), .ZN(n_0_0_12));
   INV_X1 i_0_0_58 (.A(n_0_0_13), .ZN(n_0_96));
   AOI222_X1 i_0_0_59 (.A1(P[24]), .A2(n_0_0_28), .B1(n_0_0_27), .B2(n_0_78), 
      .C1(n_0_0_24), .C2(n_0_46), .ZN(n_0_0_13));
   INV_X1 i_0_0_60 (.A(n_0_0_14), .ZN(n_0_97));
   AOI222_X1 i_0_0_61 (.A1(P[25]), .A2(n_0_0_28), .B1(n_0_0_27), .B2(n_0_79), 
      .C1(n_0_0_24), .C2(n_0_47), .ZN(n_0_0_14));
   INV_X1 i_0_0_62 (.A(n_0_0_15), .ZN(n_0_98));
   AOI222_X1 i_0_0_63 (.A1(P[26]), .A2(n_0_0_28), .B1(n_0_0_27), .B2(n_0_80), 
      .C1(n_0_0_24), .C2(n_0_48), .ZN(n_0_0_15));
   INV_X1 i_0_0_64 (.A(n_0_0_16), .ZN(n_0_99));
   AOI222_X1 i_0_0_65 (.A1(P[27]), .A2(n_0_0_28), .B1(n_0_0_27), .B2(n_0_81), 
      .C1(n_0_0_24), .C2(n_0_49), .ZN(n_0_0_16));
   INV_X1 i_0_0_66 (.A(n_0_0_17), .ZN(n_0_100));
   AOI222_X1 i_0_0_67 (.A1(P[28]), .A2(n_0_0_28), .B1(n_0_0_27), .B2(n_0_82), 
      .C1(n_0_0_24), .C2(n_0_50), .ZN(n_0_0_17));
   INV_X1 i_0_0_68 (.A(n_0_0_18), .ZN(n_0_101));
   AOI222_X1 i_0_0_69 (.A1(P[29]), .A2(n_0_0_28), .B1(n_0_0_27), .B2(n_0_83), 
      .C1(n_0_0_24), .C2(n_0_51), .ZN(n_0_0_18));
   INV_X1 i_0_0_70 (.A(n_0_0_19), .ZN(n_0_102));
   AOI222_X1 i_0_0_71 (.A1(P[30]), .A2(n_0_0_28), .B1(n_0_0_27), .B2(n_0_84), 
      .C1(n_0_0_24), .C2(n_0_52), .ZN(n_0_0_19));
   INV_X1 i_0_0_72 (.A(n_0_0_20), .ZN(n_0_103));
   AOI222_X1 i_0_0_73 (.A1(P[31]), .A2(n_0_0_28), .B1(n_0_0_27), .B2(n_0_85), 
      .C1(n_0_0_24), .C2(n_0_53), .ZN(n_0_0_20));
   NAND2_X1 i_0_0_74 (.A1(n_0_0_22), .A2(n_0_0_21), .ZN(n_0_104));
   NAND2_X1 i_0_0_75 (.A1(P[32]), .A2(n_0_0_28), .ZN(n_0_0_21));
   INV_X1 i_0_0_76 (.A(n_0_0_22), .ZN(n_0_105));
   AOI22_X1 i_0_0_77 (.A1(n_0_86), .A2(n_0_0_27), .B1(n_0_0_24), .B2(n_0_54), 
      .ZN(n_0_0_22));
   INV_X1 i_0_0_78 (.A(n_0_0_24), .ZN(n_0_0_23));
   NOR2_X1 i_0_0_79 (.A1(n_0_0_25), .A2(P[0]), .ZN(n_0_0_24));
   INV_X1 i_0_0_80 (.A(n_0_0_25), .ZN(n_0_57));
   NAND2_X1 i_0_0_81 (.A1(n_0_0_34), .A2(P[1]), .ZN(n_0_0_25));
   INV_X1 i_0_0_82 (.A(n_0_0_27), .ZN(n_0_0_26));
   NOR3_X1 i_0_0_83 (.A1(n_0_0_32), .A2(P[1]), .A3(reset), .ZN(n_0_0_27));
   NOR2_X1 i_0_0_84 (.A1(n_0_0_30), .A2(n_0_0_28), .ZN(n_0_107));
   NOR2_X1 i_0_0_85 (.A1(n_0_0_29), .A2(reset), .ZN(n_0_0_28));
   XNOR2_X1 i_0_0_86 (.A(P[1]), .B(n_0_0_32), .ZN(n_0_0_29));
   INV_X1 i_0_0_87 (.A(n_0_0_30), .ZN(n_0_106));
   AOI21_X1 i_0_0_88 (.A(reset), .B1(n_0_0_35), .B2(enable), .ZN(n_0_0_30));
   OR2_X1 i_0_0_89 (.A1(reset), .A2(enable), .ZN(n_0_108));
   NOR2_X1 i_0_0_90 (.A1(n_0_0_35), .A2(reset), .ZN(n_0_109));
   INV_X1 i_0_0_91 (.A(n_0_0_31), .ZN(n_0_110));
   AOI21_X1 i_0_0_92 (.A(reset), .B1(enable), .B2(i[4]), .ZN(n_0_0_31));
   INV_X1 i_0_0_93 (.A(P[0]), .ZN(n_0_0_32));
   INV_X1 i_0_0_94 (.A(P[17]), .ZN(n_0_0_33));
   INV_X1 i_0_0_95 (.A(reset), .ZN(n_0_0_34));
   INV_X1 i_0_0_96 (.A(i[4]), .ZN(n_0_0_35));
   CLKGATETST_X1 clk_gate_mulResult_reg (.CK(clk), .E(n_0_108), .SE(1'b0), 
      .GCK(n_0_111));
   DFF_X1 \mulResult_reg[31]  (.D(n_0_56), .CK(n_0_111), .Q(fixedMulResult[15]), 
      .QN());
   DFF_X1 \mulResult_reg[30]  (.D(n_0_55), .CK(n_0_111), .Q(mulResult[30]), 
      .QN());
   DFF_X1 \mulResult_reg[29]  (.D(n_0_38), .CK(n_0_111), .Q(mulResult[29]), 
      .QN());
   DFF_X1 \mulResult_reg[28]  (.D(n_0_37), .CK(n_0_111), .Q(mulResult[28]), 
      .QN());
   DFF_X1 \mulResult_reg[27]  (.D(n_0_36), .CK(n_0_111), .Q(mulResult[27]), 
      .QN());
   DFF_X1 \mulResult_reg[26]  (.D(n_0_35), .CK(n_0_111), .Q(mulResult[26]), 
      .QN());
   DFF_X1 \mulResult_reg[25]  (.D(n_0_34), .CK(n_0_111), .Q(mulResult[25]), 
      .QN());
   DFF_X1 \mulResult_reg[24]  (.D(n_0_33), .CK(n_0_111), .Q(mulResult[24]), 
      .QN());
   DFF_X1 \mulResult_reg[23]  (.D(n_0_32), .CK(n_0_111), .Q(mulResult[23]), 
      .QN());
   DFF_X1 \mulResult_reg[22]  (.D(n_0_31), .CK(n_0_111), .Q(mulResult[22]), 
      .QN());
   DFF_X1 \mulResult_reg[21]  (.D(n_0_30), .CK(n_0_111), .Q(mulResult[21]), 
      .QN());
   DFF_X1 \mulResult_reg[20]  (.D(n_0_29), .CK(n_0_111), .Q(mulResult[20]), 
      .QN());
   DFF_X1 \mulResult_reg[19]  (.D(n_0_28), .CK(n_0_111), .Q(mulResult[19]), 
      .QN());
   DFF_X1 \mulResult_reg[18]  (.D(n_0_27), .CK(n_0_111), .Q(mulResult[18]), 
      .QN());
   DFF_X1 \mulResult_reg[17]  (.D(n_0_26), .CK(n_0_111), .Q(mulResult[17]), 
      .QN());
   DFF_X1 \mulResult_reg[16]  (.D(n_0_25), .CK(n_0_111), .Q(mulResult[16]), 
      .QN());
   DFF_X1 \mulResult_reg[15]  (.D(n_0_24), .CK(n_0_111), .Q(mulResult[15]), 
      .QN());
   DFF_X1 \mulResult_reg[14]  (.D(n_0_23), .CK(n_0_111), .Q(mulResult[14]), 
      .QN());
   DFF_X1 \mulResult_reg[13]  (.D(n_0_7), .CK(n_0_111), .Q(mulResult[13]), .QN());
   DFF_X1 \mulResult_reg[12]  (.D(n_0_6), .CK(n_0_111), .Q(mulResult[12]), .QN());
   DFF_X1 \mulResult_reg[11]  (.D(n_0_5), .CK(n_0_111), .Q(mulResult[11]), .QN());
   DFF_X1 \i_reg[4]  (.D(n_0_4), .CK(n_0_112), .Q(i[4]), .QN());
   DFF_X1 \i_reg[3]  (.D(n_0_3), .CK(n_0_112), .Q(i[3]), .QN());
   DFF_X1 \i_reg[2]  (.D(n_0_2), .CK(n_0_112), .Q(i[2]), .QN());
   DFF_X1 \i_reg[1]  (.D(n_0_1), .CK(n_0_112), .Q(i[1]), .QN());
   DFF_X1 \i_reg[0]  (.D(n_0_0), .CK(n_0_112), .Q(i[0]), .QN());
   DFF_X1 \P_reg[31]  (.D(n_0_104), .CK(n_0_112), .Q(P[31]), .QN());
   DFF_X1 \P_reg[30]  (.D(n_0_103), .CK(n_0_112), .Q(P[30]), .QN());
   DFF_X1 \P_reg[29]  (.D(n_0_102), .CK(n_0_112), .Q(P[29]), .QN());
   DFF_X1 \P_reg[28]  (.D(n_0_101), .CK(n_0_112), .Q(P[28]), .QN());
   DFF_X1 \P_reg[27]  (.D(n_0_100), .CK(n_0_112), .Q(P[27]), .QN());
   DFF_X1 \P_reg[26]  (.D(n_0_99), .CK(n_0_112), .Q(P[26]), .QN());
   DFF_X1 \P_reg[25]  (.D(n_0_98), .CK(n_0_112), .Q(P[25]), .QN());
   DFF_X1 \P_reg[24]  (.D(n_0_97), .CK(n_0_112), .Q(P[24]), .QN());
   DFF_X1 \P_reg[23]  (.D(n_0_96), .CK(n_0_112), .Q(P[23]), .QN());
   DFF_X1 \P_reg[22]  (.D(n_0_95), .CK(n_0_112), .Q(P[22]), .QN());
   DFF_X1 \P_reg[21]  (.D(n_0_94), .CK(n_0_112), .Q(P[21]), .QN());
   DFF_X1 \P_reg[20]  (.D(n_0_93), .CK(n_0_112), .Q(P[20]), .QN());
   DFF_X1 \P_reg[19]  (.D(n_0_92), .CK(n_0_112), .Q(P[19]), .QN());
   DFF_X1 \P_reg[18]  (.D(n_0_91), .CK(n_0_112), .Q(P[18]), .QN());
   DFF_X1 \P_reg[17]  (.D(n_0_90), .CK(n_0_112), .Q(P[17]), .QN());
   DFF_X1 \P_reg[16]  (.D(n_0_89), .CK(n_0_112), .Q(P[16]), .QN());
   DFF_X1 \P_reg[15]  (.D(n_0_88), .CK(n_0_112), .Q(P[15]), .QN());
   DFF_X1 \P_reg[14]  (.D(n_0_87), .CK(n_0_112), .Q(P[14]), .QN());
   DFF_X1 \P_reg[13]  (.D(n_0_70), .CK(n_0_112), .Q(P[13]), .QN());
   DFF_X1 \P_reg[12]  (.D(n_0_69), .CK(n_0_112), .Q(P[12]), .QN());
   DFF_X1 \P_reg[11]  (.D(n_0_68), .CK(n_0_112), .Q(P[11]), .QN());
   DFF_X1 \P_reg[10]  (.D(n_0_67), .CK(n_0_112), .Q(P[10]), .QN());
   DFF_X1 \P_reg[9]  (.D(n_0_66), .CK(n_0_112), .Q(P[9]), .QN());
   DFF_X1 \P_reg[8]  (.D(n_0_65), .CK(n_0_112), .Q(P[8]), .QN());
   DFF_X1 \P_reg[7]  (.D(n_0_64), .CK(n_0_112), .Q(P[7]), .QN());
   DFF_X1 \P_reg[6]  (.D(n_0_63), .CK(n_0_112), .Q(P[6]), .QN());
   DFF_X1 \P_reg[5]  (.D(n_0_62), .CK(n_0_112), .Q(P[5]), .QN());
   DFF_X1 \P_reg[4]  (.D(n_0_61), .CK(n_0_112), .Q(P[4]), .QN());
   DFF_X1 \P_reg[3]  (.D(n_0_60), .CK(n_0_112), .Q(P[3]), .QN());
   DFF_X1 \P_reg[2]  (.D(n_0_59), .CK(n_0_112), .Q(P[2]), .QN());
   DFF_X1 \P_reg[1]  (.D(n_0_58), .CK(n_0_112), .Q(P[1]), .QN());
   DFF_X1 \P_reg[0]  (.D(n_0_57), .CK(n_0_112), .Q(P[0]), .QN());
   DFF_X1 \P_reg[32]  (.D(n_0_115), .CK(clk), .Q(P[32]), .QN());
   MUX2_X1 \P_reg[32]_enable_mux_0  (.A(P[32]), .B(n_0_105), .S(n_0_107), 
      .Z(n_0_115));
   DFF_X1 \S_reg[32]  (.D(n_0_22), .CK(n_0_113), .Q(S[32]), .QN());
   DFF_X1 \S_reg[31]  (.D(n_0_21), .CK(n_0_113), .Q(S[31]), .QN());
   DFF_X1 \S_reg[30]  (.D(n_0_20), .CK(n_0_113), .Q(S[30]), .QN());
   DFF_X1 \S_reg[29]  (.D(n_0_19), .CK(n_0_113), .Q(S[29]), .QN());
   DFF_X1 \S_reg[28]  (.D(n_0_18), .CK(n_0_113), .Q(S[28]), .QN());
   DFF_X1 \S_reg[27]  (.D(n_0_17), .CK(n_0_113), .Q(S[27]), .QN());
   DFF_X1 \S_reg[26]  (.D(n_0_16), .CK(n_0_113), .Q(S[26]), .QN());
   DFF_X1 \S_reg[25]  (.D(n_0_15), .CK(n_0_113), .Q(S[25]), .QN());
   DFF_X1 \S_reg[24]  (.D(n_0_14), .CK(n_0_113), .Q(S[24]), .QN());
   DFF_X1 \S_reg[23]  (.D(n_0_13), .CK(n_0_113), .Q(S[23]), .QN());
   DFF_X1 \S_reg[22]  (.D(n_0_12), .CK(n_0_113), .Q(S[22]), .QN());
   DFF_X1 \S_reg[21]  (.D(n_0_11), .CK(n_0_113), .Q(S[21]), .QN());
   DFF_X1 \S_reg[20]  (.D(n_0_10), .CK(n_0_113), .Q(S[20]), .QN());
   DFF_X1 \S_reg[19]  (.D(n_0_9), .CK(n_0_113), .Q(S[19]), .QN());
   DFF_X1 \S_reg[18]  (.D(n_0_8), .CK(n_0_113), .Q(S[18]), .QN());
   DFF_X1 \A_reg[32]  (.D(M[15]), .CK(n_0_113), .Q(A[32]), .QN());
   DFF_X1 \A_reg[31]  (.D(M[14]), .CK(n_0_113), .Q(A[31]), .QN());
   DFF_X1 \A_reg[30]  (.D(M[13]), .CK(n_0_113), .Q(A[30]), .QN());
   DFF_X1 \A_reg[29]  (.D(M[12]), .CK(n_0_113), .Q(A[29]), .QN());
   DFF_X1 \A_reg[28]  (.D(M[11]), .CK(n_0_113), .Q(A[28]), .QN());
   DFF_X1 \A_reg[27]  (.D(M[10]), .CK(n_0_113), .Q(A[27]), .QN());
   DFF_X1 \A_reg[26]  (.D(M[9]), .CK(n_0_113), .Q(A[26]), .QN());
   DFF_X1 \A_reg[25]  (.D(M[8]), .CK(n_0_113), .Q(A[25]), .QN());
   DFF_X1 \A_reg[24]  (.D(M[7]), .CK(n_0_113), .Q(A[24]), .QN());
   DFF_X1 \A_reg[23]  (.D(M[6]), .CK(n_0_113), .Q(A[23]), .QN());
   DFF_X1 \A_reg[22]  (.D(M[5]), .CK(n_0_113), .Q(A[22]), .QN());
   DFF_X1 \A_reg[21]  (.D(M[4]), .CK(n_0_113), .Q(A[21]), .QN());
   DFF_X1 \A_reg[20]  (.D(M[3]), .CK(n_0_113), .Q(A[20]), .QN());
   DFF_X1 \A_reg[19]  (.D(M[2]), .CK(n_0_113), .Q(A[19]), .QN());
   DFF_X1 \A_reg[18]  (.D(M[1]), .CK(n_0_113), .Q(A[18]), .QN());
   CLKGATETST_X1 clk_gate_i_reg (.CK(clk), .E(n_0_106), .SE(1'b0), .GCK(n_0_112));
   CLKGATETST_X1 clk_gate_S_reg (.CK(clk), .E(reset), .SE(1'b0), .GCK(n_0_113));
   DFF_X1 \S_reg[17]  (.D(M[0]), .CK(n_0_113), .Q(S[17]), .QN());
endmodule
