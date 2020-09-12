uses GraphABC, ABCObjects,  System.Media;


var
  Deck1, Deck2, cards, Deckcard: PictureABC;balance, bet, card1, c1, sum1, sum2, i, f: integer;
  button1, button2, rules: RoundRectABC; continied: char; checkrules: RectangleABC;

procedure CreatePlayground(var balance: integer; bet: integer);
begin
  SetWindowSize(1000, 600);
  SetBrushColor(clMidnightBlue);
  Rectangle(0, 0, 1000, 600);
  button1 := new RoundRectABC(800, 250, 150, 50, 5, clOrange);
  button2 := new RoundRectABC(800, 320, 150, 50, 5, clTomato);
  rules := new RoundRectABC(30, 560, 200, 25, 5, clGold);
  button1.BorderWidth := 2;
  button2.BorderWidth := 2;
  rules.BorderWidth := 2;
  button1.FontStyle := fsbold;
  button2.FontStyle := fsbold;
  rules.FontStyle := fsbold;
  button1.FontName := 'Times';
  button1.Text := 'Ещё';
  button2.FontName := 'Times';
  button2.Text := 'Стоп';
  rules.FontName := 'Times';
  rules.Text := 'Правила игры';
  Deck1 := PictureABC.Create(90, 100, 'deck.png');
  Deck1.Width := 100;
  Deck1.Height := 150;
  Deck2 := PictureABC.Create(90, 390, 'deckplayer.png');
  Deck2.Width := 100;
  Deck2.Height := 150;
  cards := PictureABC.Create(570, -50, 'cards.png');
  cards.Width := 600;
  Cards.Height := 400;
  Deckcard := PictureABC.Create(810, 430, 'DeckCard.jpg');
  Deckcard.Width := 130;
  Deckcard.Height := 150;
  SetPenColor(clSilver);
  SetPenWidth(5);
  Line(250, 10, 250, 590);
  Line(750, 10, 750, 590);
  Line(250, 300, 750, 300);
  Line(248, 12, 752, 12);
  Line(248, 588, 752, 588);
  var x := 270;
  Brush.NETBrush := nil;
  SetPenColor(clSilver);
  Rectangle(90, 100, 190, 250);
  Rectangle(90, 390, 190, 540);
  for var i := 1 to 4 do
  begin
    Rectangle(x, 100, x + 100, 250);
    Rectangle(x, 390, x + 100, 540);
    x := x + 120;
  end;
  SetPenWidth(4);
  SetPenColor(clYellow);
  Line(252, 60, 748, 60);
  Line(252, 350, 748, 350);
  SetFontSize(20);
  SetFontColor(clYellow);
  SetFontStyle(fsBoldItalic);
  Font.Name := 'Times';
  TextOut(280, 25, 'Дилер');
  TextOut(280, 315, 'Вы');
  TextOut(10, 10, 'Ваш баланс:');
  TextOut(10, 40, balance.ToString);
  TextOut(10, 270, 'Ваша ставка:');
  TextOut(10, 300, bet.ToString);
end;

procedure MouseDown(x, y, j: integer);
begin
  if (j = 1) and (button1.PtInside(x, y) = true) then
  begin
    var p := RectangleABC.Create(330, 250, 350, 140, clOrange);
    p.BorderWidth := 3;
    p.FontStyle := fsbold;
    p.FontName := 'Times';
    p.Text := 'Введите 1';
    sleep(1000);
    p.Destroy;
  end;
  if (j = 1) and (button2.PtInside(x, y) = true) then
  begin
    var p := RectangleABC.Create(330, 250, 350, 140, clTomato);
    p.BorderWidth := 3;
    p.FontStyle := fsbold;
    p.FontName := 'Times';
    p.Text := 'Введите 2';
    sleep(1000);
    p.Destroy;
  end;
  if (j = 1) and (rules.PtInside(x, y) = true) then
  begin
    checkrules := RectangleABC.Create(330, 120, 350, 400, clGold);
    checkrules.BorderWidth := 3;
    checkrules.FontStyle := fsbold;
    checkrules.FontName := 'Times';
    checkrules.Text := '';
  end;
