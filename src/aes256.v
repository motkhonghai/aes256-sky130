/*
 * AES-256 Synthesizable Core IP
 * Complies with NIST FIPS 197
 *
 * Supports both Encryption and Decryption in a unified sub-pipelined iterative architecture.
 * The standard round is divided into two clock cycles (Phase A & Phase B) to optimize Fmax.
 */

module aes_sbox (
    input  [7:0] in,
    output reg [7:0] out
);
    always @(*) begin
        case (in)
            8'h00: out = 8'h63;
            8'h01: out = 8'h7c;
            8'h02: out = 8'h77;
            8'h03: out = 8'h7b;
            8'h04: out = 8'hf2;
            8'h05: out = 8'h6b;
            8'h06: out = 8'h6f;
            8'h07: out = 8'hc5;
            8'h08: out = 8'h30;
            8'h09: out = 8'h01;
            8'h0a: out = 8'h67;
            8'h0b: out = 8'h2b;
            8'h0c: out = 8'hfe;
            8'h0d: out = 8'hd7;
            8'h0e: out = 8'hab;
            8'h0f: out = 8'h76;
            8'h10: out = 8'hca;
            8'h11: out = 8'h82;
            8'h12: out = 8'hc9;
            8'h13: out = 8'h7d;
            8'h14: out = 8'hfa;
            8'h15: out = 8'h59;
            8'h16: out = 8'h47;
            8'h17: out = 8'hf0;
            8'h18: out = 8'had;
            8'h19: out = 8'hd4;
            8'h1a: out = 8'ha2;
            8'h1b: out = 8'haf;
            8'h1c: out = 8'h9c;
            8'h1d: out = 8'ha4;
            8'h1e: out = 8'h72;
            8'h1f: out = 8'hc0;
            8'h20: out = 8'hb7;
            8'h21: out = 8'hfd;
            8'h22: out = 8'h93;
            8'h23: out = 8'h26;
            8'h24: out = 8'h36;
            8'h25: out = 8'h3f;
            8'h26: out = 8'hf7;
            8'h27: out = 8'hcc;
            8'h28: out = 8'h34;
            8'h29: out = 8'ha5;
            8'h2a: out = 8'he5;
            8'h2b: out = 8'hf1;
            8'h2c: out = 8'h71;
            8'h2d: out = 8'hd8;
            8'h2e: out = 8'h31;
            8'h2f: out = 8'h15;
            8'h30: out = 8'h04;
            8'h31: out = 8'hc7;
            8'h32: out = 8'h23;
            8'h33: out = 8'hc3;
            8'h34: out = 8'h18;
            8'h35: out = 8'h96;
            8'h36: out = 8'h05;
            8'h37: out = 8'h9a;
            8'h38: out = 8'h07;
            8'h39: out = 8'h12;
            8'h3a: out = 8'h80;
            8'h3b: out = 8'he2;
            8'h3c: out = 8'heb;
            8'h3d: out = 8'h27;
            8'h3e: out = 8'hb2;
            8'h3f: out = 8'h75;
            8'h40: out = 8'h09;
            8'h41: out = 8'h83;
            8'h42: out = 8'h2c;
            8'h43: out = 8'h1a;
            8'h44: out = 8'h1b;
            8'h45: out = 8'h6e;
            8'h46: out = 8'h5a;
            8'h47: out = 8'ha0;
            8'h48: out = 8'h52;
            8'h49: out = 8'h3b;
            8'h4a: out = 8'hd6;
            8'h4b: out = 8'hb3;
            8'h4c: out = 8'h29;
            8'h4d: out = 8'he3;
            8'h4e: out = 8'h2f;
            8'h4f: out = 8'h84;
            8'h50: out = 8'h53;
            8'h51: out = 8'hd1;
            8'h52: out = 8'h00;
            8'h53: out = 8'hed;
            8'h54: out = 8'h20;
            8'h55: out = 8'hfc;
            8'h56: out = 8'hb1;
            8'h57: out = 8'h5b;
            8'h58: out = 8'h6a;
            8'h59: out = 8'hcb;
            8'h5a: out = 8'hbe;
            8'h5b: out = 8'h39;
            8'h5c: out = 8'h4a;
            8'h5d: out = 8'h4c;
            8'h5e: out = 8'h58;
            8'h5f: out = 8'hcf;
            8'h60: out = 8'hd0;
            8'h61: out = 8'hef;
            8'h62: out = 8'haa;
            8'h63: out = 8'hfb;
            8'h64: out = 8'h43;
            8'h65: out = 8'h4d;
            8'h66: out = 8'h33;
            8'h67: out = 8'h85;
            8'h68: out = 8'h45;
            8'h69: out = 8'hf9;
            8'h6a: out = 8'h02;
            8'h6b: out = 8'h7f;
            8'h6c: out = 8'h50;
            8'h6d: out = 8'h3c;
            8'h6e: out = 8'h9f;
            8'h6f: out = 8'ha8;
            8'h70: out = 8'h51;
            8'h71: out = 8'ha3;
            8'h72: out = 8'h40;
            8'h73: out = 8'h8f;
            8'h74: out = 8'h92;
            8'h75: out = 8'h9d;
            8'h76: out = 8'h38;
            8'h77: out = 8'hf5;
            8'h78: out = 8'hbc;
            8'h79: out = 8'hb6;
            8'h7a: out = 8'hda;
            8'h7b: out = 8'h21;
            8'h7c: out = 8'h10;
            8'h7d: out = 8'hff;
            8'h7e: out = 8'hf3;
            8'h7f: out = 8'hd2;
            8'h80: out = 8'hcd;
            8'h81: out = 8'h0c;
            8'h82: out = 8'h13;
            8'h83: out = 8'hec;
            8'h84: out = 8'h5f;
            8'h85: out = 8'h97;
            8'h86: out = 8'h44;
            8'h87: out = 8'h17;
            8'h88: out = 8'hc4;
            8'h89: out = 8'ha7;
            8'h8a: out = 8'h7e;
            8'h8b: out = 8'h3d;
            8'h8c: out = 8'h64;
            8'h8d: out = 8'h5d;
            8'h8e: out = 8'h19;
            8'h8f: out = 8'h73;
            8'h90: out = 8'h60;
            8'h91: out = 8'h81;
            8'h92: out = 8'h4f;
            8'h93: out = 8'hdc;
            8'h94: out = 8'h22;
            8'h95: out = 8'h2a;
            8'h96: out = 8'h90;
            8'h97: out = 8'h88;
            8'h98: out = 8'h46;
            8'h99: out = 8'hee;
            8'h9a: out = 8'hb8;
            8'h9b: out = 8'h14;
            8'h9c: out = 8'hde;
            8'h9d: out = 8'h5e;
            8'h9e: out = 8'h0b;
            8'h9f: out = 8'hdb;
            8'ha0: out = 8'he0;
            8'ha1: out = 8'h32;
            8'ha2: out = 8'h3a;
            8'ha3: out = 8'h0a;
            8'ha4: out = 8'h49;
            8'ha5: out = 8'h06;
            8'ha6: out = 8'h24;
            8'ha7: out = 8'h5c;
            8'ha8: out = 8'hc2;
            8'ha9: out = 8'hd3;
            8'haa: out = 8'hac;
            8'hab: out = 8'h62;
            8'hac: out = 8'h91;
            8'had: out = 8'h95;
            8'hae: out = 8'he4;
            8'haf: out = 8'h79;
            8'hb0: out = 8'he7;
            8'hb1: out = 8'hc8;
            8'hb2: out = 8'h37;
            8'hb3: out = 8'h6d;
            8'hb4: out = 8'h8d;
            8'hb5: out = 8'hd5;
            8'hb6: out = 8'h4e;
            8'hb7: out = 8'ha9;
            8'hb8: out = 8'h6c;
            8'hb9: out = 8'h56;
            8'hba: out = 8'hf4;
            8'hbb: out = 8'hea;
            8'hbc: out = 8'h65;
            8'hbd: out = 8'h7a;
            8'hbe: out = 8'hae;
            8'hbf: out = 8'h08;
            8'hc0: out = 8'hba;
            8'hc1: out = 8'h78;
            8'hc2: out = 8'h25;
            8'hc3: out = 8'h2e;
            8'hc4: out = 8'h1c;
            8'hc5: out = 8'ha6;
            8'hc6: out = 8'hb4;
            8'hc7: out = 8'hc6;
            8'hc8: out = 8'he8;
            8'hc9: out = 8'hdd;
            8'hca: out = 8'h74;
            8'hcb: out = 8'h1f;
            8'hcc: out = 8'h4b;
            8'hcd: out = 8'hbd;
            8'hce: out = 8'h8b;
            8'hcf: out = 8'h8a;
            8'hd0: out = 8'h70;
            8'hd1: out = 8'h3e;
            8'hd2: out = 8'hb5;
            8'hd3: out = 8'h66;
            8'hd4: out = 8'h48;
            8'hd5: out = 8'h03;
            8'hd6: out = 8'hf6;
            8'hd7: out = 8'h0e;
            8'hd8: out = 8'h61;
            8'hd9: out = 8'h35;
            8'hda: out = 8'h57;
            8'hdb: out = 8'hb9;
            8'hdc: out = 8'h86;
            8'hdd: out = 8'hc1;
            8'hde: out = 8'h1d;
            8'hdf: out = 8'h9e;
            8'he0: out = 8'he1;
            8'he1: out = 8'hf8;
            8'he2: out = 8'h98;
            8'he3: out = 8'h11;
            8'he4: out = 8'h69;
            8'he5: out = 8'hd9;
            8'he6: out = 8'h8e;
            8'he7: out = 8'h94;
            8'he8: out = 8'h9b;
            8'he9: out = 8'h1e;
            8'hea: out = 8'h87;
            8'heb: out = 8'he9;
            8'hec: out = 8'hce;
            8'hed: out = 8'h55;
            8'hee: out = 8'h28;
            8'hef: out = 8'hdf;
            8'hf0: out = 8'h8c;
            8'hf1: out = 8'ha1;
            8'hf2: out = 8'h89;
            8'hf3: out = 8'h0d;
            8'hf4: out = 8'hbf;
            8'hf5: out = 8'he6;
            8'hf6: out = 8'h42;
            8'hf7: out = 8'h68;
            8'hf8: out = 8'h41;
            8'hf9: out = 8'h99;
            8'hfa: out = 8'h2d;
            8'hfb: out = 8'h0f;
            8'hfc: out = 8'hb0;
            8'hfd: out = 8'h54;
            8'hfe: out = 8'hbb;
            8'hff: out = 8'h16;
            default: out = 8'h00;
        endcase
    end
