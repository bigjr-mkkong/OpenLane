module present32_top (
	clk_i,
	rst_ni,
	ptext_i,
	key_i,
	cipher_o
);
	parameter DATAW = 32;
	input wire clk_i;
	input wire rst_ni;
	input wire [DATAW - 1:0] ptext_i;
	input wire [DATAW - 1:0] key_i;
	output reg [DATAW - 1:0] cipher_o;
	wire [DATAW - 1:0] cipher_buf;
	round #(.DATAW(DATAW)) round_dut(
		.ptext_i(ptext_i),
		.key_i(key_i),
		.cipher_o(cipher_buf)
	);
	always @(posedge clk_i)
		if (~rst_ni)
			cipher_o <= 0;
		else
			cipher_o <= cipher_buf;
endmodule
