thick=2;
arms=5;
td=10;

*for(s=[8:0.5:15.5])
  translate([(floor(s/4)-2)*50,((s-8)*40)%160]) {
    linear_extrude(2)
    {
      arm(s);
      translate([0,-10]) square([4,20]);
    }
    translate([15,0,2])
      linear_extrude(0.6) rotate([0,0,0]) text(text=str(s),size=6,halign="center",valign="center",font="Arial:style=Bold");
    
  }
for(a=[1:4]) {
  translate([(a-1)*60%240,a>4?60:0]) 
    linear_extrude(thick) rotate([0,0,56*a]) profile(a,td);
  if(a>1)
  translate([(a-1)*60%240-60,60])
    linear_extrude(thick) rotate([0,0,46*a]) profile(a+1,td,1);
}

module profile(arms=4,td=td,div=0) {
  difference() {
    union() {
      circle(d=20,$fn=50);
      if(div)
        for(r=[0:360/arms:359])
          rotate([0,0,r])
            arm(td);
      else {
        arm(td);
        if(arms%2==1)
          rotate([0,0,180]) arm(td);
        if(arms>2)
          rotate([0,0,90]) arm(td);
        if(arms>3&&arms%3==0)
          rotate([0,0,270]) arm(td);
      }
    }
    circle(d=td,$fn=30);
  }
}
module arm(td=td) {
  difference() {
    union() {
      *translate([4,(td-.5)*-.5]) square([22,td-.5]);
      *hull()
      {
      translate([26,0]) circle(d=td,$fn=30);
      translate([28,0]) circle(d=td-1,$fn=30);
      }
      for(x=[10:4:32]) translate([x,0]) hull() {
        circle(d=td-((x-10)/5),$fn=30);
        translate([-4,0]) circle(d=td-(x/5)-.5,$fn=30);
      }
    }
    *translate([24,td*-.5-1.75]) circle(d=4,$fn=20);
    *translate([24,td*0.5+1.75]) circle(d=4,$fn=20);
  }
}