holes=12;
difference(){
  box(holes*10+10,20,30,2,bottom=0);
  for(n=[1:holes])
    translate([n*10,10,4]) cylinder(d1=5,d2=n/8+5,h=30,$fn=20);
}
module box(w,d,h,r=1,top=1,bottom=1)
{
  intersection(){
    cube([w,d,h]);
    minkowski(){
      translate([r,r,bottom?r:0]) cube([w-r*2,d-r*2,h-r*2]);
      sphere(r,$fn=30);
    }
  }
}