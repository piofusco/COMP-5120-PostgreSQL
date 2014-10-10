/*

All tables as shown have been implemented in PostgreSQL
(9.3.4)

Table creation order (17 total tables)
Patients
Diagnosis
Rooms
Workers
Volunteers
Services
VolunteerSchedule
ConsultingDoctors
Staff
Treatment
Nurses
Technicians
AdministeredTreatment
OrderedTreatment
AdminDoctors
AdmittedPatients
DiagnosticHistory


*/

DROP TABLE Patients CASCADE;
DROP TABLE Diagnosis CASCADE;
DROP TABLE Rooms CASCADE;
DROP TABLE Workers CASCADE;
DROP TABLE Volunteers CASCADE;
DROP TABLE Services CASCADE;
DROP TABLE VolunteerSchedule CASCADE;
DROP TABLE ConsultingDoctors CASCADE;
DROP TABLE Staff CASCADE;
DROP TABLE Treatment CASCADE;
DROP TABLE Nurses CASCADE;
DROP TABLE Technicians CASCADE;
DROP TABLE AdministeredTreatment CASCADE;
DROP TABLE OrderedTreatment CASCADE;
DROP TABLE AdminDoctors CASCADE;
DROP TABLE AdmittedPatients CASCADE;
DROP TABLE DiagnosticHistory CASCADE;

CREATE TABLE Patients( -- consider adding PRIMARY doctor
	pid char(3) NOT NULL,
	roomNum smallint, 
	firstname varchar(20),
	lastname varchar(20),
	insurance varchar(20), 
	contact varchar(20),
	type char(1), -- I, for Inpatient, 0 for Outpatient
	admitted date,
	discharged date,
	PRIMARY KEY (pid)
);
CREATE TABLE Diagnosis(
	diagnosisID char(3), -- consider making this unique
	diagnosis varchar(20),
	PRIMARY KEY (diagnosisID)
);
CREATE TABLE Rooms(
	roomNum smallint NOT NULL,
	pid char(3),
	PRIMARY KEY (roomNum),
	FOREIGN KEY (pid) REFERENCES Patients(pid)
);
CREATE TABLE Workers (
	workerid char(3) NOT NULL, -- consider making this unique
	lastname varchar(20), 
	firstname varchar(20),
	doh date,
	category varchar(20),
	PRIMARY KEY (workerid)
);
CREATE TABLE Volunteers(
	workerid char(3),
	lastname varchar(20), 
	firstname varchar(20),
	doh date,
	PRIMARY KEY (workerid),
	FOREIGN KEY (workerid) REFERENCES Workers(workerid)
);
CREATE TABLE Services(
	serviceid char(3) NOT NULL, -- consider making this unique
	description varchar(20),
	PRIMARY KEY (serviceid)
);
CREATE TABLE VolunteerSchedule(
	workerid char(3),
	serviceid char(3),
	schedule char(5), --MTWRF, add this to assumptions
	PRIMARY KEY(workerid, serviceid),
	FOREIGN KEY(workerid) REFERENCES Volunteers(workerid), 
	FOREIGN KEY(serviceid) REFERENCES Services(serviceid) 
);
CREATE TABLE ConsultingDoctors(
	workerid char(3),
	lastname varchar(20),
	firstname varchar(20),
	doh date,
	PRIMARY KEY (workerid),
	FOREIGN KEY (workerid) REFERENCES Workers(workerid)
);
CREATE TABLE Staff (
	workerid char(3),
	lastname varchar(20), 
	firstname varchar(20),
	doh date,
	area varchar(20),
	PRIMARY KEY (workerid),
	FOREIGN KEY (workerid) REFERENCES Workers(workerid)
);
CREATE TABLE Treatment(
	tid char(3), -- consider making this unique
	description varchar(20),
	type char(1), -- either Inpatient or Outpatient
	PRIMARY KEY (tid)
);
CREATE TABLE Nurses(
	workerid char(3),
	lastname varchar(20), 
	firstname varchar(20),
	doh date,
	PRIMARY KEY (workerid),
	FOREIGN KEY (workerid) REFERENCES Workers(workerid)
);
CREATE TABLE Technicians(
	workerid char(3),
	lastname varchar(20), 
	firstname varchar(20),
	doh date,
	PRIMARY KEY (workerid),
	FOREIGN KEY (workerid) REFERENCES Workers(workerid)
);
CREATE TABLE AdminDoctors(
	workerid char(3),
	lastname varchar(20), 
	firstname varchar(20),
	doh date,
	PRIMARY KEY (workerid),
	FOREIGN KEY (workerid) REFERENCES ConsultingDoctors(workerid)
);
CREATE TABLE AdministeredTreatment(
	orderid char(3),
	tid char(3),
	pid char(3),
	workerid char(3),
	type char(1),
	time date, -- default CURRENT_DATE,
	PRIMARY KEY (tid, workerid, pid),
	FOREIGN KEY (tid) REFERENCES Treatment(tid),
	FOREIGN KEY (workerid) REFERENCES Workers(workerid),
	FOREIGN KEY (pid) REFERENCES Patients(pid)
);
CREATE TABLE OrderedTreatment(
	orderid char(3) UNIQUE,
	tid char(3),
	pid char(3),
	workerid char(3),
	timeapplied date,
	PRIMARY KEY (tid, workerid, pid),
	FOREIGN KEY (tid) REFERENCES Treatment(tid),
	FOREIGN KEY (workerid) REFERENCES ConsultingDoctors(workerid),
	FOREIGN KEY (pid) REFERENCES Patients(pid)
);
CREATE TABLE AdmittedPatients(
	pid char(3),
	workerid char(3),
	admitted date, 
	discharged date,
	PRIMARY KEY (pid, workerid, admitted),
	FOREIGN KEY (pid) REFERENCES Patients(pid),
	FOREIGN KEY (workerid) REFERENCES AdminDoctors(workerid)
);
CREATE TABLE DiagnosticHistory( -- assuming patient can't come in with the same diagnosis twice
	diagnosisID char(3),
	workerid char(3),
	pid char(3),
	admitted date,
	PRIMARY KEY (diagnosisID, workerid, pid),
	FOREIGN KEY (workerid) REFERENCES AdminDoctors(workerid),
	FOREIGN KEY (pid) REFERENCES Patients(pid),
	FOREIGN KEY (diagnosisID) REFERENCES Diagnosis(diagnosisID)
);

