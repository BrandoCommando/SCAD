module arc(radius, angle, thick = 1, teeth=0, toff = 0){
  $fn = radius * PI;
	intersection(){
		union(){
			rights = floor(angle/90);
			remain = angle-rights*90;
			if(angle > 90){
				for(i = [0:rights-1]){
					rotate(i*90-(rights-1)*90/2){
						polygon([[0, 0], [radius+thick, (radius+thick)*tan(90/2)], [radius+thick, -(radius+thick)*tan(90/2)]]);
					}
				}
				rotate(-(rights)*90/2)
					polygon([[0, 0], [radius+thick, 0], [radius+thick, -(radius+thick)*tan(remain/2)]]);
				rotate((rights)*90/2)
					polygon([[0, 0], [radius+thick, (radius+thick)*tan(remain/2)], [radius+thick, 0]]);
			}else{
				polygon([[0, 0], [radius+thick, (radius+thick)*tan(angle/2)], [radius+thick, -(radius+thick)*tan(angle/2)]]);
			}
		}
		difference(){
			circle(radius+thick);
			circle(radius);
		}
	}
  if(teeth>0)
  {
      $fn = 14;
      tcnt=(PI*radius) / teeth;
      tdeg=angle / tcnt;
      echo(str("TDEG: ", tdeg, ", ", tcnt, ", ", angle));
      roff = radius;
      ldeg = (toff + tdeg * tcnt) - tdeg;
      for(t=[toff:tdeg:angle])
      {
        translate([sin(t) * roff, cos(t) * roff])
        {
          color(t>=ldeg?"blue":"yellow")
            circle(0.55);
          if(t>=ldeg)
            echo(str(t,":",ldeg));
        }
      }
  }
}

module tooth() {
translate([-0.05,0,0]) {
arc(.555, angle=130, thick=0.5);
translate([0.2,-1.25]) rotate([0,0,140]) arc(.15, angle=75, thick=.15);
mirror([0,1,0]) translate([0.2,-1.25]) rotate([0,0,140]) arc(.15, angle=75, thick=.15);
translate([-.35,-.3])
  rotate([0,0,60])
    arc(1,angle=30, thick=.5);
mirror([0,1,0]) 
translate([-.35,-.3])
  rotate([0,0,60])
    arc(1,angle=30, thick=.5);
circle(d=1.4);
}
}
//*
th=1.4;
//linear_extrude(5)
{
  //arc(100,180,th,2);
  roff1 = (70*PI)%2;
  echo(str("Off: ",roff1));
  arc(70,180,th,2);
  translate([0,-2]) rotate([0,0,180])
    arc(68,180,th,2,roff1*-1);
  arc(66,180,th,2,-1.187);
//arc(89,180,th,2,-.288);
}
/*
linear_extrude(6)
for(s=[0:8])
{
  translate([0,(((s%2)*2)-1)*1])
  rotate([0,0,180*s])
    arc(100-(s*2), 180, 1, teeth=2, toff = s * -.091);
}
//*/