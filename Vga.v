module Vga(clk, rst, left, right, R, G, B, vga_h, vga_v, vga_clk_out, blank_n,level);
input level;
input clk, rst, left, right;
reg vga_clk;
reg [9:0]xPos;
reg [9:0]yPos;
reg [9:0]squareXpos[0:65];
reg [9:0]squareYpos[0:65];
reg [30:0]countY;
reg [30:0]debounce;
reg move;

wire moveLeft, moveRight;
wire border;
wire square[0:65];
wire box[0:29];

reg [2:0]l=3'd0;
integer c=0;
integer x=0;
integer i = 0;
integer leftx = 0;
integer rightx = 0;
integer y = 0;
integer grid[0:5];
integer p=0;
genvar n;
reg [1:0]win =2'd3;
reg [2:0]speed = 3'd3;

initial begin
	for(x=0;x<=65;x=x+1)begin:z
		squareYpos [x]<= 10'd0;
		squareXpos [x]<= 10'd605;
	end
end

parameter border_st_x 	  = 10'd496,
			 border_length_x = 10'd785,
			 border_st_y     = 6'd35, 
			 border_length_y = 10'd514,
			 border_width    = 6'd40,
			 square_length   = 6'd35;

output wire vga_h, vga_v, blank_n;
output wire vga_clk_out;
output reg [7:0]R;
output reg [7:0]G;
output reg [7:0]B;

//Halving the system clock to ~25MHZ
always @(posedge clk)
	vga_clk <= ~vga_clk;

hv_sync screen_one(vga_clk, vga_h, vga_v, blank_n);	

assign 	moveLeft = ~left;
assign	moveRight = ~right;
assign  	vga_v = vga_v;
assign  	vga_h = vga_h;
assign	blank_n = blank_n;
assign 	vga_clk_out = vga_clk;



//Border Around the screen
assign 	border =( (xPos > border_st_x && xPos < border_length_x && yPos > border_st_y && yPos < (border_st_y + border_width))
					  ||(xPos > border_st_x && xPos < border_length_x && yPos > (border_length_y - border_width) && yPos < border_length_y)
					  ||(xPos > border_st_x && xPos < (border_st_x + border_width) && yPos > border_st_y && yPos < border_length_y)
					  ||(xPos > (border_length_x - border_width) && xPos < border_length_x && yPos > border_st_y && yPos < border_length_y)
					  );
	
