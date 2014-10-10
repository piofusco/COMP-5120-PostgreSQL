This project was made with Postgres 9.3.4 in the Summer of 2014 for COMP 5120. Here is the project description:

A new hospital is being constructed to service the needs of a rapidly growing retirement community. Your team has been contracted to develop the database system that will manage the primary care operation of the hospital, but not the financial operation. The database system must have an easy to use interface that supports all the data entry and information gathering needs of the hospital.
Basic rules and operational procedures are described below.

• The hospital is staffed by many types of workers. Some are volunteers, while others are employees of the hospital. Employees include doctors, nurses, technicians, staff, and administrators.

• Hospital volunteers provide the following services for a few days each week: gift shop, information desk, snack carts, reading carts.

• Hospital staff work in non-medical areas of the hospital such as the cafeteria, gift shop, janitorial services, etc.

• All doctors who work for the hospital have consulting privileges, which allow them to be assigned to patients, order treatments for patients, and use the hospital facilities. Some, but not all, doctors also have admitting privileges, which allow them to admit patients to the hospital.

• The hospital provides both inpatient and outpatient services, but no emergency services. Outpatient services must be ordered by a doctor with consulting privileges. Inpatient services require a hospital stay and are thus only available to patients who are admitted to the hospital.

• When a patient is admitted to the hospital by a doctor, he or she is given a unique patient identification number and assigned to a room by an administrative employee. Each patient must provide an emergency contact and insurance policy information at the time of admission.

• The hospital rooms are all private rooms; that is, each room accommodates no more than one patient.

• The doctor who admits a patient is considered that patient’s primary doctor. At the discretion of the primary doctor, multiple doctors on staff can be assigned to a given patient. Any doctor assigned to a patient can order and perform treatments for that patient.

• Treatments include both procedures and medication. All treatments must be ordered by a doctor and administered by an appropriate hospital employee. Treatments may be ordered for patients on either an inpatient or outpatient basis. A timestamp is associated with the order and all administrations.

• Treatments are administered to patients by one or more employees who are either doctors, nurses, or technicians.

• At the time of admission, a patient’s primary doctor provides an initial diagnosis. This diagnosis may change while the patient is receiving inpatient services.

• When an admitted patient’s primary doctor decides that the necessary course of treatment has ended, that patient is discharged from the hospital by an administrative employee.

Required Query Support
Your database system must support the efficient processing of each of the following information requests. 

A. Room Utilization

1. List the rooms that are occupied, along with the associated patient names and the date the patient was admitted.

2. List the rooms that are currently unoccupied.

3. List all rooms in the hospital along with patient names and admission dates for those that are occupied.

B. Patient Information

1. List all patients in the database, with full personal information.

2. List all patients currently admitted to the hospital (i.e., those who are currently receiving inpatient services). List only patient identification number and name.

3. List all patients who were receiving inpatient services within a given date range. List only patient identification number and name.

4. List all patients who were discharged in a given date range. List only patient identification number and name.

5. List all patients who are currently receiving outpatient services. List only patient identification number and name.

6. List all patients who have received outpatient services within a given date range. List only patient identification number and name.

7. For a given patient (either patient identification number or name), list all admissions to the hospital along with the diagnosis for each admission.

8. For a given patient (either patient identification number or name), list all treatments that were administered. Group treatments by admissions. List admissions in descending chronological order, and list treatments in ascending chronological order within each admission.

9. List patients who were admitted to the hospital within 30 days of their last discharge date. For each patient list their patient identification number, name, diagnosis, and admitting doctor.

10. For each patient that has ever been admitted to the hospital, list their total number of admissions, average duration of each admission, longest span between admissions, shortest span between ad- missions, and average span between admissions.

C. Diagnosis and Treatment Information

1. List the diagnoses given to admitted patients, in descending order of occurrences. List diagnosis identification number, name, and total occurrences of each diagnosis.

2. List the diagnoses given to outpatients, in descending order of occurrences. List diagnosis identification number, name, and total occurrences of each diagnosis.

3. List the diagnoses given to hospital patients (both inpatient and outpatient), in descending order of occurrences. List diagnosis identification number, name, and total occurrences of each diagnosis.

4. List the treatments performed at the hospital (to both inpatients and outpatients), in descending order of occurrences. List treatment identification number, name, and total number of occurrences of each treatment.

5. List the treatments performed on admitted patients, in descending order of occurrences. List treatment identification number, name, and total number of occurrences of each treatment.

6. List the treatments performed on outpatients, in descending order of occurrences. List treatment identification number, name, and total number of occurrences of each treatment.

7. List the diagnoses associated with patients who have the highest occurrences of admissions to the hospital, in ascending order or correlation.

8. For a given treatment occurrence, list all the hospital employees that were involved. Also include the patient name and the doctor who ordered the treatment.

D. Employee Information

1. List all workers at the hospital, in ascending last name, first name order. For each worker, list their identification number, name, job category, and date of hire.

2. List the volunteers who work at the information desk on Tuesdays.

3. List the primary doctors of patients with a high admission rate (at least 4 admissions within a one-year time frame).

4. For a given doctor, list all associated diagnoses in descending order of occurrence. For each diagnosis, list the total number of occurrences for the given doctor.

5. For a given doctor, list all treatments that they ordered in descending order of occurrence. For each treatment, list the total number of occurrences for the given doctor.

6. For a given doctor, list all treatments in which they participated, in descending order of occurrence. For each treatment, list the total number of occurrences for the given doctor.

7. List employees who have been involved in the treatment of every admitted patient.

Project Submission
Required project deliverables fall into the three categories below. 

1. Specification of the Conceptual Model

A. Entity-Relationship Model

B. Text annotations of assumptions, constraints, etc.


2. Specification of the Implementation Model

A. Relational schemas

B. Description of how the ER model was translated into the listed schemas 

C. Text description of normalization to BCNF.

D. Text annotations of assumptions, constraints, decisions on 3NF, etc. 

3. Database Implementation

A. CREATE TABLE commands

B. All data and associated INSERT commands

C. Source code for all scripts, programs, web pages, etc.

D. Instructions on accessing and interacting with your project










Instructions

1) Open PostgreSQL

2) Copy contents of "create_table_commands" into console and press enter.

3) Copy contents of "insert_commands" into console and press enter.

4) Required queries can be found in "required_queries".

Provided is an additional 'hospital.sql' file if you wish to take a look at the source code directly.
