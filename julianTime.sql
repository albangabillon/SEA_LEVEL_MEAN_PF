create or replace function JulianTime(t TIMESTAMP)
   returns FLOAT 
   language plpgsql
  as
$$
declare 
   julianDay INTEGER;
   seconds_of_day FLOAT;
   jt FLOAT;
begin
   julianDay = to_char(t, 'J');
   seconds_of_day = extract(epoch FROM t::time);
   jt = julianDay::FLOAT + (seconds_of_day / 86400.00) - 0.5;
   RETURN jt;
end;
$$