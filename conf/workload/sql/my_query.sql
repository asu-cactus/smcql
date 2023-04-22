SELECT  DISTINCT d.location
FROM surveillance d JOIN passenger m ON d.id = m.id 
WHERE m.name like '%Jacob Qualls%' AND m.dob like '%1983-12-16%' AND d.location = 19