/* INSERT statements */

INSERT INTO Patients VALUES
(000, 100, 'Eric', 'Kitaif', 'Geico', 'Momma Kitaif', 'I', '2014/7/10', '2014/7/15'),
(001, 101, 'Justin', 'Brewer', 'Progressive', 'Dad Brewer', 'I', '2014/7/12', '2014/7/13'),
(002, 102, 'Devan', 'Buggay', 'Direct General', 'Shane Buggay', 'I', '2014/7/1', NULL),
(003, 103, 'Zach', 'White', 'Buttplug Health', 'Walter White', 'I', '2014/7/15', NULL),
(004, 104, 'Pam', 'Zirkle', 'Deathsurance', 'Martha Zirkle',  'I', '2014/7/19', '2014/7/25'),
(005, NULL, 'Mina', 'Edgar', 'GTFO LTD', 'Jesus Christ', 'O', NULL, NULL),
(006, NULL, 'Stan', 'Marsh', 'SP Insurance', 'Randy Marsh', 'O', NULL, NULL),
(007, NULL, 'Eric', 'Cartman', 'SP Insurance', 'Liane Cartman', 'O', NULL, NULL),
(008, NULL, 'Kyle', 'Broflovski', 'SP Insurance', 'Gerald Broflovski', 'O', NULL, NULL),
(009, NULL, 'Kenny', 'McCormick', 'SP Insurance', 'Carol McCormick', 'O', NULL, NULL)
;

INSERT INTO Diagnosis VALUES 
('AAA', 'Common Cold'),
('AAB', 'Cancer'),
('AAC', 'Tumor'),
('AAD', 'Lupis'),
('AAE', 'Jaundice'),
('AAF', 'Influenza'),
('AAG', 'Rabies'),
('AAH', 'Pregnant'),
('AAI', 'HIV-AIDs'),
('AAJ', 'Broken Limb'),
('AAK', 'Hepititus-C')
;

INSERT INTO Rooms VALUES
(100, 0),
(101, 1),
(102, 2),
(103, 3),
(104, 4),
(105, NULL),
(106, NULL),
(107, NULL),
(108, NULL),
(109, NULL)
;

INSERT INTO Workers VALUES
('000', 'House', 'Gregory', '4/4/04', 'Admin Doctor'),
('001', 'Cuddy', 'Lisa', '4/4/04', 'Admin Doctor'),
('002', 'Wilson', 'James', '4/4/04', 'Admin Doctor'),
('003', 'Bailey', 'Miranda', '4/4/04', 'Admin Doctor'),
('004', 'Sheppard', 'Derek', '4/4/04', 'Admin Doctor'),

