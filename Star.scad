difference(){
  star(18,fat_ratio=.35);
  translate([0,0,-.01]) star(14,extrude=1.02,fat_ratio=.35);
}
star(fat_ratio=.35);
/*
difference(){
  translate([0,0,-1]) cylinder(d=40,h=2);
  star(18,extrude=1.02,fat_ratio=.35);
}
difference(){
  star(14,fat_ratio=.35);
  translate([0,0,-.01]) star(extrude=1.02,fat_ratio=.35);
}
*/
//  star(fat_ratio=.35);
module star(size=10,points=5,extrude=1,fat_ratio=.25)
{
  linear_extrude(extrude)
  for(dir=[1:points])
    rotate([0,0,(360/points) * dir])
      polygon([[0,size*fat_ratio],[size,0],[0,size*fat_ratio*-1]]);
}