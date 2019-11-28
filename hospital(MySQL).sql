CREATE TABLE Employee (
  ssn INTEGER PRIMARY KEY,
  name VARCHAR (50),
  surname VARCHAR (50),
  phone VARCHAR(20),
  specialization VARCHAR (50),
  salary INTEGER,
  type VARCHAR (15)
);

CREATE TABLE Room (
  id INTEGER PRIMARY KEY,
  type VARCHAR (20),
  quantity_of_beds INTEGER NOT NULL
);

CREATE TABLE Patient (
  ssn INTEGER PRIMARY KEY NOT NULL,
  name VARCHAR (50) NOT NULL,
  surname VARCHAR (50)  NOT NULL,
  gender VARCHAR (25)  NOT NULL,
  weight INTEGER,
  birth_date DATE,
  height INTEGER,
  blood_type VARCHAR(20),
  phone VARCHAR(20),
  country VARCHAR(50),
  city VARCHAR(50),
  street VARCHAR(50),
  building VARCHAR(20),
  room_id INTEGER REFERENCES Room(id)
);


CREATE TABLE Log (
  id INTEGER PRIMARY KEY NOT NULL,
  name VARCHAR (50) NOT NULL,
  description VARCHAR (50) NOT NULL,
  time TIMESTAMP NOT NULL
);

CREATE TABLE Inventory_item (
  id INTEGER PRIMARY KEY  NOT NULL,
  name VARCHAR(50) NOT NULL,
  quantity INTEGER  NOT NULL,
  type VARCHAR (50)  NOT NULL,
  supplier VARCHAR (50)  NOT NULL,
  cost INTEGER NOT NULL
);

CREATE TABLE Analysis_result (
  id INTEGER NOT NULL,
  patient_ssn INTEGER  NOT NULL,
  type VARCHAR(50)  NOT NULL,
  result VARCHAR(2000)  NOT NULL,
  date DATE  NOT NULL,
  PRIMARY KEY(id, patient_ssn)
);

CREATE TABLE Treatment_plan (
  id INTEGER PRIMARY KEY,
  doctor_ssn INTEGER,
  FOREIGN KEY (doctor_ssn) REFERENCES Employee(ssn),
  patient_ssn INTEGER,
  FOREIGN KEY (patient_ssn) REFERENCES Patient(ssn),
  discharge_date DATE,
  hospitalization_date DATE
);

CREATE TABLE Attends (
  employee_ssn INTEGER,
  FOREIGN KEY (employee_ssn) REFERENCES Employee(ssn),
  patient_ssn INTEGER,
  FOREIGN KEY (patient_ssn) REFERENCES Patient(ssn),
  cost INTEGER,
  description VARCHAR(500),
  date TIMESTAMP,
  PRIMARY KEY(date, employee_ssn, patient_ssn)
);


CREATE TABLE Prescribe (
  employee_ssn INTEGER,
  FOREIGN KEY (employee_ssn) REFERENCES Employee(ssn),
  patient_ssn INTEGER,
  FOREIGN KEY (patient_ssn) REFERENCES Patient(ssn),
  description VARCHAR(500),
  date TIMESTAMP,
  PRIMARY KEY(date, employee_ssn, patient_ssn)
);




CREATE TABLE Chat (
  message_id VARCHAR(50) NOT NULL,
  time TIMESTAMP NOT NULL,
  employee_ssn INTEGER,
  FOREIGN KEY (employee_ssn) REFERENCES Employee(ssn),
  patient_ssn INTEGER,
  FOREIGN KEY (patient_ssn) REFERENCES Patient(ssn),
  text VARCHAR(500),
  PRIMARY KEY(message_id, employee_ssn, patient_ssn)
);


CREATE TABLE Uses (
  inventory_id INTEGER,
  treatment_id INTEGER,
  FOREIGN KEY (inventory_id) REFERENCES Inventory_item(id),
  FOREIGN KEY (treatment_id) REFERENCES Treatment_plan(id),
  PRIMARY KEY(inventory_id, treatment_id)
);

