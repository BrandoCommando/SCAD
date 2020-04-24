part="all";
kerf=0.1;
thick=3;
shelves=3;
shelfdepth=60;
shelfheight=40;
totalwidth=200;

bottom=0;

fingerspace=1;
fingerwidth=8;

/* [Hidden] */
b_width=(shelfdepth*shelves)-fingerspace*2;
b_fingers=round_odd(b_width/fingerwidth);
b_fingerwidth=b_width/b_fingers;

l_height=(shelfheight*shelves)-fingerspace*2;
l_fingers=round_odd(l_height/fingerwidth);
l_fingerwidth=l_height/l_fingers;

d_width=shelfdepth-fingerspace*2;
d_fingers=round_odd(d_width/fingerwidth);
d_fingerwidth=d_width/d_fingers;

s_height=shelfheight-fingerspace*2;
s_fingers = round_odd(s_height/fingerwidth);
s_fingerwidth=s_height/s_fingers;

s2_height=(shelfheight+thick)-(fingerspace*2);
s2_fingers = round_odd(s2_height/fingerwidth);
s2_fingerwidth=s2_height/s2_fingers;

  t_width=totalwidth-fingerspace*2;
  t_fingers=round_odd(t_width/fingerwidth);
  t_fingerwidth=t_width/t_fingers;

echo(str("Bottom: ",b_width,":",b_fingers,"@",b_fingerwidth,
  " Left: ",l_height,":",l_fingers,"@",l_fingerwidth,
  " Deep: ",d_width,":",d_fingers,"@",d_fingerwidth,
  " Shelves: ",s_height,":",s_fingers,"@",s_fingerwidth,
  " ",s2_height,":",s2_fingers,"@",s2_fingerwidth));;

if(part=="3d")
{
  for(y=[0,totalwidth-thick]) translate([0,y]) color("blue") rotate([90,0]) linear_extrude(thick) side();
  color("green") translate([thick-kerf*2,-thick]) rotate([0,-90]) linear_extrude(thick) back();
  if(bottom)
    color("purple") translate([0,-thick]) linear_extrude(thick) bottom();
  for(shelf=[1:shelves]) translate([shelfdepth*(shelves-shelf+1),-thick,(shelf-1)*shelfheight]) {
    if(shelf==1)
      color("red") rotate([0,-90]) linear_extrude(thick) front();
    else
      translate([0,0,-thick]) color("yellow") rotate([0,-90]) linear_extrude(thick) front2();
    translate([-shelfdepth,0,shelfheight-thick]) linear_extrude(thick) if(shelf==shelves) { shelftop(); } else { shelftop2(); }
  }
} else {
  if(part=="sides"||part=="all")
  {
    for(m=[0,1]) translate(m?[1+shelfdepth*shelves,shelfheight*(1+shelves)+1]:[]) rotate([0,0,m*180]) side();
  }
  if(part=="bottom"||(bottom&&part=="all"))
    translate([1,shelfheight*(1+shelves)+2]) bottom();
  if(part=="back"||part=="all")
    translate([0,((shelfheight+thick+1)*-1*shelves)]) rotate([0,0,-90]) back();
  if(part=="all"||part=="top1")
    translate([shelfdepth*(shelves)+2,0]) shelftop();
  if(part=="all"||part=="top2")
  {
    for(s=[2:shelves])
      translate([shelfdepth*(shelves+(s-1))+(thick+2)*(s)-3,0]) shelftop2();
  }
  if(part=="all"||part=="front1")
    translate([0,-1]) rotate([0,0,-90]) front();
  if(part=="all"||part=="front2")
  {
    rotate([0,0,-90]) {
      for(shelf=[2:shelves])
      translate([shelfheight*(shelf-1)+max(0,(thick*(shelf-2)))+shelf,0]) front2();
    }
  }
}

module shelftop() {
  difference() {
    square([shelfdepth,totalwidth]);
    mirrory(totalwidth) {
      translate([-.01,-.01]) square([fingerspace+.02,thick-kerf]);
      translate([d_width,-.01]) square([fingerspace+20,thick-kerf]);
      for(dx=[0:d_fingerwidth*2:d_width])
        translate([dx+kerf,-.01]) square([d_fingerwidth-kerf*2+.02,thick-kerf+.01]);
    }
    mirrorx(shelfdepth) {
    translate([-.01,fingerspace])
      for(tx=[t_fingerwidth:t_fingerwidth*2:t_width-t_fingerwidth])
        translate([0,tx+kerf]) square([thick-kerf,t_fingerwidth-kerf*2]);
    }
  }
}
module shelftop2() {
  translate([-thick,0]) difference() {
    square([shelfdepth+thick,totalwidth]);
    mirrory(totalwidth) {
      translate([-.01,-.01]) square([fingerspace+thick+.02,thick-kerf]);
      translate([d_width,-.01]) square([fingerspace+20,thick-kerf]);
      translate([fingerspace+thick,0]) for(dx=[0:d_fingerwidth*2:d_width])
        translate([dx+kerf,-.01]) square([d_fingerwidth-kerf*2+.02,thick-kerf+.01]);
    }
    mirrorx(shelfdepth+thick) {
    translate([-.01,fingerspace])
      for(tx=[t_fingerwidth:t_fingerwidth*2:t_width-t_fingerwidth])
        translate([0,tx+kerf]) square([thick-kerf,t_fingerwidth-kerf*2]);
    }
  }
}
module front()
{

