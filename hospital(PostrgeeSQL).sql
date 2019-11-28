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
  type VARCHAR (20) NOT NULL,
  quantity_of_beds INTEGER NOT NULL
);

CREATE TABLE Patient (
  ssn INTEGER PRIMARY KEY NOT NULL,
  name VARCHAR (50) NOT NULL,
  surname VARCHAR (50) NOT NULL,
  gender VARCHAR (25) NOT NULL,
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
  id INTEGER PRIMARY KEY NOT NULL,
  name VARCHAR(50) NOT NULL,
  quantity INTEGER NOT NULL,
  type VARCHAR (50) NOT NULL,
  supplier VARCHAR (50) NOT NULL,
  cost INTEGER NOT NULL
);

CREATE TABLE Analysis_result (
  id INTEGER NOT NULL,
  patient_ssn INTEGER NOT NULL,
  type VARCHAR(50) NOT NULL,
  result VARCHAR(2000) NOT NULL,
  date DATE NOT NULL,
  PRIMARY KEY(id, patient_ssn)
);

CREATE TABLE Treatment_plan (
  id INTEGER PRIMARY KEY,
  doctor_ssn INTEGER REFERENCES Employee(ssn) NOT NULL,
  patient_ssn INTEGER REFERENCES Patient(ssn) NOT NULL,
  discharge_date DATE,
  hospitalization_date DATE
);

CREATE TABLE Attends (
  employee_ssn INTEGER REFERENCES Employee(ssn) NOT NULL,
  patient_ssn INTEGER REFERENCES Patient(ssn) NOT NULL,
  cost INTEGER,
  description VARCHAR(500),
  date TIMESTAMP,
  PRIMARY KEY(date, employee_ssn, patient_ssn)
);

CREATE TABLE Prescribe (
  employee_ssn INTEGER REFERENCES Employee(ssn) NOT NULL,
  patient_ssn INTEGER REFERENCES Patient(ssn) NOT NULL,
  description VARCHAR(500),
  date TIMESTAMP,
  PRIMARY KEY(date, employee_ssn, patient_ssn)
);

CREATE TABLE Chat (
  message_id VARCHAR(50) NOT NULL,
  time TIMESTAMP NOT NULL,
  employee_ssn INTEGER REFERENCES Employee(ssn) NOT NULL,
  patient_ssn INTEGER REFERENCES Patient(ssn) NOT NULL,
  text VARCHAR(500),
  PRIMARY KEY(message_id, employee_ssn, patient_ssn)
);