('005', 'Chase', 'Robert', '4/4/04', 'Consulting Doctor'),
('006', 'Foreman', 'Eric', '4/4/04', 'Consulting Doctor'),
('007', 'Cameron', 'Allison', '4/4/04', 'Consulting Doctor'),
('008', 'Grey', 'Meredith', '4/4/04', 'Consulting Doctor'),
('009', 'OMalley', 'George', '4/4/04', 'Consulting Doctor'),

('010', 'Schrute', 'Dwight', '4/4/04', 'Staff'),
('011', 'Love', 'Kevin', '4/4/04', 'Staff'),
('012', 'James', 'Lebron', '4/4/04', 'Staff'),
('013', 'Jordan', 'Michael', '4/4/04', 'Staff'),
('014', 'Bird', 'Larry', '4/4/04', 'Staff'),

('015', 'Pooh', 'Winnie', '4/4/04', 'Volunteer'),
('016', 'Rabbit', 'Peter', '4/4/04', 'Volunteer'),
('017', 'Tig', 'Tigger', '4/4/04', 'Volunteer'),
('018', 'Jackson', 'Sean', '4/4/04', 'Volunteer'),
('019', 'Lepin', 'Philis', '4/4/04', 'Volunteer'),

('020', 'White', 'Betty', '4/4/04', 'Nurse'),
('021', 'Steincampf', 'Chris', '4/4/04', 'Nurse'),
('022', 'Pace', 'Megan', '4/4/04', 'Nurse'),
('023', 'Anderson', 'Pam', '4/4/04', 'Nurse'),
('024', 'Meth', 'Cynthia', '4/4/04', 'Nurse'),

('025', 'Mario', 'Super', '4/4/04', 'Technician'),
('026', 'Luigi', 'Mario', '4/4/04', 'Technician'),
('027', 'Stool', 'Toad', '4/4/04', 'Technician'),
('028', 'Peach', 'Princess', '4/4/04', 'Technician'),
('029', 'Bowser', 'King', '4/4/04', 'Technician')
;

INSERT INTO Volunteers VALUES
('015', 'Pooh', 'Winnie', '4/4/04'),
('016', 'Rabbit', 'Peter', '4/4/04'),
('017', 'Tig', 'Tigger', '4/4/04'),
('018', 'Jackson', 'Sean', '4/4/04'),
('019', 'Lepin', 'Philis', '4/4/04')
;

INSERT INTO Services VALUES
('0', 'Gift Shop'),
('1', 'Info Desk'),
('2', 'Snack Cart'),
('3', 'Reading Cart')
;

INSERT INTO VolunteerSchedule VALUES
('015', '0', 'MXWXF'),
('016', '0', 'XTXRX'),
('017', '1', 'MXWXF'),
('018', '1', 'XTXRX'),
('019', '2', 'XTXRX'),
('019', '3', 'MXWXF')
;

INSERT INTO ConsultingDoctors VALUES
('000', 'House', 'Gregory', '4/4/04'),
('001', 'Cuddy', 'Lisa', '4/4/04'),
('002', 'Wilson', 'James', '4/4/04'),
('003', 'Bailey', 'Miranda', '4/4/04'),
('004', 'Sheppard', 'Derek', '4/4/04'),
('005', 'Chase', 'Robert', '4/4/04'),
('006', 'Foreman', 'Eric', '4/4/04'),
('007', 'Cameron', 'Allison', '4/4/04'),
('008', 'Grey', 'Meredith', '4/4/04'),
('009', 'OMalley', 'George', '4/4/04')
;

INSERT INTO Staff VALUES
('010', 'Schrute', 'Dwight', '4/4/04', NULL),
('011', 'Love', 'Kevin', '4/4/04', NULL),
('012', 'James', 'Lebron', '4/4/04', NULL),
('013', 'Jordan', 'Michael', '4/4/04', NULL),
('014', 'Bird', 'Larry', '4/4/04', NULL)
;

INSERT INTO Treatment VALUES
('000', 'Abortion', 'I'),
('001', 'Surgery', 'I'),
('002', 'Boob job', 'I'),
('003', 'Biopsy', 'I'),
('004', 'Transplant', 'I'),
('005', 'IV fluid', 'I'),
('006', 'Chemotheropy', 'I'),
('007', 'X-Ray', 'I'),
('008', 'MRI', 'I'),
('009', 'Heart Miopothy', 'I'),

