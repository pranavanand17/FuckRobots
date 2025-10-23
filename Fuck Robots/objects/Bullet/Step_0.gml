//move
	xsped=lengthdir_x(sped, dir);
	ysped= lengthdir_x(sped, dir);

	x+=xsped;
	//y+=ysped;
	
	
//cleanup	
	//destroy
	if destroy == true{
		//vfx
		instance_destroy();
	}
	//collision
	if place_meeting( x+ xsped, y, Wall) {
		destroy=true;
	}
	
	//bullet out of range
	if point_distance(xstart, ystart, x, y)> maxDist{
		destroy=true;
	}	


	