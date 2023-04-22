-- SELECT COUNT(DISTINCT d.patient_id) as rx_cnt
SELECT DISTINCT d.patient_id
FROM surveillance d JOIN passenger m ON d.patient_id = m.patient_id 
WHERE lower(m.medication) like '%aspirin%' AND m.dosage = '10 mg' AND d.visit_no = 1 