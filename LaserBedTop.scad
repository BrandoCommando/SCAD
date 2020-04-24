tw=inches(13.75);
th=inches(10.8);
spacebig=10;
holebig=8;
holesmall=3;
holecorner=9;
holesides=5.4;
holeoff=0; //holebig/2-holesmall/2;
xholes=(inches(12))/spacebig;
yholes=(inches(8))/spacebig;
hw=(xholes-.475)*spacebig-.05;
hh=(yholes)*spacebig-holesmall-.2;

//difference()
{
  bed();
  //translate([tw,th]) rotate([0,0,180]) bed();
}
module bed() {
difference() {
  square([tw,th]);
  *translate([inches(1),inches(1)]) square([inches(12),inches(8)]);
  translate([tw/2-hw/2,th/2-hh/2]) 
  //translate([20+holesmall/2,20+holesmall/2])
    for(x=[0:xholes],y=[0:yholes])
      if(((y%5==0&&x%5==0)||(x>0&&x%5==0&&x<xholes-1)||(y>0&&y<yholes-1&&x<xholes-1))&&!(x==0&&y%5!=0))
      translate([x*spacebig+(x==0&&y%5!=0?-holeoff:0),(y*spacebig)+(y==0&&x%5!=0?-holeoff:0)]) circle(d=y%5==0&&x%5==0?holesmall:holebig,$fn=30);
  for(x=[10:(tw-20)/5:tw-10],y=[10,th-10]) translate([x,y]) circle(d=(x==10||x==tw-10)&&(y==10||y==th-10)?holecorner:holesides,$fn=36);
  for(y=[10:(th-20)/3:th-10],x=[10,tw-10]) translate([x,y]) circle(d=holesides,$fn=36);
}
}

module rsquare(dims,r=2)
{
  for(x=[r,dims[0]-r],y=[r,dims[1]-r])
    translate([x,y]) circle(r=r);
  translate([r,0]) square([dims[0]-r*2,dims[1]]);
  translate([0,r]) square([dims[0],dims[1]-r*2]);
}
function inches(in) = 25.4 * in;