('100', 'Medication', 'O'),
('101', 'Physical Therapy', 'O'),
('102', 'Massage', 'O'),
('103', 'Acupunture', 'O'),
('104', 'Insulin', 'O'),
('105', 'Drug Test', 'O'),
('106', 'Crutch', 'O'),
('107', 'Rehabilitation', 'O'),
('108', 'Pregnancy Test', 'O'),
('109', 'Blood Test', 'O')
;

INSERT INTO Nurses VALUES
('020', 'White', 'Betty', '4/4/04'),
('021', 'Steincampf', 'Chris', '4/4/04'),
('022', 'Pace', 'Megan', '4/4/04'),
('023', 'Anderson', 'Pam', '4/4/04'),
('024', 'Meth', 'Cynthia', '4/4/04')
;

INSERT INTO Technicians VALUES
('025', 'Mario', 'Super', '4/4/04'),
('026', 'Luigi', 'Mario', '4/4/04'),
('027', 'Stool', 'Toad', '4/4/04'),
('028', 'Peach', 'Princess', '4/4/04'),
('029', 'Bowser', 'King', '4/4/04')
;

INSERT INTO AdminDoctors VALUES
('000', 'House', 'Gregory', '4/4/04'),
('001', 'Cuddy', 'Lisa', '4/4/04'),
('002', 'Wilson', 'James', '4/4/04'),
('003', 'Bailey', 'Miranda', '4/4/04'),
('004', 'Sheppard', 'Derek', '4/4/04')
;

INSERT INTO AdministeredTreatment VALUES -- list multiple nurses/doctors/technicians within this table
('555', '000', '0', '000', 'I', '2014-07-12'),
('555', '000', '0', '020', 'I', '2014-07-12'),
('555', '000', '0', '025', 'I', '2014-07-12'),
('556', '005', '0', '000', 'I', '2014-07-13'),
('556', '005', '0', '025', 'I', '2014-07-13'),

('557', '001', '1', '001', 'I', '2014-07-12'),
('557', '001', '1', '021', 'I', '2014-07-12'),
('557', '001', '1', '026', 'I', '2014-07-12'),
('558', '002', '1', '001', 'I', '2014-07-12'),
('558', '002', '1', '021', 'I', '2014-07-12'),
('558', '002', '1', '025', 'I', '2014-07-12'),

('559', '003', '2', '002', 'I', '2014-07-02'),
('560', '005', '2', '000', 'I', '2014-07-15'),
('560', '005', '2', '020', 'I', '2014-07-15'),
('561', '006', '2', '002', 'I', '2014-07-17'),
('561', '006', '2', '027', 'I', '2014-07-17'),
('562', '009', '2', '002', 'I', '2014-07-25'),

('563', '004', '3', '003', 'I', '2014-07-16'),
('563', '004', '3', '024', 'I', '2014-07-16'),
('563', '004', '3', '028', 'I', '2014-07-16'),
('564', '003', '3', '003', 'I', '2014-08-01'),

('565', '004', '4', '004', 'I', '2014-07-20'),
('565', '004', '4', '020', 'I', '2014-07-20'),
('565', '004', '4', '025', 'I', '2014-07-21'),
('566', '007', '4', '004', 'I', '2014-07-24'),

('720', '100', '5', '005', 'O', NULL),
('720', '100', '5', '020', 'O', NULL), -- assuming time isn't recorded for outpatient care
('720', '100', '5', '025', 'O', NULL), -- outpatient services start with 7
('721', '105', '5', '005', 'O', NULL),
('721', '105', '5', '025', 'O', NULL),

('722', '101', '6', '006', 'O', NULL),
('722', '101', '6', '021', 'O', NULL),
('722', '101', '6', '026', 'O', NULL),
('723', '102', '6', '006', 'O', NULL),
('723', '102', '6', '021', 'O', NULL),
('723', '102', '6', '025', 'O', NULL),

('724', '103', '7', '007', 'O', NULL),
('725', '105', '7', '007', 'O', NULL),
('725', '105', '7', '020', 'O', NULL),
('726', '106', '7', '020', 'O', NULL),
('726', '106', '7', '027', 'O', NULL),
('727', '109', '7', '007', 'O', NULL),

