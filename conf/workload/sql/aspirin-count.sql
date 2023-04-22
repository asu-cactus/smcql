-- SELECT COUNT(DISTINCT d.patient_id) as rx_cnt
SELECT DISTINCT d.patient_id
FROM surveillance d JOIN passenger m ON d.patient_id = m.patient_id 
WHERE m.medication like '%George Mccurry%' AND m.dosage = '1981-02-09' AND d.dummy = 0