//Static boxes	
assign 	leftborder = (( xPos > 9'd235 && xPos <	(9'd235 + square_length) && yPos > 9'd440 && yPos < (9'd440 + square_length))||
								( xPos > 9'd270 && xPos <	(9'd270 + square_length) && yPos > 9'd440 && yPos < (9'd440 + square_length))||
								( xPos > 9'd305 && xPos <	(9'd305 + square_length) && yPos > 9'd440 && yPos < (9'd440 + square_length))||
								( xPos > 9'd340 && xPos <	(9'd340 + square_length) && yPos > 9'd440 && yPos < (9'd440 + square_length))||
								( xPos > 9'd375 && xPos <	(9'd375 + square_length) && yPos > 9'd440 && yPos < (9'd440 + square_length))||
								( xPos > 9'd410 && xPos <	(9'd410 + square_length) && yPos > 9'd440 && yPos < (9'd440 + square_length))||
								
								( xPos > 9'd235 && xPos <	(9'd235 + square_length) && yPos > 9'd404 && yPos < (9'd404 + square_length))||
								( xPos > 9'd270 && xPos <	(9'd270 + square_length) && yPos > 9'd404 && yPos < (9'd404 + square_length))||
								( xPos > 9'd305 && xPos <	(9'd305 + square_length) && yPos > 9'd404 && yPos < (9'd404 + square_length))||
								( xPos > 9'd340 && xPos <	(9'd340 + square_length) && yPos > 9'd404 && yPos < (9'd404 + square_length))||
								( xPos > 9'd375 && xPos <	(9'd375 + square_length) && yPos > 9'd404 && yPos < (9'd404 + square_length))||
								( xPos > 9'd410 && xPos <	(9'd410 + square_length) && yPos > 9'd404 && yPos < (9'd404 + square_length))||
								
								( xPos > 9'd235 && xPos <	(9'd235 + square_length) && yPos > 9'd368 && yPos < (9'd368 + square_length))||
								( xPos > 9'd270 && xPos <	(9'd270 + square_length) && yPos > 9'd368 && yPos < (9'd368 + square_length))||
								( xPos > 9'd305 && xPos <	(9'd305 + square_length) && yPos > 9'd368 && yPos < (9'd368 + square_length))||
								( xPos > 9'd340 && xPos <	(9'd340 + square_length) && yPos > 9'd368 && yPos < (9'd368 + square_length))||
								( xPos > 9'd375 && xPos <	(9'd375 + square_length) && yPos > 9'd368 && yPos < (9'd368 + square_length))||
								( xPos > 9'd410 && xPos <	(9'd410 + square_length) && yPos > 9'd368 && yPos < (9'd368 + square_length))||
								
								( xPos > 9'd235 && xPos <	(9'd235 + square_length) && yPos > 9'd332 && yPos < (9'd332 + square_length))||
								( xPos > 9'd270 && xPos <	(9'd270 + square_length) && yPos > 9'd332 && yPos < (9'd332 + square_length))||
								( xPos > 9'd305 && xPos <	(9'd305 + square_length) && yPos > 9'd332 && yPos < (9'd332 + square_length))||
								( xPos > 9'd340 && xPos <	(9'd340 + square_length) && yPos > 9'd332 && yPos < (9'd332 + square_length))||
								( xPos > 9'd375 && xPos <	(9'd375 + square_length) && yPos > 9'd332 && yPos < (9'd332 + square_length))||
								( xPos > 9'd410 && xPos <	(9'd410 + square_length) && yPos > 9'd332 && yPos < (9'd332 + square_length))||
								
								( xPos > 9'd235 && xPos <	(9'd235 + square_length) && yPos > 9'd296 && yPos < (9'd296 + square_length))||
								( xPos > 9'd270 && xPos <	(9'd270 + square_length) && yPos > 9'd296 && yPos < (9'd296 + square_length))||
								( xPos > 9'd305 && xPos <	(9'd305 + square_length) && yPos > 9'd296 && yPos < (9'd296 + square_length))||
								( xPos > 9'd340 && xPos <	(9'd340 + square_length) && yPos > 9'd296 && yPos < (9'd296 + square_length))||
								( xPos > 9'd375 && xPos <	(9'd375 + square_length) && yPos > 9'd296 && yPos < (9'd296 + square_length))||
								( xPos > 9'd410 && xPos <	(9'd410 + square_length) && yPos > 9'd296 && yPos < (9'd296 + square_length))
								);
								
assign  	box[0] =( xPos > 9'd235 && xPos <	(9'd235 + square_length) && yPos > 9'd440 && yPos < (9'd440 + square_length));
assign  	box[1] =( xPos > 9'd270 && xPos <	(9'd270 + square_length) && yPos > 9'd440 && yPos < (9'd440 + square_length));
assign  	box[2] =( xPos > 9'd305 && xPos <	(9'd305 + square_length) && yPos > 9'd440 && yPos < (9'd440 + square_length));
assign  	box[3] =( xPos > 9'd340 && xPos <	(9'd340 + square_length) && yPos > 9'd440 && yPos < (9'd440 + square_length));
assign  	box[4] =( xPos > 9'd375 && xPos <	(9'd375 + square_length) && yPos > 9'd440 && yPos < (9'd440 + square_length));
assign  	box[5] =( xPos > 9'd410 && xPos <	(9'd410 + square_length) && yPos > 9'd440 && yPos < (9'd440 + square_length));