  difference() {
    square([shelfheight,totalwidth]);
    
    mirrory(totalwidth) {
      translate([-.01,-.01]) square([fingerspace+.02,thick-kerf]);
      translate([s_height,-.01]) square([fingerspace+20,thick-kerf]);
      translate([fingerspace,0]) for(sy=[0:s_fingerwidth*2:s_height])
          translate([sy,0]) square([s_fingerwidth-kerf*2,thick-kerf]);
    }
    translate([shelfheight/2,0]) for(m=bottom?[0,1]:[0]) mirror([m,0]) translate([shelfheight/-2,0])
    translate([-.01,fingerspace])
      for(tx=[0:t_fingerwidth*2:t_width])
        translate([0,tx+kerf]) square([thick-kerf,t_fingerwidth-kerf*2]);
  }
}
module front2()
{

  difference() {
    square([shelfheight+thick,totalwidth]);
    
    mirrory(totalwidth) {
      translate([-.01,-.01]) square([fingerspace+.02,thick-kerf]);
      translate([s2_height,-.01]) square([fingerspace+20,thick-kerf]);
      translate([fingerspace,-.01]) for(sy=[0:s2_fingerwidth*2:s2_height])
          translate([sy,0]) square([s2_fingerwidth-kerf*2,thick-kerf]);
    }
    mirrorx(shelfheight+thick)
    translate([-.01,fingerspace])
      for(tx=[0:t_fingerwidth*2:t_width])
        translate([0,tx+kerf]) square([thick-kerf,t_fingerwidth-kerf*2]);
  }
}
module bottom()
{
  t_width=totalwidth-fingerspace*2;
  t_fingers=round_odd(t_width/fingerwidth);
  t_fingerwidth=t_width/t_fingers;
  b_width=(shelfdepth*shelves)-fingerspace*2;
  b_fingers=round_odd(b_width/fingerwidth);
  b_fingerwidth=b_width/b_fingers;
  
  difference() {
    square([shelfdepth*shelves,totalwidth]);
    
    mirrorx(shelves*shelfdepth)
    translate([-.01,fingerspace])
      for(tx=[t_fingerwidth:t_fingerwidth*2:t_width-t_fingerwidth])
        translate([0,tx+kerf]) square([thick-kerf+.02,t_fingerwidth-kerf*2]);
    mirrory(totalwidth) {
    translate([-.01,-.01]) square([fingerspace+.4,thick-kerf]);
    translate([b_width,-.01]) square([fingerspace+20,thick-kerf]);
    translate([fingerspace,0])
      for(bx=[0:b_fingerwidth*2:b_width])
        translate([bx+kerf,-.01]) square([b_fingerwidth-kerf*2,thick-kerf+.02]);
    }
  }
}
module back() {
  
  difference() {
    square([shelves*shelfheight,totalwidth]);
    
    translate([0,totalwidth/2]) for(m=[0,1]) mirror([0,m]) translate([0,totalwidth/-2]) {
      translate([-.01,-.01]) square([fingerspace+.02+kerf,thick-kerf]);
      translate([l_height,-.01]) square([fingerspace+20+kerf,thick-kerf]);
      translate([fingerspace,0]) 
      for(ly=[0:l_fingerwidth*2:l_height])
      translate([ly+kerf,-.01]) square([l_fingerwidth-kerf*2,thick-kerf]);
    }
    
    mirrorxif(shelves*shelfheight,bottom==1)
    translate([-.01,fingerspace])
      for(tx=[0:t_fingerwidth*2:t_width])
        translate([0,tx+kerf]) square([thick-kerf,t_fingerwidth-kerf*2]);
  }
}
module side() {


difference() {
  union() {
    for(shelf=[1:shelves])
      square([shelfdepth*shelf,shelfheight*(shelves-shelf+1)]);
  }
  translate([fingerspace,0]) {
    if(bottom) for(bx=[b_fingerwidth:b_fingerwidth*2:b_width-b_fingerwidth])
      translate([bx+kerf,-.01]) square([b_fingerwidth-kerf*2,thick-kerf]);
    for(shelf=[1:shelves])
    {
      translate([(shelf-1)*shelfdepth,shelfheight*(shelves-shelf+1)-thick+kerf])
      for(dx=[d_fingerwidth:d_fingerwidth*2:d_width-d_fingerwidth])
        translate([dx+kerf,0]) square([d_fingerwidth-kerf*2,thick-kerf+.01]);
    }
  }
  translate([0,fingerspace]) {
    for(ly=[l_fingerwidth:l_fingerwidth*2:l_height-l_fingerwidth])
    translate([-.01,ly+kerf]) square([thick-kerf,l_fingerwidth-kerf*2]);
    for(shelf=[1:shelves])
    {
      translate([shelf*shelfdepth-thick+kerf,(shelfheight*(shelves-shelf))])
      if(shelf==shelves)
      {
        for(sy=[s_fingerwidth:s_fingerwidth*2:s_height-s_fingerwidth])
          translate([-.01,sy]) square([thick-kerf+.02,s_fingerwidth-kerf*2]);
      } else {
        for(sy=[s2_fingerwidth:s2_fingerwidth*2:s2_height-s2_fingerwidth])
          translate([-.01,sy-thick]) square([thick-kerf+.02,s2_fingerwidth-kerf*2]);
      }
    }
  }
  
}
}

module mirrorxif(off,case) {
  translate([off/2,0]) for(m=case?[0,1]:[0]) mirror([m,0]) translate([off/-2,0]) children();
}
module mirrorx(off) {
  translate([off/2,0]) for(m=[0,1]) mirror([m,0]) translate([off/-2,0]) children();
}
module mirrory(off) {
  translate([0,off/2]) for(m=[0,1]) mirror([0,m]) translate([0,off/-2]) children();
}
function round_odd(num,min=3) = max(min,floor(num)-(1-(floor(num)%2)));