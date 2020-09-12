// Работа с множествами
// Базовый тип для множества может быть произвольным
var 
  s1: set of string := ['Иванов','Попов','Сидорова','Петров'];
  s2: set of string := ['Козлов','Петров','Иванов'];
begin
  writeln('Множество s1: ',s1);
  writeln('Множество s2: ',s2);
  writeln('Объединение множеств s1 и s2: ',s1+s2);
  writeln('Пересечение множеств s1 и s2: ',s1*s2);
  writeln('Разность множеств s1 и s2: ',s1-s2);
  Include(s1,'Умнов');
  Exclude(s1,'Иванов');
  writeln('Множество s1: ',s1);
end.  