assign  	box[6] =( xPos > 9'd235 && xPos <	(9'd235 + square_length) && yPos > 9'd404 && yPos < (9'd404 + square_length));
assign  	box[7] =( xPos > 9'd270 && xPos <	(9'd270 + square_length) && yPos > 9'd404 && yPos < (9'd404 + square_length));
assign  	box[8] =( xPos > 9'd305 && xPos <	(9'd305 + square_length) && yPos > 9'd404 && yPos < (9'd404 + square_length));
assign  	box[9] =( xPos > 9'd340 && xPos <	(9'd340 + square_length) && yPos > 9'd404 && yPos < (9'd404 + square_length));
assign  	box[10] =( xPos > 9'd375 && xPos <	(9'd375 + square_length) && yPos > 9'd404 && yPos < (9'd404 + square_length));
assign  	box[11] =( xPos > 9'd410 && xPos <	(9'd410 + square_length) && yPos > 9'd404 && yPos < (9'd404 + square_length));

assign  	box[12] =( xPos > 9'd235 && xPos <	(9'd235 + square_length) && yPos > 9'd368 && yPos < (9'd368 + square_length));
assign  	box[13] =( xPos > 9'd270 && xPos <	(9'd270 + square_length) && yPos > 9'd368 && yPos < (9'd368 + square_length));
assign  	box[14] =( xPos > 9'd305 && xPos <	(9'd305 + square_length) && yPos > 9'd368 && yPos < (9'd368 + square_length));
assign  	box[15] =( xPos > 9'd340 && xPos <	(9'd340 + square_length) && yPos > 9'd368 && yPos < (9'd368 + square_length));
assign  	box[16] =( xPos > 9'd375 && xPos <	(9'd375 + square_length) && yPos > 9'd368 && yPos < (9'd368 + square_length));
assign  	box[17] =( xPos > 9'd410 && xPos <	(9'd410 + square_length) && yPos > 9'd368 && yPos < (9'd368 + square_length));

assign  	box[18] =( xPos > 9'd235 && xPos <	(9'd235 + square_length) && yPos > 9'd332 && yPos < (9'd332 + square_length));
assign  	box[19] =( xPos > 9'd270 && xPos <	(9'd270 + square_length) && yPos > 9'd332 && yPos < (9'd332 + square_length));
assign  	box[20] =( xPos > 9'd305 && xPos <	(9'd305 + square_length) && yPos > 9'd332 && yPos < (9'd332 + square_length));
assign  	box[21] =( xPos > 9'd340 && xPos <	(9'd340 + square_length) && yPos > 9'd332 && yPos < (9'd332 + square_length));
assign  	box[22] =( xPos > 9'd375 && xPos <	(9'd375 + square_length) && yPos > 9'd332 && yPos < (9'd332 + square_length));
assign  	box[23] =( xPos > 9'd410 && xPos <	(9'd410 + square_length) && yPos > 9'd332 && yPos < (9'd332 + square_length));

assign  	box[24] =( xPos > 9'd235 && xPos <	(9'd235 + square_length) && yPos > 9'd296 && yPos < (9'd296 + square_length));
assign  	box[25] =( xPos > 9'd270 && xPos <	(9'd270 + square_length) && yPos > 9'd296 && yPos < (9'd296 + square_length));
assign  	box[26] =( xPos > 9'd305 && xPos <	(9'd305 + square_length) && yPos > 9'd296 && yPos < (9'd296 + square_length));
assign  	box[27] =( xPos > 9'd340 && xPos <	(9'd340 + square_length) && yPos > 9'd296 && yPos < (9'd296 + square_length));
assign  	box[28] =( xPos > 9'd375 && xPos <	(9'd375 + square_length) && yPos > 9'd296 && yPos < (9'd296 + square_length));
assign  	box[29] =( xPos > 9'd410 && xPos <	(9'd410 + square_length) && yPos > 9'd296 && yPos < (9'd296 + square_length));
//Moving square


generate
	for(n=0;n<=65;n=n+1) begin:m
 		assign square[n] =( xPos > squareXpos[n] && xPos < (squareXpos[n] + square_length) && yPos > squareYpos[n] && yPos < (squareYpos[n] + square_length));
	end
endgenerate
		
