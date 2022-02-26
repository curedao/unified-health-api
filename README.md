# The Unified Health API
The Unified Health API is the core module of our health data software infrastructure. The main purpose is to provide a single storage and query solution for the analysis of health data.

- It integrates the most used health data standards into a single reference database
- It fills the gaps of not-standardized health data with own references
- It provides our database design for a standardized health data storage solution
- It includes the validation of incoming data against the references
- It specifies the API to query the aggregated health data

![The Core Architecture](diagrams/core_module_architecture.png)

## Data Validation
In order to ensure a level of quality required by healthcare and clinical trials, data quality and consistency must be ensured. The data validation middleware will validate the data before it is stored in the time-series database.
Validation involves the following steps:
- Ensure values are within allowed ranges for a variable and unit
- Outlier detection
- Strict data type checking for all properties
Invalid Data Handling:
- Data deviating from allowed value ranges will be flagged for review and deletion or correction
- Outliers will be be flagged
- Invalid data types will be ignored and the data ingestion plugin developer will be notified
- Duplicate data for a given timestamp will be ignored and the data ingestion plugin developer will be notified

## Data Storage
The typical storage for data analysis is a value and a timestamp and is called a measurement. This module includes the storage schema and the interacting functions to spin up an agnostic measurements storage solution.

## Data API
The API lets you interact with the normalized data from your applications to get specific, filtered, sorted, grouped data sets for your use case.

## Reference Database
For the purpose of effective data analysis we put all health data references into a single table and call them variables.
The variables are:

- Biomarkers
- Outcomes
- Conditions
- Interventions

The actual content of this pack of references is managed here:

[Online Data Browser](https://data.curedao.org)
Contact m@thinkbynumbers.org if you desire access.

## Reference Data Sources

### [1. Nutritional Supplements](reference-databases/supplements/supplements.md)

### [2. Units of Measurement](reference-databases/units/units.md)

### [3. Medication](reference-databases/medications/medications.md)

### [4. Symptoms and Diseases](reference-databases/diseases/diseases.md)

### [5. Observations, Lab Test Results, and Biomarkers](reference-databases/biomarkers/biomarkers.md)

### 6. Clinical Trials

[AACT](https://aact.ctti-clinicaltrials.org/) is a publicly available relational database that contains all information (protocol and result data elements) about every study registered in ClinicalTrials.gov.

### 7. Medical Codes, Terms, and Synonyms

[The Systematized Nomenclature of Medicine (SNOMED)](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwiP-bmSy8f0AhXxJzQIHZw1DyMQFnoECA4QAQ&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FSystematized_Nomenclature_of_Medicine&usg=AOvVaw0OEA6yHcGONHJwDX9OrbKc)  is a systematic collection of medical codes, terms, synonyms and definitions which cover 
- anatomy
- diseases
- findings
- procedures
- microorganisms
- substances
- etc.

**SnoMed Databases**
- [SnomedRfsMySql.zip](https://s3.amazonaws.com/static.quantimo.do/unified-health-api/reference-databases/SnomedRfsMySql.zip)
- [snomed-release-service-4.4.0.zip](https://s3.amazonaws.com/static.quantimo.do/unified-health-api/reference-databases/snomed-release-service-4.4.0.zip)

## Data Schema

### Wearables
- [Open mHealth](https://www.openmhealth.org/documentation/#/schema-docs/schema-library) - common schemas define the meaningful distinctions for each clinical measure
- [Apple HealthKit](https://github.com/openmhealth/schemas/tree/develop/schema/granola) - a set of schemas for the Apple HealthKit platform

### Electronic Health Records (EHR)
- [FHIR](https://www.hl7.org/fhir/) - a standard for electronic health records
- [openEHR](https://www.openehr.org/) - openEHR is a technology for e-health consisting of open platform specifications, clinical models and software that together define a domain-driven information systems platform for healthcare and medical research.

## Repository Notes

### [1. Democratic Pull Requests](voting.md)

### 2. Git Large File Storage
This repository requires that you install the [Git Large File Storage plugin](https://git-lfs.github.com/) to store large files in Git.
