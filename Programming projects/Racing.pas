uses GraphABC, ABCObjects;

var
  i, n, x1, x2, x3, x4, dx1, dx2, dx3, dx4, koef: integer;

var
  snow, car1, car2, man: PictureABC;first, ended: string;a,s: array of integer;k: boolean;name:array of string;

procedure Road();
begin
  SetWindowSize(1200, 900);
  SetBrushColor(clGray);
  Rectangle(300, 0, 1200, 600);
  SetPenWidth(6);
  SetPenColor(clYellow);
  Line(300, 150, 1200, 150);
  Line(300, 300, 1200, 300);
  Line(300, 450, 1200, 450);
  SetPenColor(clWhite);
  SetPenWidth(12);
  Line(1030, 0, 1030, 600);
end;

procedure Sprites();
begin
  snow := PictureABC.Create(305, 20, 'snow.png');
  snow.FlipHorizontal;
  snow.Height := 120;
  snow.Width := 150;
  car1 := PictureABC.Create(305, 60, 'car1.png');
  car1.Height := 350;
  car1.Width := 150;
  car2 := PictureABC.Create(305, 200, 'car2.png');
  car2.Height := 370;
  car2.Width := 150;
  man := PictureABC.Create(305, 470, 'man.png');
  man.Height := 120;
  man.Width := 150;
end;

procedure Riding(x1, x2, x3, x4, dx1, dx2, dx3, dx4: integer; k: boolean);
begin
  while (x1 < 1050) and (x2 < 1050) and (x3 < 1050) and (x4 < 1050) do
  begin
    dx1 := Random(0, 30);
    snow.MoveOn(dx1, 0);
    x1 := x1 + dx1;
    sleep(50);
    if (x1 > 1030) and (k = false) then 
    begin
      k := true;
      if k = true then first := 'Снеговик';
    end;
    dx2 := Random(0, 30);
    car1.MoveOn(dx2, 0);
    x2 := x2 + dx2;
    sleep(50);
    if (x2 > 1030) and (k = false) then 
    begin
      k := true;
      if k = true then first := 'Гоночный автомобиль';
    end;
    dx3 := Random(0, 30);
    car2.MoveOn(dx3, 0);
    x3 := x3 + dx3;
    sleep(50);
    if (x3 > 1030) and (k = false) then 
    begin
      k := true;
      if k = true then first := 'Полицейский автомобиль';
    end;
    dx4 := Random(0, 30);
    man.MoveOn(dx4, 0);
    x4 := x4 + dx4;
    sleep(50);
    if (x4 > 1030) and (k = false) then
    begin
      k := true;
      if k = true then first := 'Мужик в шляпе';
    end;
  end;
end;

begin
  ended := 'Y';
  SetBrushColor(clWhite);
  SetFontSize(15);
  Writeln('Введите количество игроков');
  Readln(n);
  Writeln('Количество игроков: ', n);
  SetLength(a, n + 1);
  for i := 1 to n do
    begin
      a[i] := 500;
    end;
    for i := 1 to n do
    begin
      Writeln('Количество денег ', i, ' игрока: ', a[i]);
    end;
  while ended <> 'N' do
  begin
    koef:=2;
    x1 := 305;
    x2 := 305;
    x3 := 305;
    x4 := 305;
    dx1 := 0; dx2 := 0; dx3 := 0; dx4 := 0;
    k := false;
    Road();
    Sprites();
    SetBrushColor(clWhite);
    SetFontSize(15);
    SetLength(s,n+1);
    SetLength(name,5);
    for i := 1 to n do
    begin
      Writeln('Игрок ', i, '.На кого ставите?');
      Writeln('(1/2/3/4)');
      Readln(name[i]);
      if name[i]='1' then name[i]:='Снеговик';
      if name[i]='2' then name[i]:='Гоночный автомобиль';
      if name[i]='3' then name[i]:='Полицейский автомобиль';
      if name[i]='4' then name[i]:='Мужик в шляпе';
      Writeln('Ваша ставка?');
      Readln(s[i]);
      a[i] := a[i] - s[i];
    end;
    Writeln('Ставки приняты.Приятной игры');
    sleep(1000);
    for i := 1 to n do
    begin
      Writeln('Количество денег ', i, ' игрока: ', a[i]);
    end;
    sleep(1000);
    Riding(x1, x2, x3, x4, dx1, dx2, dx3, dx4, k);
    Writeln('Гонку выиграл ', first);
    for i:=1 to n do
    begin
      if first=name[i] then begin s[i]:=s[i]*koef; a[i]:=s[i]+a[i]; end
      else s[i]:=0;
    end;
    for i := 1 to n do
    begin
      Writeln('Количество денег ', i, ' игрока: ', a[i]);
    end;
    Writeln('Желаете продолжить?(Y/N)');
    Readln(ended);
    if ended = 'Y' then begin snow.Destroy; car1.Destroy; car2.Destroy; man.Destroy; end;
    for i:=1 to n do
    begin
      if a[i]<1 then begin ended:='N';Writeln('У одного из игроков нет денег на ставки');Writeln('Начните новую игру!'); break; end;
    end;
  end;
end.