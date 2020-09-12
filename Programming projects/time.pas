uses GraphABC,ABCObjects;
var hour,min,sec,x0,y0,x,y:integer; p:pictureABC;
begin
  var t:=DateTime.Now;
  hour:=t.Hour;
  min:=t.Minute;
  sec:=t.Second;
  SetWindowSize(250,250);
  x0:=122;
  y0:=120;
  repeat
    p:=PictureABC.Create(10,10,'1.png'); 
    sec:=sec+1;
    if(sec=60) then
    begin 
      min:=min+sec div 60;
      sec:=0;
    end;
    x:=x0+Round(100*sin(Pi*sec/30));
    y:=y0-Round(100*cos(Pi*sec/30));
    SetPenWidth(3);Line(x0,y0,x,y);
    x:=x0+Round(80*sin(Pi*min/30));
    y:=y0-Round(80*cos(Pi*min/30));
    SetPenWidth(5);Line(x0,y0,x,y);
    x:=x0+Round(60*sin(Pi*hour/6));
    y:=y0-Round(60*cos(Pi*hour/6));
    SetPenWidth(7);Line(x0,y0,x,y);
    sleep(1000);
  until hour>=24 ;
end.
