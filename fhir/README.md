# FHIR Data

The [data](data) folder contains FHIR Bundle resources with data for 1000
patients from the
[SynPUF](https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/DE_Syn_PUF)
dataset. The resources were built using [OMOP on FHIR](http://omoponfhir.org/)
running on top of the OMOP database in the [synpuf](../synpuf) directory. The
resources are in JSON format and conform to FHIR version
[STU3](http://hl7.org/fhir/STU3/valueset.html).

The [terminology](terminology) directory contains two `CodeSystem` and
`ValueSet` resources representing the value sets used in the heart failure
phenotype.

### Dataset Summary

```sh
$ curl http://local.psbrandt.io:9876/hapi-fhir-jpaserver/fhir/Patient\?_summary=count
```

```json
{
  "resourceType": "Bundle",
  "id": "7bf79047-1a3c-4a62-a111-e60f436a0a77",
  "meta": {
    "lastUpdated": "2020-01-06T03:59:44.043+00:00",
    "tag": [
      {
        "system": "http://hl7.org/fhir/v3/ObservationValue",
        "code": "SUBSETTED",
        "display": "Resource encoded in summary mode"
      }
    ]
  },
  "total": 1000
}
```
                                                                                                                            
```sh
$ curl http://local.psbrandt.io:9876/hapi-fhir-jpaserver/fhir/Encounter\?_summary=count
```

```json
{
  "resourceType": "Bundle",
  "id": "a977b0ea-850d-43ea-a012-d85f9be01023",
  "meta": {
    "lastUpdated": "2020-01-06T03:59:25.365+00:00",
    "tag": [
      {
        "system": "http://hl7.org/fhir/v3/ObservationValue",
        "code": "SUBSETTED",
        "display": "Resource encoded in summary mode"
      }
    ]
  },
  "total": 55261
}
```

```sh
$ curl http://local.psbrandt.io:9876/hapi-fhir-jpaserver/fhir/Condition\?_summary=count
```

```json
{
  "resourceType": "Bundle",
  "id": "df8643a4-882d-4b93-9d33-1da168a62318",
  "meta": {
    "lastUpdated": "2020-01-06T04:00:11.032+00:00",
    "tag": [
      {
        "system": "http://hl7.org/fhir/v3/ObservationValue",
        "code": "SUBSETTED",
        "display": "Resource encoded in summary mode"
      }
    ]
  },
  "total": 147186
}
```

```sh
$ curl http://local.psbrandt.io:9876/hapi-fhir-jpaserver/fhir/Procedure\?_summary=count
```

```json
{
  "resourceType": "Bundle",
  "id": "71891aec-6f08-418d-9c97-dfa645ebaf06",
  "meta": {
    "lastUpdated": "2020-01-06T04:00:21.328+00:00",
    "tag": [
      {
        "system": "http://hl7.org/fhir/v3/ObservationValue",
        "code": "SUBSETTED",
        "display": "Resource encoded in summary mode"
      }
    ]
  },
  "total": 137522
}
```