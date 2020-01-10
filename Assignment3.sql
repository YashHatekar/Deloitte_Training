create table Medicine (
medId number(3),
medName varchar(30))

create table Prescription(
prescId number(3),
prescDate date,
patientId number(3),
medicines varchar(30),
medId number(3))

create table Patient(
patientId number(3),
patientName varchar(30),
patientEmail varchar(30),
prescriptionId number(3))

alter table Patient
add constraint pk_patientId primary key(patientId)

alter table Prescription
add constraint pk_prescId primary key(prescId)

alter table Medicine
add constraint pk_medId primary key(medId)

alter table Patient
add constraint fk_prescId foreign key(prescriptionId) references Prescription(prescId)

alter table Prescription
add constraint fk_medId foreign key(medId) references Medicine(medId)