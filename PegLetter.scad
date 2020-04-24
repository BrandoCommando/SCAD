font="";
font_size=24;
peg_letter("ABCDEF");
translate([0,32]) peg_letter("GHIJKL");
translate([0,62]) peg_letter("MNOPR.");
translate([0,92]) peg_letter("STUVY");
translate([0,124]) peg_letter("@,#-+&");
*translate([20,0]) peg_letter("I");
module peg_letter(text) {
  for(pos=[0:len(text)-1])
    translate([pos*24,0]) {
      letter=text[len(text)-pos-1];
      linear_extrude(2.6) {
        offset(0.5,$fn=10)
        mirror([1,0]) text(letter,$fn=50,font=font,size=font_size,halign="center");
      }
      peg_nub(letter);
    }
}
module peg_nub(letter) {
  if(letter=="A")
    for(x=[-9,9]) translate([x,0]) nub(3.2);
  else if(letter=="X"||letter=="R"||letter=="N")
    for(x=[-8,8]) translate([x,0]) nub(3.2);
  else if(letter=="W"||letter=="H")
    for(x=[-7.5,7.5]) translate([x,0]) nub(3.2);
  else if(letter=="P")
    translate([7,0]) nub(3.2);
  else if(letter=="M")
    for(x=[-9.75,9.75]) translate([x,0]) nub(3.2);
  else if(letter=="K")
    for(x=[-8,6.75]) translate([x,0]) nub(3.2);
  else if(letter=="I")
    nub(3.2,-1.6);
  else if(letter=="F")
    translate([6,0]) nub(3.2);
  else if(letter=="4")
    translate([-3.5,0]) nub(3.2);
  else if(letter=="7")
    translate([1.5,0]) nub(3.2);
  else if(letter=="."||letter==",")
    nub(3.2,-1.75);
  else if(letter=="-")
    translate([0.25,7.5]) nub(3.2);
  else if(letter=="+")
    translate([0.25,9.75]) nub(3.2);
  else if(letter=="@")
    translate([2,2]) nub();
  else if(letter=="#")
    translate([2,6.45]) nub();
  else
    nub();
}
module nub(w=4,xo=-2)
{
  translate([xo,0.3]) linear_extrude(6.5) {
    translate([0.8,0]) square([w-1.6,1.6]);
    for(x=[0.8,w-0.8]) translate([x,0.8]) circle(r=0.8,$fn=12);
  }
}