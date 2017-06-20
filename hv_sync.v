module hv_sync(clk, vga_h_sync, vga_v_sync, blank_n);

//~25 Mhz
input clk;

output reg vga_h_sync, vga_v_sync, blank_n;

reg [9:0]h_count; 
reg [9:0]v_count;

wire h_maxed, v_maxed, vga_hs, vga_vs, hori_valid, vert_valid, blank;


//Parameters are set for a 640X480 resolution
parameter	hori_line = 800,
				hori_back_porch = 144,
				hori_front_porch = 16,	
				vert_line = 524,
				vert_back_porch = 33,
				vert_front_porch = 10,
				hori_sync_cycle = 96,
				vert_sync_cycle = 2;

assign h_maxed = (h_count == (hori_line - 1'd1));
assign v_maxed = (v_count == (vert_line - 1'd1));
assign vga_hs = (h_count < hori_sync_cycle) ? 1'b0:1'b1;
assign vga_vs = (v_count < vert_sync_cycle) ? 1'b0:1'b1;

assign hori_valid = (h_count < (hori_line - hori_front_porch) && h_count >= hori_back_porch) ? 1'b1:1'b0;
assign vert_valid = (v_count < (vert_line - vert_front_porch) && v_count >= vert_back_porch) ? 1'b1:1'b0;

assign blank = hori_valid && vert_valid;

always @(posedge clk)
begin
	if(h_maxed)
		h_count <= 10'd0;
	else
		h_count <= h_count + 1'b1;
end

always @(posedge clk)
begin
	if(h_maxed)
	begin
		if(v_maxed)
			v_count <= 10'd0;
		else
			v_count <= v_count + 1'b1;
	end
end

always @(posedge clk)
begin
	vga_h_sync <= vga_hs;
	vga_v_sync <= vga_vs;
	blank_n    <= blank;
end

endmodule



   