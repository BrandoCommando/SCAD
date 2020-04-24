$fn=230;
//*
th=1.6;
pitch = 2;
belt(230,pitch=pitch,thick=th);
/*
linear_extrude(6)
for(s=[0:8])
{
  translate([0,(((s%2)*2)-1)*1])
  rotate([0,0,180*s])
    arc(100-(s*2), 180, 1, pitch=2, toff = s * -.091);
}
//*/

module belt2(dist,h=6,pitch=2,thick=1.4)
{
  teeth=ceil((PI*dist/2)/pitch);
  belt(teeth,h,pitch,thick);
}
module belt(teeth,h=6,pitch=2,thick=1.4)
{
  radius=((teeth/2)*pitch)/PI;
  echo(str("T",pitch," Belt @ ",teeth," = r",radius," = c",2*PI*radius));
  linear_extrude(h)
  for(m=[0,1]) mirror([m,0])
    arc(radius, 180, thick, pitch);
}
module arc(radius, angle, thick = 1, pitch=0, toff = 0,$fn=$fn){
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
			circle(radius+thick,$fn=$fn);
			circle(radius,$fn=$fn);
		}
	}
  if(pitch>0)
  {
      $fn = 14;
      tcnt=(PI*radius) / pitch;
      tdeg=angle / tcnt;
      //echo(str("TDEG: ", tdeg, ", ", tcnt, ", ", angle, ", ", tcnt * tdeg));
      roff = radius - 1;
      ldeg = (toff + tdeg * tcnt) - tdeg;
      for(t=[toff:tdeg:angle])
      {
        translate([sin(t) * roff, cos(t) * roff])
        {
          circle(pitch / 4, $fn=16);
          translate([sin(t)*(pitch/4),cos(t)*(pitch/4)]) rotate(90-t)
          square([pitch/2,pitch*.5],center=true);
          *if(t>=ldeg)
            echo(str(radius,": ",180-t,":",ldeg));
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