('728', '104', '8', '024', 'O', NULL),
('728', '104', '8', '028', 'O', NULL),
('728', '104', '8', '008', 'O', NULL),
('729', '103', '8', '008', 'O', NULL),

('730', '104', '9', '009', 'O', NULL),
('730', '104', '9', '020', 'O', NULL),
('730', '104', '9', '025', 'O', NULL),
('731', '107', '9', '009', 'O', NULL)
;

INSERT INTO OrderedTreatment VALUES
('555', '000', '0', '000', '2014-07-12'),
('556', '005', '0', '000', '2014-07-13'),

('557', '001', '1', '001', '2014-07-12'),
('558', '002', '1', '001', '2014-07-12'),

('559', '003', '2', '002', '2014-07-02'),
('560', '005', '2', '002', '2014-07-15'),
('561', '006', '2', '002', '2014-07-17'),
('562', '009', '2', '002', '2014-07-25'),

('563', '004', '3', '003', '2014-07-16'),
('564', '003', '3', '003', '2014-08-01'),

('565', '004', '4', '004', '2014-07-20'),
('566', '007', '4', '004', '2014-07-24'),

('720', '100', '5', '005', NULL),
('721', '105', '5', '005', NULL),

('722', '101', '6', '006', NULL),
('723', '102', '6', '006', NULL),

('724', '103', '7', '007', NULL),
('725', '105', '7', '007', NULL),
('726', '106', '7', '007', NULL),
('727', '109', '7', '007', NULL),

('728', '104', '8', '008', NULL),
('729', '103', '8', '008', NULL),

('730', '104', '9', '009', NULL),
('731', '107', '9', '009', NULL)
;

INSERT INTO AdmittedPatients VALUES -- list multiple did to account for multiple hospital visits
('0', '000', '2013/9/18', '2013/9/19'),
('0', '000', '2013/11/5', '2013/11/7'),
('0', '000', '2013/12/9', '2013/12/15'),
('0', '000', '2014/1/13', '2014/1/15'),
('0', '000', '2014/6/1', '2014/6/2'),
('0', '000', '2014/7/5', '2014/7/6'),
('0', '000', '2014/7/10', '2014/7/15'),

('1', '001', '2013/2/21', '2013/2/22'),
('1', '001', '2013/3/25', '2013/3/27'),
('1', '001', '2013/9/9', '2013/9/17'),
('1', '001', '2013/2/12', '2013/2/19'),
('1', '001', '2014/2/27', '2014/2/28'),
('1', '001', '2014/4/13', '2014/4/16'),
('1', '001', '2014/7/1', '2014/7/3'),
('1', '001', '2014/7/12', '2014/7/13'),

('2', '002', '2012/12/1', '2013/1/1'),
('2', '002', '2013/4/7', '2013/4/19'),
('2', '002', '2013/8/3', '2013/8/4'),
('2', '002', '2013/11/28', '2013/12/1'),
('2', '002', '2014/2/1', '2014/2/1'),
('2', '002', '2014/3/14', '2014/3/15'),
('2', '002', '2014/6/3', '2014/6/7'),
('2', '002', '2014/7/1', NULL),

('3', '003', '2012/2/11', '2012/2/13'),
('3', '003', '2012/3/17', '2012/3/19'),
('3', '003', '2012/3/24', '2012/3/25'),
('3', '003', '2013/9/4', '2013/9/6'),
('3', '003', '2013/11/25', '2013/11/26'),
('3', '003', '2013/12/17', '2013/12/19'),
('3', '003', '2013/12/20', '2013/12/21'),
('3', '003', '2013/12/23', '2013/12/24'),
('3', '003', '2014/7/15', NULL),

('4', '004', '2011/3/19', '2011/3/22'),
('4', '004', '2012/3/2', '2012/3/5'),
('4', '004', '2013/4/7', '2013/4/10'),
('4', '004', '2014/3/2', '2014/4/5'),
('4', '004', '2014/7/2', '2014/7/5'),
('4', '004', '2014/7/19', '2014/7/25')
;

INSERT INTO DiagnosticHistory VALUES
('AAA','000','0', '2014/7/10'),
('AAA','000','1', '2014/7/12'),
('AAA','001','2', '2014/7/01'),
('AAA','002','3', '2014/7/15'),
('AAA','003','4', '2014/7/19'),
('AAA','004','5', NULL),
('AAA','004','6', NULL),

('AAB','002','7', NULL),

('AAC','000','8', NULL),
('AAC','002','9', NULL),
('AAC','004','2', '2014/7/05'),
('AAC','004','3', '2014/7/16'),

