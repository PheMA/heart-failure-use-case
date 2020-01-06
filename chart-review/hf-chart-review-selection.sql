------------------------------------------------------------------------------------------------
-- The following variables will need to be set by each validation site.
------------------------------------------------------------------------------------------------
-- @cohort_id - the OHDSI cohort ID created
DECLARE @cohort_id INT = <OHDSI cohort ID>

------------------------------------------------------------------------------------------------
-- The following variables need to be consistent across all validation sites.
------------------------------------------------------------------------------------------------
-- @num_cases_reviewed - the number of potential cases (as selected within the OHDSI cohort)
--                       that will be reviewed.
DECLARE @num_cases_reviewed INT = 25
-- @num_non_cases_reviewed - the number of high-risk non-cases (those that have the qualifying
--							 data elements, but did not show up in the cohort) that will be
--                           reviewed.
DECLARE @num_controls_reviewed INT = 25


-- Randomly select potential cases (those in the specified cohort)
SELECT TOP (@num_cases_reviewed) 'Case' AS [Status], SUBJECT_ID AS person_id
  FROM [OHDSI].[ohdsi].[cohort]
  WHERE COHORT_DEFINITION_ID = @cohort_id
  ORDER BY NEWID();

-- Select the (potential) controls - which we are considering for now as non-cases.
-- We want anyone who may have been a case - having dx and procedure entries - but did not
-- get picked up within our cohort.  This will allow us to target the most likely places
-- where an error in our logic would have occurred.
with dx_concepts as (
	select concept_id from cdm.concept where concept_id in (44833557,44823110,44831230,44819692,44819693,44819695,44820856,44819696,44824235,44824250,44827794,44834732,44820869,44831248,44833573,44831249,44824251,44835943,44835944,44833574,44827795,44820870,44823119,44827796,4267800,314378,4206009,4004279,4023479,4103448,319835,4184497,4185565,4195785,444101,444031,442310,4327205,315295,316994,316139,439846,4229440,4236658,4242669,4009047,439698,439696,439694,4111554,4108244,4108245,4071869,4124705,4199500,4259490,443580,443587,4311437,4139864,4142561,40479192,40479576,40480602,40480603,40481042,40481043,43020657,44784442,45766164,45766165,45766166,45766167,45773075,36713488,44782728,44782713,43021825,43021826,44784345,44782428,43021840,43020421,43530642,43021841,43021842,43530643,44782718,44782719,44782733,36712927,36712928,36717359,36712929,35615055,35207669,35207673,35207674,35207792,45586587,45543182,45576878,45567180,45601038,45548022,45533456,45562355,45533457,45591469,45586588,45567181,1326605,1326606,1326607,1326608,1326609,35207793)
),
echo_concepts as (
    select concept_id from cdm.CONCEPT where concept_id in (2313867,2313868,2313869,2313870,2313871,2313872,2313873,2313874,2313875,2313876,2313877,2313878,2313879,2313880,2313881,2313882,2313883,2313884,46257454)and invalid_reason is null
)
select top (@num_controls_reviewed) 'Non-Case' AS [Status], person_id from (
	select distinct person_id
	from cdm.procedure_occurrence po
	join echo_concepts on echo_concepts.concept_id = po.procedure_concept_id
	where po.person_id in (
		select person_id from (
			select distinct co.person_id
			from cdm.condition_occurrence co
			join dx_concepts on dx_concepts.concept_id = co.condition_concept_id
		) t1
	)
	AND NOT EXISTS (
		SELECT 1 FROM [ohdsi].[cohort] c 
		WHERE COHORT_DEFINITION_ID = @cohort_id
			AND c.SUBJECT_ID = po.person_id
	)
) AS controls
ORDER BY NEWID()