end;

procedure MouseUp(x, y, j: integer);
begin
  if (j = 1) and (rules.PtInside(x, y) = true)  then checkrules.Destroy;
end;

begin
  try
    var FPlayer := new SoundPlayer();
    FPlayer.SoundLocation := 'music.wav';
    FPlayer.PlayLooping();
  except
  end;
  SetWindowTitle('Игра 21'); 
  balance := 500;
  OnMouseUp := MouseUp;
  OnMouseDown := MouseDown;
  ClearWindow();
  CreatePlayground(balance, bet);
  while continied <> 'N' do
  begin
    i := 0;
    sum1 := 0;
    sum2 := 0;
    repeat
      var d := RectangleABC.Create(330, 250, 350, 140, clLime);
      d.BorderWidth := 3;
      d.FontStyle := fsbold;
      d.FontName := 'Times';
      d.Text := 'Введите ставку';
      Readln(bet); 
      d.Destroy;
      if (bet > balance) or (bet < 1) then
      begin
        var p := RectangleABC.Create(330, 250, 350, 140, clAquamarine);
        p.BorderWidth := 3;
        p.FontStyle := fsbold;
        p.FontName := 'Times';
        p.Text := 'Недопустимая ставка';
        sleep(2000);
        p.Destroy;
      end
      else begin balance := balance - bet; break; end;
    until (bet < balance) and (bet > 0);
    var x := 270;
    while  i <> 4 do
    begin
      card1 := random(4) + 1;
      c1 := random(9) + 1;
      SetPenWidth(2);
      SetPenColor(clblack);
      Rectangle(x, 390, x + 100, 540);
      FloodFill(x + 5, 395, clWhite);
      if card1 = 1 then 
      begin
        setpencolor(clblack);
        setfontcolor(clblack);
        Brush.NETBrush := nil;
        SetFontSize(30);
        textout(x + 40, 445, '   ♣');
      end;
      if card1 = 2 then 
      begin
        setpencolor(clred);
        setfontcolor(clred);
        Brush.NETBrush := nil;
        SetFontSize(30);
        textout(x + 40, 445, '   ♥');
      end;
      if card1 = 3 then
      begin
        setpencolor(clblack);
        setfontcolor(clblack);
        Brush.NETBrush := nil;
        SetFontSize(30);
        textout(x + 40, 445, '   ♠');
      end;
      if card1 = 4 then 
      begin
        setpencolor(clred);
        setfontcolor(clred);
        Brush.NETBrush := nil;
        SetFontSize(30);
        textout(x + 40, 445, '   ♦');
      end;
      if c1 = 1 then begin textout(x + 20, 445, '6'); sum2 += 6; end;
      if c1 = 2 then begin textout(x + 20, 445, '7'); sum2 += 7; end;
      if c1 = 3 then begin textout(x + 20, 445, '8'); sum2 += 8; end;
      if c1 = 4 then begin textout(x + 20, 445, '9'); sum2 += 9; end;
      if c1 = 5 then begin textout(x + 20, 445, '10'); sum2 += 10; end;
      if c1 = 6 then begin textout(x + 20, 445, 'J'); sum2 += 2; end;
      if c1 = 7 then begin textout(x + 20, 445, 'Q'); sum2 += 3; end;
      if c1 = 8 then begin textout(x + 20, 445, 'K'); sum2 += 4; end;
      if c1 = 9  then begin textout(x + 20, 445, 'A'); sum2 += 11; end;
      x := x + 120;
      if i = 3 then begin i += 1; break; end;
      Readln(f);
      if f = 1 then i += 1
      else if f = 2 then i := 4
      else i := 4;
    end;
    i := 0;
    x := 270;
    for var j := 1 to random(1, 4) do
    begin
      card1 := random(4) + 1;
      c1 := random(9) + 1;
      SetPenWidth(2);
      SetPenColor(clblack);
      Rectangle(x, 100, x + 100, 250);
      FloodFill(x + 5, 105, clWhite);
      Brush.NETBrush := nil;
      SetFontSize(30);
      if card1 = 1 then 
      begin
        setpencolor(clblack);
        setfontcolor(clblack);
        Brush.NETBrush := nil;
        SetFontSize(30);
        textout(x + 40, 155, '   ♣');
      end;
      if card1 = 2 then 
      begin
        setpencolor(clred);
        setfontcolor(clred);
        Brush.NETBrush := nil;
        SetFontSize(30);
        textout(x + 40, 155, '   ♥');
      end;
      if card1 = 3 then
      begin
        setpencolor(clblack);
        setfontcolor(clblack);
        Brush.NETBrush := nil;
        SetFontSize(30);
        textout(x + 40, 155, '   ♠');
      end;
      if card1 = 4 then 
      begin
        setpencolor(clred);
        setfontcolor(clred);
        Brush.NETBrush := nil;
        SetFontSize(30);
        textout(x + 40, 155, '   ♦');
      end;
      if c1 = 1 then begin textout(x + 20, 155, '6'); sum1 += 6; end;
      if c1 = 2 then begin textout(x + 20, 155, '7'); sum1 += 7; end;
      if c1 = 3 then begin textout(x + 20, 155, '8'); sum1 += 8; end;
      if c1 = 4 then begin textout(x + 20, 155, '9'); sum1 += 9; end;
      if c1 = 5 then begin textout(x + 20, 155, '10'); sum1 += 10; end;
      if c1 = 6 then begin textout(x + 20, 155, 'J'); sum1 += 2; end;
      if c1 = 7 then begin textout(x + 20, 155, 'Q'); sum1 += 3; end;
      if c1 = 8 then begin textout(x + 20, 155, 'K'); sum1 += 4; end;
      if c1 = 9  then begin textout(x + 20, 155, 'A'); sum1 += 11; end;
      x := x + 120;
      sleep(1000);
    end;
    if (sum2 < 21) and (sum2 > sum1) or (sum1 > 21) then
    begin
      balance := balance + bet * 2;
      bet := 0;
      var p := RectangleABC.Create(330, 250, 350, 140, clAquamarine);
      p.BorderWidth := 3;
      p.FontStyle := fsbold;
      p.FontName := 'Times';
      p.Text := 'Вы выиграли!';
      sleep(2000);
      p.Destroy;
    end
    else
    begin
      bet := 0;
      var p := RectangleABC.Create(330, 250, 350, 140, clAquamarine);
      p.BorderWidth := 3;
      p.FontStyle := fsbold;
      p.FontName := 'Times';
      p.Text := 'Вы проиграли!';
      sleep(2000);
      p.Destroy;
    end;
    if (balance < 1) then
    begin
      var p := RectangleABC.Create(330, 250, 350, 140, clAquamarine);
      p.BorderWidth := 3;
      p.FontStyle := fsbold;
      p.FontName := 'Times';
      p.Text := 'Конец игры!';
      break;
    end;
    ClearWindow();
    CreatePlayground(balance, bet);
    var p := RectangleABC.Create(330, 250, 350, 140, clAquamarine);
    p.BorderWidth := 3;
    p.FontStyle := fsbold;
    p.FontName := 'Times';
    p.Text := 'Желаете продолжить? (Y/N)';
    Readln(continied);
    p.Destroy;
    if (continied = 'N') then
    begin
      var c := RectangleABC.Create(330, 250, 350, 140, clAquamarine);
      c.BorderWidth := 3;
      c.FontStyle := fsbold;
      c.FontName := 'Times';
      c.Text := 'Конец игры!';
      break;
    end;
  end;
  
end.