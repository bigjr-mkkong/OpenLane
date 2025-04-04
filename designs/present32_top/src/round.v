module round (
	ptext_i,
	key_i,
	cipher_o
);
	parameter DATAW = 32;
	input wire [DATAW - 1:0] ptext_i;
	input wire [DATAW - 1:0] key_i;
	output wire [DATAW - 1:0] cipher_o;
	wire [DATAW - 1:0] addrdkey_o;
	wire [DATAW - 1:0] sbox_o;
	add_round_key step_addrdkey1(
		.ptext_i(ptext_i),
		.key_i(key_i),
		.mixed_o(addrdkey_o)
	);
	sbox step_sbox(
		.data_i(addrdkey_o),
		.data_o(sbox_o)
	);
	pbox step_pbox(
		.data_i(sbox_o),
		.data_o(cipher_o)
	);
endmodule
module add_round_key (
	ptext_i,
	key_i,
	mixed_o
);
	parameter DATAW = 32;
	input wire [DATAW - 1:0] ptext_i;
	input wire [DATAW - 1:0] key_i;
	output wire [DATAW - 1:0] mixed_o;
	assign mixed_o = ptext_i ^ key_i;
endmodule
module pbox (
	data_i,
	data_o
);
	parameter DATAW = 32;
	input wire [DATAW - 1:0] data_i;
	output wire [DATAW - 1:0] data_o;
	localparam signed [1023:0] pbox = 1024'h80000001d000000170000000f00000005000000060000001500000012000000130000001600000011000000190000000e000000000000001f0000000a0000001e000000180000000700000010000000030000000900000014000000010000000d000000020000001b0000000b0000001c000000040000001a0000000c;
	genvar _gv_i_1;
	generate
		for (_gv_i_1 = 0; _gv_i_1 < DATAW; _gv_i_1 = _gv_i_1 + 1) begin : genblk1
			localparam i = _gv_i_1;
			assign data_o[i] = data_i[pbox[(31 - i) * 32+:32]];
		end
	endgenerate
endmodule