CREATE TABLE Uses (
  inventory_id INTEGER NOT NULL,
  treatment_id INTEGER NOT NULL,
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
(0, 'consulting room', 5),
(1, 'intensive care', 9),
(2, 'nursery', 6),
(3, 'operating room', 7),
(4, 'nursery', 5);

INSERT INTO Patient (ssn, name, surname, gender, weight, birth_date, height, blood_type, phone, country, city, street, building, room_id) VALUES
(101, 'Jane', 'Mor', 'female', 47, '2007-10-11', 141, 'A-', '+407843057971', 'Jordan', 'Ipswich', 'Clement Road', 4, 2),
(102, 'Teresa', 'Kelly', 'female', 55, '1996-07-18', 129, 'B-', '+939729645652', 'Germany', 'Kreutzberg', 'Cleveland Crescent', 5, 3),
(103, 'Luiz', 'Murashko', 'female', 73, '2002-11-03', 114, 'AB-', '+504496576188', 'Germany', 'Longview', 'Greenway Glen', 3, 4),
(104, 'Kenneth', 'Moore', 'male', 83, '1974-08-08', 129, 'O-', '+469899825762', 'Lithuania', 'Longview', 'Clement Road', 5, 4),
(105, 'Walter', 'Feygelman', 'female', 68, '2003-11-20', 149, 'A+', '+770412690750', 'Luxembourg', 'Hebron', 'Cleveland Crescent', 2, 1),
(106, 'Jeffrey', 'Martin', 'male', 45, '1979-09-29', 121, 'O+', '+961362426784', 'USA', 'Ipswich', 'Markham Cross', 10, 0),
(107, 'Luke', 'Moore', 'female', 93, '1971-10-06', 89, 'AB-', '+724852673573', 'Lebanon', 'Ipswich', 'Vicarage Quay', 1, 0),
(108, 'Luiz', 'Lorinstsa', 'female', 51, '1966-06-21', 131, 'AB-', '+592676625467', 'Russia', 'Mitchell', 'Fletcher Boulevard', 2, 3),
(109, 'Mike', 'Levenof', 'male', 45, '1989-01-01', 112, 'A+', '+267873038797', 'Egypt', 'Hebron', 'Clement Road', 4, 2),
(110, 'Lisa', 'Magomedov', 'male', 88, '1967-11-01', 102, 'AB+', '+653704372369', 'Lesotho', 'Ipswich', 'Wallis Fairway', 9, 1),
(111, 'Magomed', 'Kelly', 'male', 90, '1993-07-16', 201, 'AB-', '+184690546414', 'Latvia', 'Farwell', 'Windsor Heath', 2, 0),
(112, 'Jeffrey', 'Mor', 'male', 78, '1989-06-03', 202, 'O-', '+598071241514', 'USA', 'Hebron', 'Thorpe Celyn', 8, 2),
(113, 'Lisa', 'Lorinson', 'female', 49, '1972-04-12', 102, 'O-', '+420669751435', 'Lesotho', 'Farwell', 'Vicarage Quay', 4, 1),
(114, 'Kenneth', 'Moore', 'male', 81, '1999-04-09', 149, 'O+', '+284201246334', 'Luxembourg', 'Ipswich', 'Greenway Glen', 3, 0),
(115, 'Luke', 'Bryant', 'male', 87, '1970-05-18', 98, 'AB+', '+908604308607', 'Kuwait', 'Kreutzberg', 'Fletcher Boulevard', 10, 3),
(116, 'Luiz', 'Bryant', 'female', 76, '1979-11-24', 217, 'A+', '+240846280562', 'Lithuania', 'Storms', 'Alder Way', 1, 3),
(117, 'Magomed', 'Lorinstsa', 'male', 49, '1970-12-04', 183, 'O-', '+107463654931', 'Kuwait', 'Longview', 'Alder Way', 8, 0),
(118, 'Jane', 'Feygelman', 'female', 96, '1981-01-20', 160, 'B-', '+995854879605', 'Latvia', 'Storms', 'Clement Road', 5, 1),
(119, 'Jane', 'Martin', 'male', 49, '2005-08-25', 129, 'B+', '+458945029265', 'Kuwait', 'Kalauao', 'Cleveland Crescent', 2, 3),
(120, 'Teresa', 'Lorinson', 'female', 64, '1978-11-08', 82, 'B+', '+566838728298', 'USA', 'Kalauao', 'Clement Road', 4, 2),
(121, 'Jeffrey', 'Lorinstsa', 'female', 57, '1992-11-08', 133, 'A+', '+707672679384', 'Germany', 'Ipswich', 'Alder Way', 8, 2),
(122, 'Leonid', 'Lorinstsa', 'female', 80, '1995-08-09', 100, 'AB+', '+396659424338', 'Jordan', 'Ipswich', 'Markham Cross', 7, 0),
(123, 'Jane', 'Feygelman', 'female', 52, '2006-10-30', 123, 'O+', '+882196294043', 'Luxembourg', 'Scottsville', 'Fletcher Boulevard', 4, 1),
(124, 'Andrey', 'Richardson', 'female', 99, '1989-12-06', 175, 'AB-', '+830206641012', 'Korea', 'Emerson', 'Vicarage Quay', 6, 3),
(125, 'Luiz', 'Moore', 'female', 94, '1990-06-24', 163, 'AB+', '+972482027423', 'Latvia', 'Storms', 'Alder Way', 9, 0),
(126, 'Leonid', 'Murashko', 'female', 94, '1980-05-16', 172, 'A-', '+729849841129', 'Russia', 'Longview', 'Thorpe Celyn', 5, 1),
(127, 'Leonid', 'Lorinson', 'female', 79, '1963-10-25', 139, 'O+', '+528374487639', 'USA', 'Hebron', 'Windsor Heath', 6, 2),
(128, 'Lisa', 'Howard', 'female', 61, '1968-07-26', 178, 'AB+', '+126524609481', 'USA', 'Scottsville', 'Fletcher Boulevard', 7, 2),
(129, 'Andrey', 'Moore', 'female', 57, '1996-01-07', 100, 'A+', '+864601532127', 'Luxembourg', 'Cimarron', 'Fletcher Boulevard', 4, 1),
(130, 'Mike', 'Lorinstsa', 'female', 95, '1992-04-10', 86, 'O-', '+400400215503', 'Liechtenstein', 'Ipswich', 'Alder Way', 9, 3),
(131, 'Jane', 'Murashko', 'female', 50, '1971-12-03', 188, 'A+', '+302456704276', 'Latvia', 'Kalauao', 'Thorpe Celyn', 8, 0),
(132, 'Teresa', 'Mor', 'male', 89, '1962-06-19', 104, 'A+', '+153935198588', 'Kyrgyzstan', 'Ipswich', 'Markham Cross', 9, 2),
(133, 'Leonid', 'Mor', 'female', 66, '1983-05-04', 127, 'O-', '+381062244079', 'Lithuania', 'Farwell', 'Cleveland Crescent', 6, 2),
(134, 'Andrey', 'Wilson', 'male', 57, '1961-02-02', 108, 'O+', '+532609718745', 'Jordan', 'Mitchell', 'Markham Cross', 2, 0),
(135, 'Jeffrey', 'Lorinstsa', 'male', 99, '1976-04-21', 106, 'A-', '+691352711816', 'Kyrgyzstan', 'Mitchell', 'Clement Road', 10, 2),
(136, 'Andrey', 'Medvedev', 'male', 100, '1967-03-30', 94, 'B+', '+432608807022', 'Liechtenstein', 'Kalauao', 'Wallis Fairway', 2, 2),
(137, 'Ivan', 'Feygelman', 'male', 85, '1962-06-18', 98, 'A+', '+731425197202', 'Luxembourg', 'Kalauao', 'Cleveland Crescent', 2, 0),
(138, 'Ivan', 'Murashko', 'female', 91, '1970-11-24', 189, 'AB+', '+312081125206', 'Laos', 'Hebron', 'Fletcher Boulevard', 10, 2),
(139, 'Andrey', 'Lorinson', 'male', 60, '2004-09-26', 194, 'A+', '+644794489599', 'Luxembourg', 'Scottsville', 'Vicarage Quay', 9, 4),
(140, 'Mike', 'Wilson', 'male', 52, '1987-03-24', 206, 'AB-', '+945696057404', 'Kyrgyzstan', 'Farwell', 'Greenway Glen', 5, 0),
(141, 'Jane', 'Martin', 'female', 49, '1995-02-11', 124, 'B-', '+357160870070', 'Lebanon', 'Kreutzberg', 'Alder Way', 6, 0),
(142, 'Walter', 'Wilson', 'male', 90, '2010-04-12', 88, 'O+', '+730753642529', 'Liechtenstein', 'Kalauao', 'Vicarage Quay', 2, 0),
(143, 'Jane', 'Moore', 'male', 79, '1989-02-26', 187, 'O-', '+836854872149', 'Lithuania', 'Scottsville', 'Alder Way', 8, 1),
(144, 'Mike', 'Howard', 'male', 59, '1999-04-18', 183, 'O-', '+591016838124', 'Lebanon', 'Longview', 'Greenway Glen', 8, 0),
(145, 'Andrey', 'Feygelman', 'male', 64, '1980-04-30', 213, 'O-', '+272421418523', 'USA', 'Longview', 'Fletcher Boulevard', 8, 4),
(146, 'Andrey', 'Wilson', 'female', 62, '1962-01-23', 123, 'O-', '+993738553417', 'Germany', 'Mitchell', 'Alder Way', 7, 1),
(147, 'Luke', 'Levenof', 'female', 76, '1996-06-19', 131, 'O-', '+277628620635', 'Luxembourg', 'Scottsville', 'Markham Cross', 3, 3),
(148, 'Kenneth', 'Medvedev', 'female', 49, '1992-09-22', 164, 'O-', '+634664787619', 'Latvia', 'Cimarron', 'Greenway Glen', 8, 3),
(149, 'Luiz', 'Howard', 'male', 77, '1972-12-07', 213, 'B-', '+550448149906', 'Lebanon', 'Mitchell', 'Windsor Heath', 9, 2),
(150, 'Luke', 'Kelly', 'female', 56, '1976-03-25', 204, 'A+', '+925604785735', 'Luxembourg', 'Kalauao', 'Cleveland Crescent', 7, 0),
(151, 'Leonid', 'Magomedov', 'male', 89, '2005-01-28', 175, 'O+', '+248591636358', 'Lesotho', 'Farwell', 'Markham Cross', 3, 2),
(152, 'Luiz', 'Kelly', 'female', 66, '1983-01-29', 162, 'O+', '+718077824900', 'Jordan', 'Farwell', 'Alder Way', 3, 2),
(153, 'Mike', 'Kelly', 'male', 59, '2011-04-23', 196, 'O-', '+555673161852', 'Liechtenstein', 'Hebron', 'Alder Way', 10, 2),
(154, 'Lisa', 'Richardson', 'male', 63, '1998-01-05', 218, 'AB+', '+345348503210', 'Jordan', 'Kreutzberg', 'Wallis Fairway', 8, 1),
(155, 'Jane', 'Levenof', 'male', 63, '1971-05-08', 116, 'AB-', '+625701761294', 'Lesotho', 'Hebron', 'Greenway Glen', 3, 4),
(156, 'Andrey', 'Mor', 'female', 66, '1989-05-19', 215, 'A-', '+989282983911', 'Luxembourg', 'Scottsville', 'Wallis Fairway', 5, 2),
(157, 'Jane', 'Martin', 'female', 90, '1989-02-24', 198, 'O+', '+798200469672', 'Luxembourg', 'Scottsville', 'Thorpe Celyn', 8, 1),
(158, 'Luiz', 'Howard', 'female', 83, '1971-01-21', 123, 'A-', '+390351793361', 'Korea', 'Farwell', 'Cleveland Crescent', 5, 2),
(159, 'Jeffrey', 'Lorinson', 'female', 100, '1971-11-17', 104, 'B-', '+217583962020', 'Germany', 'Kalauao', 'Vicarage Quay', 4, 1),
(160, 'Luiz', 'Mor', 'female', 66, '2010-10-31', 137, 'A+', '+779278875660', 'Russia', 'Cimarron', 'Thorpe Celyn', 10, 0),
(161, 'Lisa', 'Lorinstsa', 'female', 87, '1978-02-08', 176, 'A-', '+998402973220', 'Kuwait', 'Farwell', 'Clement Road', 10, 2),
(162, 'Teresa', 'Magomedov', 'female', 60, '1981-05-24', 200, 'A-', '+688929065701', 'Korea', 'Kreutzberg', 'Markham Cross', 7, 0),
(163, 'Luiz', 'Medvedev', 'male', 67, '1976-02-20', 188, 'O-', '+988914515835', 'Jordan', 'Kreutzberg', 'Fletcher Boulevard', 1, 2),
(164, 'Leonid', 'Magomedov', 'male', 51, '1972-09-13', 145, 'B+', '+655635536646', 'Latvia', 'Farwell', 'Clement Road', 6, 4),
(165, 'Andrey', 'Bryant', 'male', 90, '1983-12-24', 105, 'O-', '+594296496073', 'Korea', 'Scottsville', 'Vicarage Quay', 1, 4),
(166, 'Ivan', 'Feygelman', 'male', 68, '1961-12-17', 200, 'B-', '+843073829883', 'USA', 'Kreutzberg', 'Alder Way', 10, 3),
(167, 'Leonid', 'Feygelman', 'male', 53, '1973-07-12', 85, 'O-', '+627496841767', 'Luxembourg', 'Storms', 'Greenway Glen', 5, 1),
(168, 'Walter', 'Bryant', 'male', 68, '2000-01-14', 96, 'AB-', '+447738651110', 'Jordan', 'Scottsville', 'Cleveland Crescent', 9, 1),
(169, 'Leonid', 'Levenof', 'male', 72, '1984-07-14', 124, 'O+', '+479711937413', 'Kuwait', 'Scottsville', 'Fletcher Boulevard', 2, 3),
(170, 'Magomed', 'Martin', 'female', 54, '1989-11-16', 157, 'A+', '+199184807637', 'Jordan', 'Emerson', 'Greenway Glen', 1, 0),
(171, 'Walter', 'Magomedov', 'male', 97, '2011-04-27', 93, 'O+', '+699960767898', 'Russia', 'Scottsville', 'Markham Cross', 8, 2),
(172, 'Leonid', 'Medvedev', 'female', 97, '1991-07-11', 112, 'A-', '+730079893444', 'Egypt', 'Cimarron', 'Cleveland Crescent', 9, 3),
(173, 'Mike', 'Martin', 'female', 73, '1997-08-02', 219, 'O+', '+970177205092', 'Jordan', 'Emerson', 'Thorpe Celyn', 2, 4),
(174, 'Luiz', 'Howard', 'male', 51, '1975-02-12', 90, 'A-', '+155187582369', 'Jordan', 'Ipswich', 'Clement Road', 6, 0),
(175, 'Leonid', 'Martin', 'male', 77, '1981-11-01', 96, 'O-', '+430353029779', 'Liechtenstein', 'Kalauao', 'Cleveland Crescent', 7, 4),
(176, 'Jane', 'Levenof', 'female', 46, '1974-12-09', 149, 'AB+', '+167910789185', 'Luxembourg', 'Kreutzberg', 'Fletcher Boulevard', 6, 2),
(177, 'Leonid', 'Kelly', 'female', 55, '1983-08-23', 139, 'B-', '+560368413911', 'Lebanon', 'Mitchell', 'Alder Way', 7, 3),
(178, 'Leonid', 'Kelly', 'female', 79, '1969-11-09', 152, 'B+', '+838124837400', 'Germany', 'Ipswich', 'Markham Cross', 9, 1),
(179, 'Ivan', 'Medvedev', 'female', 58, '1982-01-11', 153, 'AB+', '+379548887281', 'Lesotho', 'Kalauao', 'Windsor Heath', 7, 3),
(180, 'Walter', 'Medvedev', 'male', 51, '1973-09-30', 154, 'O-', '+259866206670', 'Latvia', 'Storms', 'Cleveland Crescent', 7, 3),
(181, 'Luke', 'Moore', 'male', 54, '2009-03-07', 173, 'B-', '+292442092252', 'Lebanon', 'Scottsville', 'Clement Road', 2, 3),
(182, 'Jeffrey', 'Mor', 'male', 75, '2010-03-10', 199, 'O+', '+195016937292', 'Luxembourg', 'Mitchell', 'Vicarage Quay', 10, 3),
(183, 'Ivan', 'Howard', 'female', 73, '1968-01-10', 160, 'O-', '+765027516530', 'Russia', 'Cimarron', 'Fletcher Boulevard', 7, 1),
(184, 'Leonid', 'Levenof', 'male', 66, '1987-05-16', 204, 'O-', '+183242654285', 'Liechtenstein', 'Farwell', 'Greenway Glen', 5, 4),
(185, 'Ivan', 'Howard', 'male', 88, '1990-09-12', 144, 'AB-', '+480227940074', 'Jordan', 'Cimarron', 'Wallis Fairway', 4, 3),
(186, 'Kenneth', 'Bryant', 'female', 67, '1991-09-29', 88, 'A+', '+383310501046', 'Liechtenstein', 'Ipswich', 'Cleveland Crescent', 8, 3),
(187, 'Mike', 'Feygelman', 'male', 93, '1995-05-05', 83, 'A-', '+664406561942', 'Jordan', 'Cimarron', 'Alder Way', 8, 3),
(188, 'Magomed', 'Richardson', 'female', 66, '1992-01-20', 175, 'A-', '+265998796178', 'Liechtenstein', 'Hebron', 'Clement Road', 7, 0),
(189, 'Leonid', 'Martin', 'male', 52, '2007-11-30', 182, 'B-', '+788667785282', 'Laos', 'Kreutzberg', 'Thorpe Celyn', 9, 0),
(190, 'Walter', 'Levenof', 'male', 74, '2002-03-16', 179, 'A+', '+750985308127', 'Germany', 'Kreutzberg', 'Alder Way', 4, 1),
(191, 'Kenneth', 'Kelly', 'male', 99, '2011-12-20', 111, 'B+', '+894822317414', 'Laos', 'Farwell', 'Markham Cross', 3, 4),
(192, 'Kenneth', 'Lorinson', 'female', 47, '1972-10-05', 193, 'O-', '+648719109649', 'USA', 'Ipswich', 'Thorpe Celyn', 6, 4),
(193, 'Luke', 'Howard', 'male', 100, '1976-11-06', 163, 'O+', '+747163012933', 'Luxembourg', 'Kalauao', 'Fletcher Boulevard', 7, 2),
(194, 'Munir', 'Lorinson', 'female', 59, '2008-06-12', 138, 'AB-', '+606143540506', 'Jordan', 'Scottsville', 'Clement Road', 3, 2),
(195, 'Lisa', 'Magomedov', 'male', 66, '1976-02-22', 198, 'A-', '+241355930637', 'Russia', 'Cimarron', 'Wallis Fairway', 4, 4),
(196, 'Ivan', 'Martin', 'male', 73, '2004-08-27', 88, 'B-', '+448767750073', 'USA', 'Storms', 'Thorpe Celyn', 2, 2),
(197, 'Jane', 'Martin', 'female', 71, '1995-05-24', 133, 'B+', '+324858567538', 'Latvia', 'Hebron', 'Alder Way', 1, 2),
(198, 'Lisa', 'Feygelman', 'female', 89, '1980-11-19', 154, 'AB+', '+156045813802', 'Kyrgyzstan', 'Longview', 'Wallis Fairway', 6, 1),
(199, 'Jeffrey', 'Martin', 'female', 67, '1983-11-21', 179, 'B+', '+764940819759', 'Russia', 'Cimarron', 'Wallis Fairway', 3, 2),
(200, 'Leonid', 'Richardson', 'female', 53, '1984-12-31', 88, 'O-', '+942804763553', 'Lesotho', 'Ipswich', 'Clement Road', 4, 3),
(201, 'Leonid', 'Wilson', 'female', 64, '1981-03-24', 218, 'A+', '+997774439903', 'Laos', 'Cimarron', 'Windsor Heath', 5, 3),
(202, 'Jeffrey', 'Magomedov', 'male', 76, '1977-06-01', 220, 'A-', '+640010556971', 'Laos', 'Scottsville', 'Windsor Heath', 5, 2);

 INSERT INTO Employee (ssn, name, surname, phone, specialization, salary, type) VALUES
(1, 'Jeffrey', 'Howard', '+587371711473', 'Psychiatry‎', 48000, 'doctor'),
(2, 'Magomed', 'Bryant', '+121300144156', 'Psychiatry‎', 59000, 'doctor'),
(3, 'Jeffrey', 'Howard', '+151584951476', 'Prison healthcare‎', 51000, 'doctor'),
(4, 'Leonid', 'Murashko', '+466462792902', 'Hepatology‎', 43000, 'doctor');


INSERT INTO Employee (ssn, name, surname, phone, specialization, salary, type) VALUES
(5, 'Luiz', 'Martin', '+287158696585', 'Nursing informatics', 48000, 'nurse'),
(6, 'Luiz', 'Lorinson', '+932539619338', 'Renal nursing', 53000, 'nurse'),
(7, 'Luke', 'Lorinstsa', '+823241487122', 'Space nursing', 23000, 'nurse'),
(8, 'Lisa', 'Howard', '+878415321423', 'Neonatal nursing', 56000, 'nurse'),
(9, 'Magomed', 'Wilson', '+831722084022', 'Infection control nursing', 35000, 'nurse');

 INSERT INTO Prescribe (employee_ssn, patient_ssn, description, date) VALUES
(2, 159, 'Doctor attends patient', '2018-05-09'),
(2, 185, 'Doctor attends patient', '2017-02-13'),
(1, 194, 'Doctor attends patient', '2016-10-26');

 INSERT INTO Analysis_result (id, patient_ssn, type, result, date) VALUES
(0, 120, 'Pap smear', 'Medical result', '2016-05-10'),
(1, 121, 'blood analysis', 'Medical result', '2015-06-19'),
(2, 186, 'kidney function test', 'Medical result', '2016-05-13'),
(3, 166, 'lumbar puncture', 'Medical result', '2018-12-02'),
(4, 193, 'blood analysis', 'Medical result', '2018-04-03');

INSERT INTO Attends (employee_ssn, patient_ssn, cost, description, date) VALUES
(3, 118, 46340, 'Attend description', '2013-05-13 06:00:15'),
(2, 186, 13259, 'Attend description', '2018-11-25 16:06:06'),
(1, 158, 27476, 'Attend description', '2017-07-31 10:36:22'),
(4, 138, 36943, 'Attend description', '2011-07-30 06:34:22'),
(3, 177, 11053, 'Attend description', '2014-03-21 13:30:18'),
(4, 118, 6532, 'Attend description', '2016-06-21 16:52:09'),
(4, 150, 38769, 'Attend description', '2017-11-15 06:29:23'),
(3, 125, 7551, 'Attend description', '2013-09-29 14:03:43'),
(1, 106, 37055, 'Attend description', '2015-02-12 02:06:41'),
(4, 126, 43978, 'Attend description', '2019-10-23 17:32:41'),
(1, 113, 3802, 'Attend description', '2014-02-12 02:07:32'),
(1, 198, 1369, 'Attend description', '2015-03-15 00:08:00'),
(2, 127, 22778, 'Attend description', '2012-12-08 02:50:06'),
(4, 174, 4188, 'Attend description', '2010-03-03 00:10:48'),
(2, 121, 25387, 'Attend description', '2016-02-06 05:58:00'),
(3, 126, 15104, 'Attend description', '2009-09-25 17:23:42'),
(2, 201, 36435, 'Attend description', '2018-03-21 19:13:39'),
(4, 129, 7353, 'Attend description', '2016-05-11 13:17:29'),
(1, 147, 10188, 'Attend description', '2017-08-12 10:21:10'),
(4, 186, 7894, 'Attend description', '2019-02-04 23:49:13'),
(4, 175, 40085, 'Attend description', '2017-05-10 09:32:52'),
(3, 167, 13067, 'Attend description', '2015-09-27 15:48:24'),
(4, 179, 43638, 'Attend description', '2018-11-30 01:11:32'),
(3, 155, 5837, 'Attend description', '2014-10-27 20:14:54'),
(3, 182, 46788, 'Attend description', '2016-12-26 04:07:01'),
(2, 106, 27962, 'Attend description', '2011-08-08 22:37:05'),
(3, 122, 28766, 'Attend description', '2010-05-26 08:43:53'),
(1, 119, 9407, 'Attend description', '2013-11-16 19:41:23'),
(1, 105, 39852, 'Attend description', '2011-03-14 22:22:56'),
(4, 143, 49609, 'Attend description', '2018-10-29 21:21:06'),
(2, 202, 5781, 'Attend description', '2013-12-30 04:23:02'),
(1, 111, 15225, 'Attend description', '2019-01-16 13:12:46'),
(4, 176, 7281, 'Attend description', '2015-05-07 08:49:38'),
(1, 115, 1860, 'Attend description', '2018-10-29 06:13:06'),
(1, 167, 30281, 'Attend description', '2009-03-09 02:57:01'),
(1, 122, 35284, 'Attend description', '2015-04-05 18:27:26'),
(3, 136, 43446, 'Attend description', '2013-04-05 11:54:01'),
(2, 128, 47453, 'Attend description', '2011-12-13 19:34:46'),
(4, 164, 35890, 'Attend description', '2013-03-05 19:24:19'),
(2, 106, 2341, 'Attend description', '2018-06-07 19:47:36'),
(1, 141, 25046, 'Attend description', '2015-11-16 03:41:48'),
(4, 202, 21910, 'Attend description', '2011-12-24 23:59:27'),
(4, 151, 7253, 'Attend description', '2015-07-30 22:45:21'),
(4, 173, 8284, 'Attend description', '2011-01-12 05:58:58'),
(1, 185, 15222, 'Attend description', '2019-06-20 06:52:28'),
(2, 136, 21758, 'Attend description', '2015-06-10 13:04:19'),
(4, 117, 13061, 'Attend description', '2019-01-10 08:13:36'),
(4, 138, 9002, 'Attend description', '2012-01-16 07:24:33'),
(3, 121, 23329, 'Attend description', '2018-05-05 04:25:55'),
(4, 110, 36219, 'Attend description', '2018-04-15 07:25:08'),
(1, 138, 11424, 'Attend description', '2014-03-27 05:14:36'),
(3, 134, 21257, 'Attend description', '2016-03-12 11:24:35'),
(3, 101, 15268, 'Attend description', '2018-12-09 19:34:52'),
(2, 145, 1856, 'Attend description', '2015-06-05 22:13:29'),
(1, 171, 32691, 'Attend description', '2014-10-13 03:12:19'),
(4, 175, 39737, 'Attend description', '2010-09-14 01:49:05'),
(1, 133, 15298, 'Attend description', '2019-08-31 13:01:15'),
(3, 119, 10313, 'Attend description', '2013-01-28 00:44:16'),
(4, 165, 22887, 'Attend description', '2014-03-30 03:53:15'),
(3, 160, 28229, 'Attend description', '2014-07-25 13:16:29'),
(2, 148, 42873, 'Attend description', '2011-07-02 14:35:15'),
(1, 161, 47592, 'Attend description', '2013-10-31 20:12:41'),
(4, 191, 49678, 'Attend description', '2010-10-14 23:59:52'),
(3, 195, 33806, 'Attend description', '2015-02-22 08:48:38'),
(4, 128, 23002, 'Attend description', '2017-04-19 01:57:55'),
(4, 123, 45946, 'Attend description', '2009-04-27 09:57:12'),
(3, 143, 47497, 'Attend description', '2012-04-28 10:50:36'),
(2, 149, 25131, 'Attend description', '2014-05-21 10:02:29'),
(2, 144, 44650, 'Attend description', '2014-09-06 18:58:17'),
(3, 122, 10599, 'Attend description', '2014-12-28 05:54:31'),
(1, 198, 39819, 'Attend description', '2019-06-09 13:46:47'),
(1, 113, 2701, 'Attend description', '2019-03-18 16:14:45'),
(3, 198, 9560, 'Attend description', '2013-01-19 14:49:18'),
(2, 167, 44265, 'Attend description', '2014-04-09 23:31:02'),
(1, 125, 32944, 'Attend description', '2017-12-30 18:35:58'),
(4, 194, 44611, 'Attend description', '2018-12-02 00:03:04'),
(1, 130, 41632, 'Attend description', '2019-09-17 13:36:11'),
(3, 153, 18532, 'Attend description', '2018-07-15 06:27:53'),
(1, 137, 16041, 'Attend description', '2013-05-29 00:45:09'),
(1, 108, 45414, 'Attend description', '2010-10-19 19:43:31'),
(4, 151, 33986, 'Attend description', '2009-11-25 19:47:18'),
(2, 166, 41127, 'Attend description', '2018-11-20 21:35:11'),
(3, 121, 40330, 'Attend description', '2019-07-14 00:26:33'),
(3, 136, 17474, 'Attend description', '2009-10-06 05:24:34'),
(3, 163, 7181, 'Attend description', '2019-01-19 12:38:16'),
(2, 149, 45243, 'Attend description', '2009-02-17 04:51:41'),
(1, 118, 45414, 'Attend description', '2015-08-11 09:20:08'),
(2, 127, 25250, 'Attend description', '2015-01-28 22:26:17'),
(1, 122, 20371, 'Attend description', '2015-02-12 22:57:09'),
(2, 106, 47884, 'Attend description', '2014-12-04 21:03:17'),
(2, 184, 15573, 'Attend description', '2010-10-10 18:20:04'),
(4, 154, 46927, 'Attend description', '2014-01-16 03:26:43'),
(3, 176, 49490, 'Attend description', '2019-04-27 02:27:27'),
(1, 146, 4720, 'Attend description', '2014-11-01 09:29:06'),
(4, 139, 12809, 'Attend description', '2015-02-01 18:13:32'),
(3, 104, 24097, 'Attend description', '2015-09-28 17:36:11'),
(4, 102, 40330, 'Attend description', '2009-02-05 16:46:02'),
(1, 136, 3284, 'Attend description', '2015-04-02 13:22:26'),
(4, 160, 21909, 'Attend description', '2017-05-29 23:06:36'),
(2, 185, 6307, 'Attend description', '2009-12-26 20:32:13');

INSERT INTO Chat (message_id, time, employee_ssn, patient_ssn, text) VALUES
('iddxtnxveepjqzdispojritwjfgwtfwvtodihivgldglhoclwh', '2016-09-23 18:53:01', 3, 198, 'Random message'),
('kerxrlmgssenjmhxkssvijvojqmydeftmxrskfrfxlpjstznlh', '2016-08-06 11:03:51', 2, 101, 'Random message'),
('ztytadwejqlmrytyaeomtrsfpeximspfrortzfudzwkvgfiwny', '2016-07-18 06:25:45', 4, 171, 'Random message');

INSERT INTO Inventory_item (id, name, quantity, type, supplier, cost) VALUES
(0, 'Aminocaproic Acid', 2, 'medicine', 'Prasco Laboratories', 8000),
(1, 'Amifostine', 3, 'medicine', 'Portola Pharmaceuticals, Inc.', 14500),
(2, 'Amlodipine', 3, 'medicine', 'Prasco Laboratories', 25000);

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
(1, 1, 115, '2015-02-07', '2015-01-24'),
(2, 1, 167, '2017-06-04', '2017-05-21'),
(0, 4, 171, '2016-04-15', '2016-04-01');

INSERT INTO Treatment_diagnoses  VALUES
(1, 8),
(2, 0),
(0, 4);

INSERT INTO Treatment_procedures VALUES
(1, 23),
(2, 0),
(0, 16);

 INSERT INTO Uses (inventory_id, treatment_id) VALUES
(1, 1),
(2, 2),
(0, 0);

 INSERT INTO Log (id, name, description, time) VALUES
(0, 'log_0', 'initialization', '2017-10-24 09:43:38'),
(1, 'log_1', 'initialization', '2015-06-04 13:49:20'),
(2, 'log_2', 'initialization', '2017-03-09 01:09:36');


