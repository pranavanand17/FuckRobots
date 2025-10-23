//Customm functions for player
function setOnGround( _val = true){
	if _val == true{
		onGround = true;
		coyoteHangTimer = coyoteHangFrames;
	} else {
		onGround = false;
		coyoteHangTimer =0;
	}
}

//Control setup
controlSetup();

//Sprites
maskSpr= Gunner;
idleSpr = Gunner;
walkSpr = Gunner_right_motion;
jumpSpr = Gunner_jump;

//Moving
face=1;
moveDir=0;
runType=0;
moveSped[0]=2;
moveSped[1]=3.5;
xsped=0;
ysped=0;

//Jumping
	grav=.275;
	termvel=4;
	jsped[0]=-4.86;
	jumpMax=2;
	jumpCount=0;
	jumpHoldTimer=0;
		//Jump values for each successive jump
		jumpHoldFrames[0]=18;
		jumpHoldFrames[1]=10;
		jsped[1]=-3.86;
		onGround=true;
	//Coyote Time
	//Hang time
	coyoteHangFrames =2;
	coyoteHangTimer =0;
	//Jump buffer time
	coyoteJumpFrames = 5;
	coyoteJumpTimer=0;
	
	

//Sprite control
	centerYOffset = -30;
	centerY = y+centerYOffset;

//weapon info
	shootTimer =0;
	shootCooldown=9;
	
	bulletObj= Bullet;
	bullet_spawn_offset=55;
	 