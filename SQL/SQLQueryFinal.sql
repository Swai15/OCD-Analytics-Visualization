--1. Count &  of % F vs M  that have OCD & -- Average Obsession Score by Gender
with data as (
select 
Gender,
count(Patient_ID) as patient_count,
cast(avg(Y_BOCS_Score_Obsessions)as decimal(10,2)) as avg_obs_score
from ocd_patient_dataset
group by Gender
)
select 
sum(case when Gender = 'Female' then patient_count else 0 end) as count_female,
sum(case when Gender = 'Male' then patient_count else 0 end) as count_male,
cast(sum(case when Gender = 'Female' then patient_count else 0 end) * 1.0 / (sum(case when Gender = 'Female' then patient_count else 0 end) + sum(case when Gender = 'Male' then patient_count else 0 end))  * 100 as decimal(10, 2))
as pct_female 
from data


--2. Count of Patients by Ethnicity and their respective Obsession Score by Ethnicities 
select Ethnicity, count(Patient_ID) as patient_count, avg(Y_BOCS_Score_Obsessions) as obs_score
from ocd_patient_dataset
group by Ethnicity
order by 2


--3. Number of people diagnosed with OCD MoM
select
format(OCD_Diagnosis_Date, 'yyyy-MM-01 00:00:00') as month,
count(Patient_ID) patient_count
from ocd_patient_dataset
group by format(OCD_Diagnosis_Date, 'yyyy-MM-01 00:00:00')
order by 1

--4. What's the most common Obsession Type(count) & its respective Average score
select  Obsession_Type, count(Patient_ID) as patient_count, cast(avg(Y_BOCS_Score_Obsessions) as decimal(10,2)) as obs_score
from ocd_patient_dataset
group by Obsession_Type
order by 2

--5. What's the most common compulsion type(count) and its respective Average obsession score
select Compulsion_Type, count(Patient_ID) as patient_count, cast(avg(Y_BOCS_Score_Obsessions) as decimal(10, 2)) as obs_score
from ocd_patient_dataset
group by Compulsion_Type
order by 2