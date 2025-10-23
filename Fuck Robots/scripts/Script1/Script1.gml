function controlSetup(){
	jumpBufferTime = 3;
	jumpKeyBuffered = 0;
	jumpKeyBufferTimer = 0;
}


function getControls() 
{
	//Directional inputs
	rightKey= keyboard_check(ord("D")) + keyboard_check(vk_right);
		rightKey= clamp(rightKey, 0, 1);
	leftKey= keyboard_check(ord("A")) + keyboard_check(vk_left);
		leftKey= clamp(leftKey, 0, 1);
	
	//Action inputs	
	jumpKeyPressed= keyboard_check_pressed(ord("W"))+ keyboard_check_pressed(vk_up);
		jumpKeyPressed = clamp(jumpKeyPressed, 0, 1);
	jumpKey = keyboard_check(ord("W")) + keyboard_check(vk_up);
		jumpKey = clamp(jumpKey, 0, 1);
		
	runKey= keyboard_check(vk_shift);
		runKey= clamp(runKey, 0, 1);
		
	shootKey = keyboard_check(vk_space);
	
	//player aiming
		centerY = y+centerYOffset;
		
		//aim
		aimDir = point_direction(x, centerY ,x+ (image_xscale*face), centerY);
	
	//Jump key buffering
	if jumpKeyPressed{
		jumpKeyBufferTimer = jumpBufferTime;
	}
	if jumpKeyBufferTimer>0{
		
		jumpKeyBuffered=1;
		jumpKeyBufferTimer--;
	} else{
		jumpKeyBuffered=0;
	}
	
}