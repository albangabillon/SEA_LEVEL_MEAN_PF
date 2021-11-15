# SEA_LEVEL_MEAN_PF
## Database schema for hourly SEA LEVEL data computed from TIDE STATIONS in South Pacific Ocean from 2009-06-13 to 2021-01-28

This postgresql code is relative to the database titled "HOURLY SEA LEVEL collected from TIDE STATIONS in South Pacific Ocean from 2009-06-13 to 2021-01-28", hosted by the National Oceanic and Oceanographic (NOAA), National Centers for Environmental Information (NCEI, https://www.ncei.noaa.gov/) under Reference ???.

The Database was created under the PostgreSQL database management.

## Schema
The database schema consists of a single table. Each row of the table is a measure of the height of a tide. 
Regarding this table schema, we can make the following comments:
-	ID is an automatically generated integer that is incremented when rows are inserted into the database. It is just an identifier with no semantics.  We declared ID as the primary key of the table.
-	STATION identifies the station from which the measurement was made. 
-	SENSOR identifies the sensor which was used for the measurement. Possible sensor values are RADAR, PRESSURE and FLOAT. Only RADAR values are currently listed in the database.
-	TIME_UTC is the timestamp of the measurement accurate to the minute after correction
-	DATA is averaged hourly mean sea level
- 	RESIDUES is the difference between DATA and an output of a theoretical model 

We also declared 5 domain constraints enumerating the possible values for attributes SENSOR, FLAG1, FLAG2, FLAG3 and FLAG4.

Finally, we declared the constituent {STATION, SENSOR, FLAG1, CORRECT_TIME_UTC} as a candidate key of the table meaning that for a given station, a given sensor and a given data origin, CORRECT_TIME_UTC is unique.

## Functions about Julian Time
### JulianTime(t)
We found out useful to write a function computing the Julian time corresponding to a given timestamp (whether it is a RAW_TIME_UTC timestamp or a CORRECT_TIME_UTC timestamp). 
We wrote function JulianTime(t) in PL/pgSQL (Procedural Language/PostgreSQL). JulianTime(t) extends the native postgreSQL function `to_char(t,'J')` which computes the Julian day from timestamp t. JulianTime(t) is a stored function meaning it is compiled and stored in the database. It can be used in any SQL query:

`SELECT julianTime(TIME_UTC) FROM HMEASURES WHERE ID=2;`

### Min1900(t)
We also wrote a function expressing the Julian time in terms of minutes only.  
This function can also be invoked in any SQL query:

`SELECT Min1900(TIME_UTC) FROM HMEASURES WHERE ID=2;`

**Nota Bene**: the reference time for the computation of Julian time (in days) is January 1, 1900 noon UTC, with a Julian time value of 2415021.0