('AAD','000','4', '2014/7/20'),
('AAD','000','5', NULL),
('AAD','000','6', NULL),

('AAE','002','7', NULL),
('AAE','003','8', NULL),
('AAE','003','9', NULL),

('AAF','004','0', '2014/7/11'),
('AAF','001','1', '2014/7/13'),
('AAF','002','2', '2014/7/07'),

('AAG','003','3', '2014/7/19'),
('AAG','002','4', '2014/7/21'),
('AAG','004','5', NULL),

('AAH','004','6', NULL),
('AAH','000','7', NULL),
('AAH','001','8', NULL),

('AAI','002','9', NULL),
('AAI','003','0', '2014/7/12'),
('AAI','003','1', '2014/7/13'),
('AAI','003','2', '2014/7/11'),

('AAJ','001','3', '2014/7/21'),
('AAJ','001','4', '2014/7/22'),
('AAJ','004','5', NULL),

('AAK','001','6', NULL),
('AAK','002','7', NULL),
('AAK','002','8', NULL),
('AAK','003','9', NULL)
;




/* Queries

A. Room Utilization
1. List the rooms that are occupied, along with the associated patient names and the date the patient was admitted.
select rooms.roomnum, lastname, firstname, admitted
from rooms
join patients using (pid);
2. List the rooms that are currently unoccupied.
select roomnum from rooms
where pid is NULL;
3. List all rooms in the hospital along with patient names and admission dates for those that are occupied.
select rooms.roomnum, lastname, firstname, admitted
from rooms
left outer join patients using (pid);

B. Patient Information
1. List all patients in the database, with full personal information.
select * from patients;
2. List all patients currently admitted to the hospital (i.e., those who are currently receiving inpatient services). List only patient identification number and name.
select pid, lastname, first from patients
where discharged is NULL;
9. List patients who were admitted to the hospital within 30 days of their last discharge date. For each patient list their patient identification number, name, diagnosis, and admitting doctor.
SELECT A.pid as "Patient ID", P.lastname as "Patient", D.diagnosis as "Diagnosis"--,  C.lastname as "Admitting Doctor"
FROM  patients P
join diagnostichistory DH using (pid)
join diagnosis D using (diagnosisID)
INNER JOIN  admittedpatients A 
  on P.pID = A.pID
WHERE a.discharged+ interval '30 day' >=p.admitted
and p.admitted >=a.discharged
and DH.admitted = p.admitted;
C. Diagnosis and Treatment Information
1. List the diagnoses given to admitted patients, in descending order of occurrences. List diagnosis identification number, name, and total occurrences of each diagnosis.
select diagnosisID, diagnosis, count(*)
from diagnosis
join diagnostichistory using (diagnosisid)
group by diagnosisid, diagnosis;
5. List the Treatment performed on admitted patients, in descending order of occurrences. List treatment identification number, name, and total number of occurrences of each treatment.
select tid, description, count(*)
from administeredtreatment
join Treatment using (tid)
group by tid, description
order by count(*) desc;
8. For a given treatment occurrence, list all the hospital employees that were involved. Also include the patient name and the doctor who ordered the treatment.
select treatment.description as "Treatment", workers.category as "Position", workers.lastname as "Apply by (includes Doctor who ordered)", patients.lastname as "Patient"
from administeredtreatment
join treatment using (tid)
join workers using (workerid)
join patients using (pid)
where orderid = '555'; -- change orderid to treatment occurrence
D. Employee Information
1. List all workers at the hospital, in ascending last name, first name order. For each worker, list their identification number, name, job category, and date of hire.
select workerid, lastname, firstname, category, doh 
from workers
order by lastname asc;

3. List the primary doctors of patients with a high admission rate (at least 4 admissions within a one-year time frame).

select distinct lastname, firstname from admittedpatients
join consultingdoctors using (workerid)
where admitted > now() - interval '1 year'
group by lastname, firstname
having count(*) >= 4;

5. For a given doctor, list all Treatment that they ordered in descending order of occurrence. For each treatment, list the total number of occurrences for the given doctor.
select description
from OrderedTreatment
join Treatment using (tid)
where workerid = '0' -- change this to doctor's workerid
group by description
order by count(*) desc;

select tid, description, count(*) from Treatment
left outer join OrderedTreatment using (tid)
where pid = '0' -- change this to doctor's workerid
group by tid, description;
*/