endmodule

module aes_inv_sbox (
    input  [7:0] in,
    output reg [7:0] out
);
    always @(*) begin
        case (in)
            8'h00: out = 8'h52;
            8'h01: out = 8'h09;
            8'h02: out = 8'h6a;
            8'h03: out = 8'hd5;
            8'h04: out = 8'h30;
            8'h05: out = 8'h36;
            8'h06: out = 8'ha5;
            8'h07: out = 8'h38;
            8'h08: out = 8'hbf;
            8'h09: out = 8'h40;
            8'h0a: out = 8'ha3;
            8'h0b: out = 8'h9e;
            8'h0c: out = 8'h81;
            8'h0d: out = 8'hf3;
            8'h0e: out = 8'hd7;
            8'h0f: out = 8'hfb;
            8'h10: out = 8'h7c;
            8'h11: out = 8'he3;
            8'h12: out = 8'h39;
            8'h13: out = 8'h82;
            8'h14: out = 8'h9b;
            8'h15: out = 8'h2f;
            8'h16: out = 8'hff;
            8'h17: out = 8'h87;
            8'h18: out = 8'h34;
            8'h19: out = 8'h8e;
            8'h1a: out = 8'h43;
            8'h1b: out = 8'h44;
            8'h1c: out = 8'hc4;
            8'h1d: out = 8'hde;
            8'h1e: out = 8'he9;
            8'h1f: out = 8'hcb;
            8'h20: out = 8'h54;
            8'h21: out = 8'h7b;
            8'h22: out = 8'h94;
            8'h23: out = 8'h32;
            8'h24: out = 8'ha6;
            8'h25: out = 8'hc2;
            8'h26: out = 8'h23;
            8'h27: out = 8'h3d;
            8'h28: out = 8'hee;
            8'h29: out = 8'h4c;
            8'h2a: out = 8'h95;
            8'h2b: out = 8'h0b;
            8'h2c: out = 8'h42;
            8'h2d: out = 8'hfa;
            8'h2e: out = 8'hc3;
            8'h2f: out = 8'h4e;
            8'h30: out = 8'h08;
            8'h31: out = 8'h2e;
            8'h32: out = 8'ha1;
            8'h33: out = 8'h66;
            8'h34: out = 8'h28;
            8'h35: out = 8'hd9;
            8'h36: out = 8'h24;
            8'h37: out = 8'hb2;
            8'h38: out = 8'h76;
            8'h39: out = 8'h5b;
            8'h3a: out = 8'ha2;
            8'h3b: out = 8'h49;
            8'h3c: out = 8'h6d;
            8'h3d: out = 8'h8b;
            8'h3e: out = 8'hd1;
            8'h3f: out = 8'h25;
            8'h40: out = 8'h72;
            8'h41: out = 8'hf8;
            8'h42: out = 8'hf6;
            8'h43: out = 8'h64;
            8'h44: out = 8'h86;
            8'h45: out = 8'h68;
            8'h46: out = 8'h98;
            8'h47: out = 8'h16;
            8'h48: out = 8'hd4;
            8'h49: out = 8'ha4;
            8'h4a: out = 8'h5c;
            8'h4b: out = 8'hcc;
            8'h4c: out = 8'h5d;
            8'h4d: out = 8'h65;
            8'h4e: out = 8'hb6;
            8'h4f: out = 8'h92;
            8'h50: out = 8'h6c;
            8'h51: out = 8'h70;
            8'h52: out = 8'h48;
            8'h53: out = 8'h50;
            8'h54: out = 8'hfd;
            8'h55: out = 8'hed;
            8'h56: out = 8'hb9;
            8'h57: out = 8'hda;
            8'h58: out = 8'h5e;
            8'h59: out = 8'h15;
            8'h5a: out = 8'h46;
            8'h5b: out = 8'h57;
            8'h5c: out = 8'ha7;
            8'h5d: out = 8'h8d;
            8'h5e: out = 8'h9d;
            8'h5f: out = 8'h84;
            8'h60: out = 8'h90;
            8'h61: out = 8'hd8;
            8'h62: out = 8'hab;
            8'h63: out = 8'h00;
            8'h64: out = 8'h8c;
            8'h65: out = 8'hbc;
            8'h66: out = 8'hd3;
            8'h67: out = 8'h0a;
            8'h68: out = 8'hf7;
            8'h69: out = 8'he4;
            8'h6a: out = 8'h58;
            8'h6b: out = 8'h05;
            8'h6c: out = 8'hb8;
            8'h6d: out = 8'hb3;
            8'h6e: out = 8'h45;
            8'h6f: out = 8'h06;
            8'h70: out = 8'hd0;
            8'h71: out = 8'h2c;
            8'h72: out = 8'h1e;
            8'h73: out = 8'h8f;
            8'h74: out = 8'hca;
            8'h75: out = 8'h3f;
            8'h76: out = 8'h0f;
            8'h77: out = 8'h02;
            8'h78: out = 8'hc1;
            8'h79: out = 8'haf;
            8'h7a: out = 8'hbd;
            8'h7b: out = 8'h03;
            8'h7c: out = 8'h01;
            8'h7d: out = 8'h13;
            8'h7e: out = 8'h8a;
            8'h7f: out = 8'h6b;
            8'h80: out = 8'h3a;
            8'h81: out = 8'h91;
            8'h82: out = 8'h11;
            8'h83: out = 8'h41;
            8'h84: out = 8'h4f;
            8'h85: out = 8'h67;
            8'h86: out = 8'hdc;
            8'h87: out = 8'hea;
            8'h88: out = 8'h97;
            8'h89: out = 8'hf2;
            8'h8a: out = 8'hcf;
            8'h8b: out = 8'hce;
            8'h8c: out = 8'hf0;
            8'h8d: out = 8'hb4;
            8'h8e: out = 8'he6;
            8'h8f: out = 8'h73;
            8'h90: out = 8'h96;
            8'h91: out = 8'hac;
            8'h92: out = 8'h74;
            8'h93: out = 8'h22;
            8'h94: out = 8'he7;
            8'h95: out = 8'had;
            8'h96: out = 8'h35;
            8'h97: out = 8'h85;
            8'h98: out = 8'he2;
            8'h99: out = 8'hf9;
            8'h9a: out = 8'h37;
            8'h9b: out = 8'he8;
            8'h9c: out = 8'h1c;
            8'h9d: out = 8'h75;
            8'h9e: out = 8'hdf;
            8'h9f: out = 8'h6e;
            8'ha0: out = 8'h47;
            8'ha1: out = 8'hf1;
            8'ha2: out = 8'h1a;
            8'ha3: out = 8'h71;
            8'ha4: out = 8'h1d;
            8'ha5: out = 8'h29;
            8'ha6: out = 8'hc5;
            8'ha7: out = 8'h89;
            8'ha8: out = 8'h6f;
            8'ha9: out = 8'hb7;
            8'haa: out = 8'h62;
            8'hab: out = 8'h0e;
            8'hac: out = 8'haa;
            8'had: out = 8'h18;
            8'hae: out = 8'hbe;
            8'haf: out = 8'h1b;
            8'hb0: out = 8'hfc;
            8'hb1: out = 8'h56;
            8'hb2: out = 8'h3e;
            8'hb3: out = 8'h4b;
            8'hb4: out = 8'hc6;
            8'hb5: out = 8'hd2;
            8'hb6: out = 8'h79;
            8'hb7: out = 8'h20;
            8'hb8: out = 8'h9a;
            8'hb9: out = 8'hdb;
            8'hba: out = 8'hc0;
            8'hbb: out = 8'hfe;
            8'hbc: out = 8'h78;
            8'hbd: out = 8'hcd;
            8'hbe: out = 8'h5a;
            8'hbf: out = 8'hf4;
            8'hc0: out = 8'h1f;
            8'hc1: out = 8'hdd;
            8'hc2: out = 8'ha8;
            8'hc3: out = 8'h33;
            8'hc4: out = 8'h88;
            8'hc5: out = 8'h07;
            8'hc6: out = 8'hc7;
            8'hc7: out = 8'h31;
            8'hc8: out = 8'hb1;
            8'hc9: out = 8'h12;
            8'hca: out = 8'h10;
            8'hcb: out = 8'h59;
            8'hcc: out = 8'h27;
            8'hcd: out = 8'h80;
            8'hce: out = 8'hec;
            8'hcf: out = 8'h5f;
            8'hd0: out = 8'h60;
            8'hd1: out = 8'h51;
            8'hd2: out = 8'h7f;
            8'hd3: out = 8'ha9;
            8'hd4: out = 8'h19;
            8'hd5: out = 8'hb5;
            8'hd6: out = 8'h4a;
            8'hd7: out = 8'h0d;
            8'hd8: out = 8'h2d;
            8'hd9: out = 8'he5;
            8'hda: out = 8'h7a;
            8'hdb: out = 8'h9f;
            8'hdc: out = 8'h93;
            8'hdd: out = 8'hc9;
            8'hde: out = 8'h9c;
            8'hdf: out = 8'hef;
            8'he0: out = 8'ha0;
            8'he1: out = 8'he0;
            8'he2: out = 8'h3b;
            8'he3: out = 8'h4d;
            8'he4: out = 8'hae;
            8'he5: out = 8'h2a;
            8'he6: out = 8'hf5;
            8'he7: out = 8'hb0;
            8'he8: out = 8'hc8;
            8'he9: out = 8'heb;
            8'hea: out = 8'hbb;
            8'heb: out = 8'h3c;
            8'hec: out = 8'h83;
            8'hed: out = 8'h53;
            8'hee: out = 8'h99;
            8'hef: out = 8'h61;
            8'hf0: out = 8'h17;
            8'hf1: out = 8'h2b;
            8'hf2: out = 8'h04;
            8'hf3: out = 8'h7e;
            8'hf4: out = 8'hba;
            8'hf5: out = 8'h77;
            8'hf6: out = 8'hd6;
            8'hf7: out = 8'h26;
            8'hf8: out = 8'he1;
            8'hf9: out = 8'h69;
            8'hfa: out = 8'h14;
            8'hfb: out = 8'h63;
            8'hfc: out = 8'h55;
            8'hfd: out = 8'h21;
            8'hfe: out = 8'h0c;
            8'hff: out = 8'h7d;
            default: out = 8'h00;
        endcase
    end
