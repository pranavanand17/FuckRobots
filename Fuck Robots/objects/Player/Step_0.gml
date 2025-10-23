getControls();

//X Movement
	//Direction
	moveDir=rightKey - leftKey;

	//Get my face
	if moveDir !=0 {face= moveDir;};

	//Get xspeed
	runType= runKey;
	xsped= moveDir*moveSped[runType];


	//X colllision
	var _subPixel=.5;
	if place_meeting(x+xsped, y, Wall)
	{
		//First check if there is a slope to go up
		if !place_meeting(x + xsped, y - abs(xsped)-1, Wall)
		{
			while place_meeting(x+xsped,y, Wall) {
				y -= _subPixel;
			};
		}
		//If there's no slope, regular collision
		else
		{
		
		
			//Scoot up to wall precisely
			var _pixelCheck = _subPixel*sign(xsped);
			while !place_meeting(x+_pixelCheck, y, Wall)
			{
				x+=_pixelCheck;
			}
	
			//Set xsped to zero to "collide"
			xsped=0;
		}
	} 

	//Move
	x+=xsped;

//Y Movement
	//Gravity
	if coyoteHangTimer > 0 {
		//Count the timer down
		coyoteHangTimer--;
	} else {
		//Apply gravity to the player
		ysped+=grav;
		//We're no longer on the ground
		setOnGround(false);
	}
	
	//Reset/Prepare jumping variables
	if onGround{
		jumpCount=0;
		jumpHoldTimer=0;
		coyoteJumpTimer= coyoteJumpFrames;
	} else {
		//If the player is in the air, make sure they can't do an extra jump
		coyoteJumpTimer--;
		if jumpCount ==0 && coyoteJumpTimer<=0 {
			jumpCount=1;	
		};
	}
	
	//Initiate the Jump
	if jumpKeyBuffered && jumpCount< jumpMax {
		
		//Reset the buffer
		jumpKeyBuffered=false;
		jumpKeyBufferTimer=0;
		
		//Increase the number of performed jumps
		jumpCount++;
		
		//Set the jump hold timer
		jumpHoldTimer = jumpHoldFrames[jumpCount-1];
		
		//Tell ourself we're no longer on the ground
		setOnGround(false);
	
	}
	
	//Cut off the jump by releasing the jump button
	if !jumpKey{
		jumpHoldTimer=0;
	}
	//Jump based on the timer/holding the button
	if jumpHoldTimer>0{
		
		//Constantly set the ysped to be jumping speed
		ysped=jsped[jumpCount-1];
		//Count down the timer
		jumpHoldTimer--;
	}
	
	//Y Collision and movement
		//Cap falling speed
		if ysped > termvel { ysped=termvel; };
	
	
		//Y Collision
		var _subPixel =.5;
		if place_meeting(x,y+ysped, Wall){
			//Scoot up to wall precisely
			var _pixelCheck=_subPixel+sign(ysped);
			while !place_meeting(x,y+_pixelCheck, Wall)
			{
				y+=_pixelCheck;
			}
			//Bonk code
			if ysped < 0{
				jumpHoldTimer=0;
			}
			
			//set ysped to 0
			ysped=0;
		
		}
		
		
		
		//Set if I'm on the ground
		if ysped >=0 && place_meeting(x, y+1, Wall){
			setOnGround(true);
		}
		//Move
		y+=ysped;
		
//Shoot the weapon
if shootTimer>0 {
	shootTimer--;
};
if shootKey && shootTimer<=0 {
	
	//reset the timer
	shootTimer= shootCooldown;
	//shooting
		//Gun offset (can be changed)
		var gun_offset_x = image_xscale * face * bullet_spawn_offset; // Adjust this based on your gun's position
		var gun_offset_y = -30;
	
		//create the bullet
		var _bulletInst = instance_create_depth(x + gun_offset_x, y + gun_offset_y, depth, bulletObj);
	
		//change the bullet's direction
		with(_bulletInst){
			dir=other.aimDir;
		}
}

//Sprite Control
//Walking
	if abs(xsped)>0 {
		sprite_index=walkSpr;
		
	};
	//Running
	if abs(xsped) >= moveSped[1] {sprite_index=Gunner_run; };
	//Not moving
	if xsped==0 {sprite_index= idleSpr; };
	//In the air
	if !onGround { sprite_index= jumpSpr;};
		//set the collision mask
		mask_index = maskSpr;
	if shootKey && onGround && sprite_index==Gunner {
			sprite_index= Gunner_shoot;
	};
	if shootKey && onGround && sprite_index==walkSpr {
			sprite_index= Gunner_walk_shoot;
	};
	if shootKey && onGround && sprite_index==Gunner_run {
			sprite_index= Gunner_run_shoot;
	};

	
