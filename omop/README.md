# OMOP Data

The [data](data) folder contains a PostgreSQL dump of data for 1000 patients from the
[SynPUF](https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/DE_Syn_PUF)
dataset. The data is in the [OMOP CDM v5.3.1](https://github.com/OHDSI/CommonDataModel/releases/tag/v5.3.1) format, and the
vocabulary tables are not included.

### Dataset Summary

```
ohdsi=> select count(*) from person;
 count
-------
  1000
(1 row)

ohdsi=> select count(*) from visit_occurrence;
 count
-------
 55261
(1 row)

ohdsi=> select count(*) from condition_occurrence;
 count
--------
 147186
(1 row)

ohdsi=> select count(*) from procedure_occurrence;
 count
--------
 137522
(1 row)
```