//Scene					  
always @(*)
begin
	
	//level-3
	if((square[36]||square[37]||square[38]||square[39]||square[40]||square[41]||square[42]||square[43]||square[44]||square[45]||square[46]||square[47]||
		square[48]||square[49]||square[50]||square[51])&&l==3'd3)
	begin
		R = 8'd0;
		G = 8'd120;
		B = 8'd255;
	end
	//level-2
	else if((square[21]||square[22]||square[23]||square[24]||square[25]||square[26]||square[27]||square[28]||square[29]||square[30]||square[31]||square[32]||
		square[33]||square[34]||square[35]||square[36])&&l==3'd2)
	begin
		R = 8'd0;
		G = 8'd120;
		B = 8'd255;
	end
	//level-1
	else if((square[8]||square[9]||square[10]||square[11]||square[12]||square[13]||square[14]||square[15]||square[16]||
		square[17]||square[18]||square[19]||square[20]||square[21])&&l==3'd1)
	begin
		R = 8'd0;
		G = 8'd120;
		B = 8'd255;
	end
	//level-0
	else if((square[0]||square[1]||square[2]||square[3]||square[4]||square[5]||square[6]||
		square[7]||square[8])&&l==3'd0)
	begin
		R = 8'd0;
		G = 8'd120;
		B = 8'd255;
	end
	
	//level-3
	else if((box[0])&&l==3'd3&&(c==0||c==5))
	begin
		R = 8'd0;
		G = 8'd255;
		B = 8'd0;
	end
	else if((box[1]||box[7]||box[13]||box[19])&&l==3'd3&&(c==0||c==1))
	begin
		R = 8'd0;
		G = 8'd255;
		B = 8'd0;
	end
	else if((box[2])&&l==3'd3&&(c==1||c==2))
	begin
		R = 8'd0;
		G = 8'd255;
		B = 8'd0;
	end
	else if((box[3]||box[9])&&l==3'd3&&(|c==2||c==3))
	begin
		R = 8'd0;
		G = 8'd255;
		B = 8'd0;
	end
	else if((box[4]||box[10]||box[16]||box[22]||box[28])&&l==3'd3&&(|c==3||c==4))
	begin
		R = 8'd0;
		G = 8'd255;
		B = 8'd0;
	end
	else if((box[5]||box[11])&&l==3'd3&&(c==4||c==5))
	begin
		R = 8'd0;
		G = 8'd255;
		B = 8'd0;
	end
	
	//level-2
	else if((box[0])&&l==3'd2&&(c==0||c==4||c==5))
	begin
		R = 8'd0;
		G = 8'd255;
		B = 8'd0;
	end
	else if((box[1]||box[7]||box[13])&&l==3'd2&&(c==0||c==1||c==5))
	begin
		R = 8'd0;
		G = 8'd255;
		B = 8'd0;
	end
	else if((box[2]||box[8])&&l==3'd2&&(c==0||c==1||c==2))
	begin
		R = 8'd0;
		G = 8'd255;
		B = 8'd0;
	end
	else if((box[3]||box[9]||box[15]||box[21])&&l==3'd2&&(c==1||c==2||c==3))
	begin
		R = 8'd0;
		G = 8'd255;
		B = 8'd0;
	end
	else if((box[4])&&l==3'd2&&(c==2||c==3||c==4))
	begin
		R = 8'd0;
		G = 8'd255;
		B = 8'd0;
	end
	else if((box[5]||box[11]||box[17]||box[23])&&l==3'd2&&(c==3||c==4||c==5))
	begin
		R = 8'd0;
		G = 8'd255;
		B = 8'd0;
	end
	/*
	//level-2
	else if((box[0]||box[1]||box[2]||box[3]||box[4]||box[5]||box[7]||box[8]||box[9]||box[11]||box[13]||box[15]||box[17]||box[21]||box[23])&&l==3'd2)
	begin
		R = 8'd0;
		G = 8'd255;
		B = 8'd0;
	end
	*/
	//level-1
	else if((box[0]||box[1]||box[2]||box[3]||box[4]||box[5]||box[6]||box[7]||box[9]||box[10]||box[11]||box[13]||box[17])&&l==3'd1)
	begin
		R = 8'd0;
		G = 8'd255;
		B = 8'd0;
	end
	//level-0
	else if((box[0]||box[1]||box[2]||box[3]||box[4]||box[5]||box[7]||box[9])&&l==3'd0)
	begin
		R = 8'd0;
		G = 8'd255;
		B = 8'd0;
	end
	
	//border
	else if(border&&win==2'd3)
	begin
		R = 8'd255;
		G = 8'd255;
		B = 8'd255;
	end
	else if(border&&win==2'd1)
	begin
		R = 8'd0;
		G = 8'd225;
		B = 8'd0;
	end
	else if(border&&win==2'd0)
	begin
		R = 8'd225;
		G = 8'd0;
		B = 8'd0;
	end
	else if(border||leftborder)
	begin
		R = 8'd255;
		G = 8'd255;
		B = 8'd255;
	end
	else 
	begin
		R = 8'd56;
		G = 8'd0;
		B = 8'd56;
	end
end

//Moving
always @(posedge vga_clk)
begin

		if(squareYpos[i]==10'd440 || squareYpos[i]>10'd405)
			y <= 1;
		else if(10'd405==squareYpos[i] || squareYpos[i]>10'd370)
			y <= 2;
		else if(10'd370==squareYpos[i] || squareYpos[i]>10'd335)
			y <= 3;
		else if(10'd335==squareYpos[i] || squareYpos[i]>10'd300)
			y <= 4;
		else if(10'd300==squareYpos[i] || squareYpos[i]>10'd265)
			y <= 5;
		else if(10'd265==squareYpos[i] || squareYpos[i]>10'd230)
			y <= 6;
		else if(10'd230==squareYpos[i] || squareYpos[i]>10'd195)
			y <= 7;
		else if(10'd195==squareYpos[i] || squareYpos[i]>10'd160)
			y <= 8;
		else if(10'd160==squareYpos[i] || squareYpos[i]>10'd125)
			y <= 9;
		else if(10'd125==squareYpos[i] || squareYpos[i]>10'd90)
			y <= 10;
		else if(10'd90==squareYpos[i] || squareYpos[i]>10'd55)
			y <= 11;
		else if(10'd55==squareYpos[i] || squareYpos[i]>10'd20)
			y <= 12;
			
		if(squareXpos[i] == 10'd535 )
		begin
				leftx<=5;
				rightx<=1;
		end
		else if(squareXpos[i] == 10'd570 )
		begin
				leftx<=0;
				rightx<=2;
		end
		else if(squareXpos[i] == 10'd605 )
		begin
				leftx<=1;
				rightx<=3;
		end
		else if(squareXpos[i] == 10'd640 )
		begin
				leftx<=2;
				rightx<=4;
		end
		else if(squareXpos[i] == 10'd675 )
		begin
				leftx<=3;
				rightx<=5;
		end
		else if(squareXpos[i] == 10'd710 )
		begin
				leftx<=4;
				rightx<=0;
		end

		if(moveLeft&&y>grid[leftx])
		begin
			if(debounce == 31'd3000000)
			begin
				debounce <= 31'd0;
				squareXpos[i] <= squareXpos[i] - square_length;
			end
			else
				debounce <= debounce + 1'b1;
		end
		
		else if(moveRight&&y>grid[rightx])
		begin
				if(debounce == 31'd3000000)
				begin
					debounce <= 31'd0;
					squareXpos[i] <= squareXpos[i] + square_length;
				end
				else
					debounce <= debounce + 1'b1;

		end
		else
		debounce <= 31'd0;
		
	if(squareXpos[i] < 10'd535)
		squareXpos[i] <=10'd710;
	else if(squareXpos[i] > 10'd710)
		squareXpos[i] <=10'd535;
end


//Auto scrolls the box downwards and pops it back to the top of the screen if it hits the bottom border
always @(posedge vga_clk)
begin

	if(squareXpos[i] == 10'd535 )
			p<=0;
	else if(squareXpos[i] == 10'd570 )
			p<=1;
	else if(squareXpos[i] == 10'd605 )
			p<=2;
	else if(squareXpos[i] == 10'd640 )
			p<=3;
	else if(squareXpos[i] == 10'd675 )
			p<=4;
	else if(squareXpos[i] == 10'd710 )
			p<=5;
	
	if(win==2'd1 && level ==1'b1)
	begin
		win <= 2'd3;
		speed <= 3'd6;
	end
	//lose-0			
	else if(l==3'd0&&(grid[0]>1 || grid[1]>2 ||grid[2]>1 || grid[3]>2 || grid[4]>1 || grid[5]>1))
	begin
		win <= 2'd0;
		speed<=0;
	end
	//win-0
	else if(l==3'd0&&(grid[0]==1 && grid[1]==2 && grid[2]==1 && grid[3]==2 && grid[4]==1 && grid[5]==1))
	begin
		win <= 2'd1;
		speed<=0;
		grid[0]<=0;
		grid[1]<=0;
		grid[2]<=0;
		grid[3]<=0;
		grid[4]<=0;
		grid[5]<=0;
		l <= l+1'd1;
	end
	
	//lose-1
	else if(l==3'd1&&(grid[0]>2 || grid[1]>3 ||grid[2]>1 || grid[3]>2 || grid[4]>2 || grid[5]>3))
	begin
		win <= 2'd0;
		speed<=0;
	end
	//win-1
	else if(l==3'd1&&(grid[0]==2 && grid[1]==3 && grid[2]==1 && grid[3]==2 && grid[4]==2 && grid[5]==3))
	begin
		win <= 2'd1;
		speed<=0;
		grid[0]<=0;
		grid[1]<=0;
		grid[2]<=0;
		grid[3]<=0;
		grid[4]<=0;
		grid[5]<=0;
		l <= l+1'd1;
	end
	
	//lose-2
	else if(l==3'd2&&(grid[0]>1 || grid[1]>3 ||grid[2]>2 || grid[3]>4 || grid[4]>1 || grid[5]>4))
	begin
		win<=2'd0;
		speed<=0;
	end
	//win-2
	else if(l==3'd2&&(grid[0]==1 && grid[1]==3 && grid[2]==2 && grid[3]==4 && grid[4]==1 && grid[5]==4))
	begin
		win<=2'd1;
		speed<=0;
		grid[0]<=0;
		grid[1]<=0;
		grid[2]<=0;
		grid[3]<=0;
		grid[4]<=0;
		grid[5]<=0;
		l <= l+1'd1;
	end
	
	//lose-3
	else if(l==3'd3&&(grid[0]>1 || grid[1]>4 ||grid[2]>1 || grid[3]>2 || grid[4]>5 || grid[5]>2))
	begin
		win<=2'd0;
		speed<=0;
	end
	//win-3
	else if(l==3'd3&&(grid[0]==1 && grid[1]==4 && grid[2]==1 && grid[3]==2 && grid[4]==5 && grid[5]==2))
	begin
		win<=2'd1;
		speed<=0;
		grid[0]<=0;
		grid[1]<=0;
		grid[2]<=0;
		grid[3]<=0;
		grid[4]<=0;
		grid[5]<=0;
		l <= l+1'd1;
	end
	
	else if(squareYpos[i] >= 9'd440-grid[p]*(square_length+1'd1))
	begin
		grid[p]<=grid[p]+1;
		i<=i+1;
		if(l == 3'd2 || l==3'd3)
			c<=(c+1)%6;
	end
	else if(move)
			squareYpos[i] <= squareYpos[i] + speed;

end

//Counts for a ~1/2 of a second then sets move to high 
always @(posedge vga_clk)
begin
	if(countY == 31'd750000)
   begin
		countY <= 31'd0;
		move <= 1'b1;
	end
	
	else
	begin
		countY <= countY + 1'b1;
		move <= 1'b0;
	end
end
	
//Counts the Screen pixel by pixel
always @(posedge vga_clk)
begin
	if(xPos >= 10'd799)
		xPos <= 10'd0;
	else
		xPos <= xPos + 1'b1;
end

always @(posedge vga_clk)
begin
	if(xPos >= 10'd799)
	begin
	if(yPos >= 10'd523)
		yPos <= 10'd0;
	else
		yPos <= yPos + 1'b1;
	end
end
	
endmodule
