-- -----------------------------------------------------
-- Schema employees
-- -----------------------------------------------------
CREATE DATABASE employees;

-- -----------------------------------------------------
-- Table `employees`.`employees`
-- -----------------------------------------------------
CREATE TABLE `employees` (
    `employeeID` VARCHAR(30) NOT NULL,
    `firstName` VARCHAR(20) NOT NULL,
    `lastName` VARCHAR(20) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    `emergencyContact` VARCHAR(30),
    `department` VARCHAR(30) NOT NULL,
    `jobTitle` VARCHAR(30) NOT NULL,
    `reportsTo` VARCHAR(30),
    `status` VARCHAR(20),
    PRIMARY KEY (employeeID),
    FOREIGN KEY (reportsTo) REFERENCES `employees`(employeeID)
);

-- -----------------------------------------------------
-- Table `employees`.`EmploymentRecords`
-- -----------------------------------------------------
CREATE TABLE `employmentRecords` (
    `employmentRecordsID` VARCHAR(30) NOT NULL,
    `employeeID` VARCHAR(30) NOT NULL,
    `department` VARCHAR(30) NOT NULL,
    `hireDate` DATE NOT NULL,
    `terminationDate` DATE,
    `salary` DECIMAL(10, 2) NOT NULL,
    `dateOfBirth` DATE,
    `address` VARCHAR(50) NOT NULL,
    `performanceReviewDate` DATE,
    `performanceReviewScore` SMALLINT,
    PRIMARY KEY (employmentRecordsID),
    FOREIGN KEY (employeeID) REFERENCES `employees`(employeeID)
);

-- -----------------------------------------------------
-- Table `employees`.`benefits`
-- -----------------------------------------------------
CREATE TABLE `benefits` (
    `benefitID` VARCHAR(30) NOT NULL,
    `employeeID` VARCHAR(30) NOT NULL,
    `benefitType` VARCHAR(20) NOT NULL,
    `provider` VARCHAR(30) NOT NULL,
    `startDate` DATE NOT NULL,
    `endDate` DATE,
    PRIMARY KEY (benefitID),
    FOREIGN KEY (employeeID) REFERENCES `employees`(employeeID)
);

-- -----------------------------------------------------
-- Table `employees`.`timeAndAttendance`
-- -----------------------------------------------------
CREATE TABLE `timeAndAttendance` (
    `attendanceRecordID` VARCHAR(30) NOT NULL,
    `employeeID` VARCHAR(30) NOT NULL,
    `date` DATE NOT NULL,
    `clockInTime` TIME NOT NULL,
    `clockOutTime` TIME,
    `hoursWorked` TIME,
    PRIMARY KEY (attendanceRecordID),
    FOREIGN KEY (employeeID) REFERENCES `employees`(employeeID)
);

-- -----------------------------------------------------
-- Table `employees`.`Training`
-- -----------------------------------------------------
CREATE TABLE `training` (
    `trainingID` VARCHAR(30) NOT NULL,
    `employeeID` VARCHAR(30) NOT NULL,
    `trainingName` VARCHAR(30) NOT NULL,
    `startingDate` DATE NOT NULL,
    `completionDate` DATE,
    `certificateNumber` VARCHAR(30),
    PRIMARY KEY (trainingID),
    FOREIGN KEY (employeeID) REFERENCES `employees`(employeeID)
);