endmodule


// Parallel SubBytes/InvSubBytes for 128-bit State
module aes_sub_bytes_128 (
    input  [127:0] state_in,
    input          dec, // 0 = Encrypt (Sbox), 1 = Decrypt (InvSbox)
    output [127:0] state_out
);
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : sbox_gen
            wire [7:0] sb_out;
            wire [7:0] isb_out;

            aes_sbox sb (
                .in(state_in[i*8 +: 8]),
                .out(sb_out)
            );

            aes_inv_sbox isb (
                .in(state_in[i*8 +: 8]),
                .out(isb_out)
            );

            assign state_out[i*8 +: 8] = dec ? isb_out : sb_out;
        end
    endgenerate
endmodule

// ShiftRows/InvShiftRows
module aes_shift_rows_128 (
    input  [127:0] state_in,
    input          dec, // 0 = ShiftRows, 1 = InvShiftRows
    output [127:0] state_out
);
    // Unpack bytes (column-major order)
    wire [7:0] s0  = state_in[127:120];
    wire [7:0] s1  = state_in[119:112];
    wire [7:0] s2  = state_in[111:104];
    wire [7:0] s3  = state_in[103:96];
    
    wire [7:0] s4  = state_in[95:88];
    wire [7:0] s5  = state_in[87:80];
    wire [7:0] s6  = state_in[79:72];
    wire [7:0] s7  = state_in[71:64];
    
    wire [7:0] s8  = state_in[63:56];
    wire [7:0] s9  = state_in[55:48];
    wire [7:0] s10 = state_in[47:40];
    wire [7:0] s11 = state_in[39:32];
    
    wire [7:0] s12 = state_in[31:24];
    wire [7:0] s13 = state_in[23:16];
    wire [7:0] s14 = state_in[15:8];
    wire [7:0] s15 = state_in[7:0];

    // Encryption ShiftRows
    wire [127:0] shift_out = {
        s0,  s5,  s10, s15, // Col 0
        s4,  s9,  s14, s3,  // Col 1
        s8,  s13, s2,  s7,  // Col 2
        s12, s1,  s6,  s11  // Col 3
    };

    // Decryption InvShiftRows
    wire [127:0] inv_shift_out = {
        s0,  s13, s10, s7,  // Col 0
        s4,  s1,  s14, s11, // Col 1
        s8,  s5,  s2,  s15, // Col 2
        s12, s9,  s6,  s3   // Col 3
    };

    assign state_out = dec ? inv_shift_out : shift_out;