CREATE TABLE Treatment_diagnoses (
  treatment_id INTEGER NOT NULL,
  diagnoses_id INTEGER NOT NULL,
  PRIMARY KEY (treatment_id, diagnoses_id)
);

CREATE TABLE Diagnoses (
  id INTEGER NOT NULL,
  description VARCHAR (50) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Treatment_procedures (
  treatment_id INTEGER NOT NULL,
  procedures_id INTEGER NOT NULL,
  PRIMARY KEY (treatment_id, procedures_id)
);

CREATE TABLE Procedures (
  id INTEGER NOT NULL,
  description VARCHAR (50) NOT NULL,
  PRIMARY KEY (id)
);



INSERT INTO Room (id, type, quantity_of_beds) VALUES
(0, 'intensive care', 8),
(1, 'consulting room', 5),
(2, 'consulting room', 7),
(3, 'nursery', 7),
(4, 'seek room', 6);

 INSERT INTO Patient (ssn, name, surname, gender, weight, birth_date, height, blood_type, phone, country, city, street, building, room_id) VALUES
(101, 'Kenneth', 'Mor', 'female', 62, '1964-08-18', 140, 'A-', '+767400950526', 'Egypt', 'Hebron', 'Clement Road', 9, 1),
(102, 'Leonid', 'Howard', 'male', 57, '1984-04-17', 148, 'B+', '+977566939757', 'Russia', 'Longview', 'Thorpe Celyn', 10, 3),
(103, 'Leonid', 'Howard', 'female', 89, '1969-02-27', 119, 'B-', '+353048398650', 'Russia', 'Kalauao', 'Fletcher Boulevard', 9, 4),
(104, 'Magomed', 'Howard', 'male', 83, '2002-07-07', 200, 'O+', '+726861002864', 'Germany', 'Emerson', 'Wallis Fairway', 5, 4);

 INSERT INTO Employee (ssn, name, surname, phone, specialization, salary, type) VALUES
 (1, 'Luiz', 'Lorinson', '+795029436347', 'General practice‎', 56000, 'doctor'),
(2, 'Ivan', 'Richardson', '+383787721835', 'Gynaecology‎', 43000, 'doctor'),
(3, 'Ivan', 'Lorinson', '+683433229068', 'Mens health‎', 36000, 'doctor'),
(4, 'Luiz', 'Wilson', '+286732637266', 'Pediatrics‎', 26000, 'doctor');

 INSERT INTO Employee (ssn, name, surname, phone, specialization, salary, type) VALUES
 (5, 'Luke', 'Lorinson', '+717400536206', 'Nurse attorney', 32000, 'nurse'),
(6, 'Luke', 'Richardson', '+296147688608', 'Neurosurgical nursing', 35000, 'nurse'),
(7, 'Jeffrey', 'Magomedov', '+323696981271', 'Maternal-child nursing', 55000, 'nurse'),
(8, 'Ivan', 'Wilson', '+447470774678', 'Infectious disease nursing', 50000, 'nurse'),
(9, 'Munir', 'Richardson', '+824703535237', 'Medical-surgical nursing', 34000, 'nurse');

 INSERT INTO Prescribe (employee_ssn, patient_ssn, description, date) VALUES
 (4, 102, 'Doctor attends patient', '2018-05-06'),
(2, 102, 'Doctor attends patient', '2015-07-02'),
(2, 104, 'Doctor attends patient', '2016-01-09');

 INSERT INTO Analysis_result (id, patient_ssn, type, result, date) VALUES
 (0, 104, 'lumbar puncture', 'Medical result', '2019-02-18'),
(1, 101, 'Pap smear', 'Medical result', '2017-12-20'),
(2, 103, 'lumbar puncture', 'Medical result', '2015-10-05'),
(3, 104, 'kidney function test', 'Medical result', '2018-04-06'),
(4, 101, 'Pap smear', 'Medical result', '2017-12-05');

 INSERT INTO Attends (employee_ssn, patient_ssn, cost, description, date) VALUES
 (3, 103, 37644, 'Attend description', '2019-08-04 10:49:15'),
(2, 104, 40718, 'Attend description', '2013-11-21 07:43:52'),
(4, 103, 37451, 'Attend description', '2016-09-03 09:53:25'),
(1, 104, 13073, 'Attend description', '2009-02-12 11:58:13'),
(4, 104, 9147, 'Attend description', '2009-07-05 19:53:24'),
(3, 104, 18399, 'Attend description', '2018-05-17 22:30:05'),
(2, 101, 2750, 'Attend description', '2009-04-03 05:40:26'),
(2, 101, 17015, 'Attend description', '2019-05-20 21:54:18'),
(3, 101, 43531, 'Attend description', '2016-12-04 17:16:38'),
(3, 103, 7682, 'Attend description', '2014-07-16 04:41:35');

 INSERT INTO Chat (message_id, time, employee_ssn, patient_ssn, text) VALUES
 ('lvjoghtcmlopnkrdzkqfjnlhmzuebgjhoquftzufmjxddavkpq', '2016-01-03 12:18:45', 4, 103, 'Random message'),
('clbgojihwhxkyuxhtgducdkyoizhptbjebxmbbqnrobievulrc', '2017-02-15 09:42:53', 1, 103, 'Random message'),
('wxokayorapxexqictgcjggjokkhzsgvulkylqyoamyvhvzfswf', '2017-01-04 16:33:46', 4, 103, 'Random message');

 INSERT INTO Inventory_item (id, name, quantity, type, supplier, cost) VALUES
(0, 'Amlodipine', 2, 'medicine', 'Pozen Inc.', 18500),
(1, 'Alendronate', 10, 'medicine', 'Pharmacyclics', 13500),
(2, 'Acyclovir', 7, 'medicine', 'Portola Pharmaceuticals, Inc.', 10000);

 INSERT INTO Diagnoses VALUES
(0, 'Hypertension'),
(1, 'Flu'),
(2, 'Chronic stress'),
(3, 'Potassium deficiency'),
(4, 'Muscular dystrophy'),
(5, 'Chronic muscle cramp'),
(6, 'Fibromyalgia'),
(7, 'Necrotizing Fasciitis'),
(8, 'Skin Cancer'),
(9, 'Angina');

INSERT INTO Procedures VALUES
(0, 'Diuretics'),
(1, 'Strict Diet'),
(2, 'AnticoagulantsAngina'),
(3, 'Nitroglycerin'),
(4, 'Brain Aneurysm'),
(5, 'Clot Busters'),
(6, 'Pulmonary Rehabilitation'),
(7, 'Antiviral drugs'),
(8, 'Emphysema'),
(9, 'Anxiolytics'),
(10, 'Dementia'),
(11, 'Extended Sick Leave'),
(12, 'Anticonvulsants'),
(13, 'Major Depression'),
(14, 'Hemiparesis'),
(15, 'Potassium Supplements'),
(16, 'Physiotherapy'),
(17, 'Corticosteroids'),
(18, 'Asprin'),
(19, 'Antidepressants'),
(20, 'Antibiotics'),
(21, 'Amputation'),
(22, 'Chemotherapy'),
(23, 'Excisional Therapy');

INSERT INTO Treatment_plan VALUES
(1, 3, 102, '2018-12-04', '2018-11-20'),
(0, 2, 104, '2016-06-14', '2016-05-31'),
(2, 1, 101, '2018-09-01', '2018-08-18');

INSERT INTO Treatment_diagnoses  VALUES
(1, 8),
(0, 8),
(2, 8);

INSERT INTO Treatment_procedures VALUES
(1, 23),
(0, 22),
(2, 23);

 INSERT INTO Uses (inventory_id, treatment_id) VALUES
 (1, 2),
(0, 1),
(2, 0);
 INSERT INTO Log (id, name, description, time) VALUES
(0, 'log_0', 'initialization', '2018-09-15 15:39:20'),
(1, 'log_1', 'initialization', '2016-11-11 13:55:52'),
(2, 'log_2', 'initialization', '2015-11-18 05:01:36');