create or replace function Min1900(t TIMESTAMP)
   returns FLOAT 
   language plpgsql
  as
$$
declare 
   num_mn INTEGER;
begin
   num_mn = round(((JulianTime(t) - 2415021)*1440));
   RETURN num_mn;
end;
$$