endmodule

// MixColumns/InvMixColumns on a 32-bit Single Column
module aes_mix_column (
    input  [31:0] col_in,
    input         dec,
    output [31:0] col_out
);
    wire [7:0] s0 = col_in[31:24];
    wire [7:0] s1 = col_in[23:16];
    wire [7:0] s2 = col_in[15:8];
    wire [7:0] s3 = col_in[7:0];

    // Galois Field GF(2^8) multiplication by 2 (xtime)
    function automatic [7:0] xtime(input [7:0] x);
        xtime = {x[6:0], 1'b0} ^ (x[7] ? 8'h1B : 8'h00);
    endfunction

    // Intermediate xtime values
    wire [7:0] s0_2 = xtime(s0);
    wire [7:0] s1_2 = xtime(s1);
    wire [7:0] s2_2 = xtime(s2);
    wire [7:0] s3_2 = xtime(s3);

    // MixColumns outputs (multiply by 02, 03, 01, 01)
    wire [7:0] mc0 = s0_2 ^ (s1_2 ^ s1) ^ s2 ^ s3;
    wire [7:0] mc1 = s0 ^ s1_2 ^ (s2_2 ^ s2) ^ s3;
    wire [7:0] mc2 = s0 ^ s1 ^ s2_2 ^ (s3_2 ^ s3);
    wire [7:0] mc3 = (s0_2 ^ s0) ^ s1 ^ s2 ^ s3_2;

    // InvMixColumns outputs (multiply by 0e, 0b, 0d, 09)
    wire [7:0] s0_4 = xtime(s0_2);
    wire [7:0] s0_8 = xtime(s0_4);
    wire [7:0] s0_9 = s0_8 ^ s0;
    wire [7:0] s0_b = s0_8 ^ s0_2 ^ s0;
    wire [7:0] s0_d = s0_8 ^ s0_4 ^ s0;
    wire [7:0] s0_e = s0_8 ^ s0_4 ^ s0_2;

    wire [7:0] s1_4 = xtime(s1_2);
    wire [7:0] s1_8 = xtime(s1_4);
    wire [7:0] s1_9 = s1_8 ^ s1;
    wire [7:0] s1_b = s1_8 ^ s1_2 ^ s1;
    wire [7:0] s1_d = s1_8 ^ s1_4 ^ s1;
    wire [7:0] s1_e = s1_8 ^ s1_4 ^ s1_2;

    wire [7:0] s2_4 = xtime(s2_2);
    wire [7:0] s2_8 = xtime(s2_4);
    wire [7:0] s2_9 = s2_8 ^ s2;
    wire [7:0] s2_b = s2_8 ^ s2_2 ^ s2;
    wire [7:0] s2_d = s2_8 ^ s2_4 ^ s2;
    wire [7:0] s2_e = s2_8 ^ s2_4 ^ s2_2;

    wire [7:0] s3_4 = xtime(s3_2);
    wire [7:0] s3_8 = xtime(s3_4);
    wire [7:0] s3_9 = s3_8 ^ s3;
    wire [7:0] s3_b = s3_8 ^ s3_2 ^ s3;
    wire [7:0] s3_d = s3_8 ^ s3_4 ^ s3;
    wire [7:0] s3_e = s3_8 ^ s3_4 ^ s3_2;

    wire [7:0] imc0 = s0_e ^ s1_b ^ s2_d ^ s3_9;
    wire [7:0] imc1 = s0_9 ^ s1_e ^ s2_b ^ s3_d;
    wire [7:0] imc2 = s0_d ^ s1_9 ^ s2_e ^ s3_b;
    wire [7:0] imc3 = s0_b ^ s1_d ^ s2_9 ^ s3_e;

    assign col_out = dec ? {imc0, imc1, imc2, imc3} : {mc0, mc1, mc2, mc3};
endmodule

// Parallel MixColumns/InvMixColumns for 128-bit State
module aes_mix_columns_128 (
    input  [127:0] state_in,
    input          dec, // 0 = MixColumns, 1 = InvMixColumns
    output [127:0] state_out
);
    aes_mix_column col0 (.col_in(state_in[127:96]), .dec(dec), .col_out(state_out[127:96]));
    aes_mix_column col1 (.col_in(state_in[95:64]),  .dec(dec), .col_out(state_out[95:64]));
    aes_mix_column col2 (.col_in(state_in[63:32]),  .dec(dec), .col_out(state_out[63:32]));
    aes_mix_column col3 (.col_in(state_in[31:0]),   .dec(dec), .col_out(state_out[31:0]));
endmodule

// Key Expansion Round Unit
module aes_key_expand_round (
    input  [127:0] prev_key_A, // w[i-8 ... w[i-5]
    input  [127:0] prev_key_B, // w[i-4 ... w[i-1]
    input  [3:0]   r,          // round index (2 to 14)
    output [127:0] next_key
);
    wire [31:0] w_i_1 = prev_key_B[31:0];

    // RotWord: shift left by 1 byte (circular)
    wire [31:0] rot_word = {w_i_1[23:16], w_i_1[15:8], w_i_1[7:0], w_i_1[31:24]};

    // SubWord input selection: RotWord if round is even, else w_i_1
    wire [31:0] sub_word_in = (r[0] == 1'b0) ? rot_word : w_i_1;
    wire [31:0] sub_word_out;

    aes_sbox sbox0 (.in(sub_word_in[31:24]), .out(sub_word_out[31:24]));
    aes_sbox sbox1 (.in(sub_word_in[23:16]), .out(sub_word_out[23:16]));
    aes_sbox sbox2 (.in(sub_word_in[15:8]),  .out(sub_word_out[15:8]));
    aes_sbox sbox3 (.in(sub_word_in[7:0]),   .out(sub_word_out[7:0]));

    // Determine Rcon (only for even round indices, i.e., i is a multiple of 8)
    reg [31:0] rcon;
    always @(*) begin
        case (r)
            4'd2:  rcon = 32'h01000000;
            4'd4:  rcon = 32'h02000000;
            4'd6:  rcon = 32'h04000000;
            4'd8:  rcon = 32'h08000000;
            4'd10: rcon = 32'h10000000;
            4'd12: rcon = 32'h20000000;
            4'd14: rcon = 32'h40000000;
            default: rcon = 32'h00000000;
        endcase
    end

    wire [31:0] temp = sub_word_out ^ rcon;

    // XOR recursive chain
    wire [31:0] w0 = prev_key_A[127:96] ^ temp;
    wire [31:0] w1 = prev_key_A[95:64]  ^ w0;
    wire [31:0] w2 = prev_key_A[63:32]  ^ w1;
    wire [31:0] w3 = prev_key_A[31:0]   ^ w2;

    assign next_key = {w0, w1, w2, w3};
endmodule

// Key Expansion Top Module
module aes_key_expansion_256 (
    input              clk,
    input              reset_n,
    input              start_expand,
    input      [255:0] key_in,
    output reg         expand_done,
    output     [127:0] round_key_out,
    input      [3:0]   round_idx_in
);
    reg [127:0] round_keys [0:14];

    localparam IDLE = 1'b0;
    localparam CALC = 1'b1;
    reg state;

    reg [3:0] r_count;

    wire [127:0] prev_key_A = round_keys[r_count-2];
    wire [127:0] prev_key_B = round_keys[r_count-1];
    wire [127:0] next_key;

    aes_key_expand_round expand_unit (
        .prev_key_A(prev_key_A),
        .prev_key_B(prev_key_B),
        .r(r_count),
        .next_key(next_key)
    );

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state <= IDLE;
            r_count <= 4'd2;
            expand_done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    expand_done <= 1'b0;
                    if (start_expand) begin
                        round_keys[0] <= key_in[255:128];
                        round_keys[1] <= key_in[127:0];
                        r_count <= 4'd2;
                        state <= CALC;
                    end
                end
                CALC: begin
                    round_keys[r_count] <= next_key;
                    if (r_count == 4'd14) begin
                        expand_done <= 1'b1;
                        state <= IDLE;
                    end else begin
                        r_count <= r_count + 1'b1;
                    end
                end
            endcase
        end
    end

    assign round_key_out = round_keys[round_idx_in];
endmodule

// Main AES-256 Engine Core (Sub-pipelined architecture)
module aes_core_256 (
    input              clk,
    input              reset_n,
    input              key_load,
    input      [255:0] key_in,
    output             key_ready,
    
    input              start,
    input              mode, // 1 = Encrypt, 0 = Decrypt
    input      [127:0] din,
    output reg [127:0] dout,
    output             ready,
    output reg         done
);
    // State registers
    reg [127:0] state_reg;
    reg [127:0] state_mid_reg; // Sub-pipeline register between ShiftRows & MixColumns
    reg         phase;         // 0 = Phase A (SubBytes, ShiftRows), 1 = Phase B (MixColumns, AddRoundKey)
    reg [3:0]   r_count;
    reg         key_valid;

    // FSM States
    localparam ST_IDLE        = 3'd0;
    localparam ST_KEY_EXPAND  = 3'd1;
    localparam ST_ROUND_0     = 3'd2;
    localparam ST_ROUND_LOOP  = 3'd3;
    localparam ST_ROUND_FINAL = 3'd4;
    localparam ST_DONE        = 3'd5;

    reg [2:0] state;

    // Key Expansion Connections
    wire         expand_done;
    wire [127:0] round_key_out;
    wire [3:0]   key_idx = mode ? r_count : (4'd14 - r_count);

    aes_key_expansion_256 key_expansion_unit (
        .clk(clk),
        .reset_n(reset_n),
        .start_expand(state == ST_IDLE && key_load),
        .key_in(key_in),
        .expand_done(expand_done),
        .round_key_out(round_key_out),
        .round_idx_in(key_idx)
    );

    assign key_ready = key_valid;
    assign ready     = (state == ST_IDLE);

    // Datapath Instantiations
    wire [127:0] sub_bytes_out;
    wire [127:0] shift_rows_out;
    wire [127:0] mix_cols_out;

    aes_sub_bytes_128 sub_bytes_inst (
        .state_in(state_reg),
        .dec(~mode),
        .state_out(sub_bytes_out)
    );

    aes_shift_rows_128 shift_rows_inst (
        .state_in(sub_bytes_out),
        .dec(~mode),
        .state_out(shift_rows_out)
    );

    // For Decrypt, we do AddRoundKey BEFORE InvMixColumns.
    // For Encrypt, we do MixColumns BEFORE AddRoundKey.
    // The inputs here use the pipeline register state_mid_reg.
    aes_mix_columns_128 mix_cols_inst (
        .state_in(~mode ? (state_mid_reg ^ round_key_out) : state_mid_reg),
        .dec(~mode),
        .state_out(mix_cols_out)
    );

    // Datapath Output Muxing for Phase B
    wire [127:0] next_state_phase_B = (r_count == 4'd14) ? (state_mid_reg ^ round_key_out) :
                                      (~mode ? mix_cols_out : (mix_cols_out ^ round_key_out));

    // Controller FSM
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state <= ST_IDLE;
            state_reg <= 128'h0;
            state_mid_reg <= 128'h0;
            phase <= 1'b0;
            r_count <= 4'h0;
            done <= 1'b0;
            dout <= 128'h0;
            key_valid <= 1'b0;
        end else begin
            case (state)
                ST_IDLE: begin
                    done <= 1'b0;
                    phase <= 1'b0;
                    if (key_load) begin
                        state <= ST_KEY_EXPAND;
                        key_valid <= 1'b0;
                    end else if (start && key_valid) begin
                        state_reg <= din;
                        r_count <= 4'h0;
                        state <= ST_ROUND_0;
                    end
                end

                ST_KEY_EXPAND: begin
                    if (expand_done) begin
                        key_valid <= 1'b1;
                        state <= ST_IDLE;
                    end
                end

                ST_ROUND_0: begin
                    // Initial AddRoundKey (1 cycle)
                    state_reg <= state_reg ^ round_key_out;
                    r_count <= 4'd1;
                    phase <= 1'b0;
                    state <= ST_ROUND_LOOP;
                end

                ST_ROUND_LOOP: begin
                    if (phase == 1'b0) begin
                        // Phase A: Compute SubBytes + ShiftRows, write to pipeline register
                        state_mid_reg <= shift_rows_out;
                        phase <= 1'b1;
                    end else begin
                        // Phase B: Compute MixColumns + AddRoundKey, write back to state register
                        state_reg <= next_state_phase_B;
                        phase <= 1'b0;
                        if (r_count == 4'd13) begin
                            r_count <= 4'd14;
                            state <= ST_ROUND_FINAL;
                        end else begin
                            r_count <= r_count + 1'b1;
                        end
                    end
                end

                ST_ROUND_FINAL: begin
                    if (phase == 1'b0) begin
                        state_mid_reg <= shift_rows_out;
                        phase <= 1'b1;
                    end else begin
                        state_reg <= next_state_phase_B;
                        state <= ST_DONE;
                    end
                end

                ST_DONE: begin
                    dout <= state_reg;
                    done <= 1'b1;
                    state <= ST_IDLE;
                end

                default: state <= ST_IDLE;
            endcase
        end
    end
endmodule
