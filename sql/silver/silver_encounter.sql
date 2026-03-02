
CREATE OR REPLACE TABLE silver.stg_encounters AS
SELECT
    --Primary Key
    id AS encounter_id,

    --Foreign Keys
    patient AS patient_id,
    organization AS organization_id,
    payer AS payer_id,

    -- Date & Time (ISO -> Standard datetiem format)
    CAST(start AS timestamp) AS encounter_start,
    CAST(stop AS TIMESTAMP) AS encounter_stop,

    --Encounter details
    LOWER(TRIM(encounterclass)) AS encounter_class,
    code AS encounter_code,
    TRIM(LOWER(description)) AS encounter_description,

    -- Financial Metrics
    CAST(base_encounter_cost AS DOUBLE) AS base_encounter_cost,
    CAST(total_claim_cost AS DOUBLE) AS total_claim_cost,
    CAST(payer_coverage AS DOUBLE) AS payer_coverage,

    --Diagnosis
    reasoncode AS reason_code,
    LOWER(TRIM(reasondescription)) AS reason_description,

    --Derived
    DATEDIFF(
             'minute',
             CAST(start AS timestamp),
             CAST(stop AS timestamp)) AS encounter_duration_minutes,
    
    --Patient
    ROUND(CAST(total_claim_cost AS DOUBLE)
      - CAST(payer_coverage AS DOUBLE),2) AS patient_out_of_pocket

FROM 
    bronze.encounters
