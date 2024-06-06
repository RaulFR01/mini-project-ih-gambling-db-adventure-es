
	use ironhack_gambling;
    DROP TABLE CUSTOMER;
    CREATE TABLE Customer (
      CustId VARCHAR(255),
      AccountLocation VARCHAR(255),
      Title VARCHAR(255),
      FirstName VARCHAR(255),
      LastName VARCHAR(255),
      CreateDate DATETIME,
      CountryCode VARCHAR(255),
      Language VARCHAR(255),
      Status VARCHAR(255),
      DateOfBirth DATETIME,
      Contact VARCHAR(255),
      CustomerGroup VARCHAR(255)
    );


    INSERT INTO Customer (CustId, AccountLocation, Title, FirstName, LastName, CreateDate, CountryCode, Language, Status,DateOfBirth,  Contact,  CustomerGroup) VALUES (4188499, 'GIB', 'Mr', 'Elvis', 'Presley', Timestamp('2011-11-01 00:00:00'), 'US', 'en', 'A', Timestamp('1948-10-18 00:00:00'), 'Y', 'Bronze'), (1191874, 'GIB', 'Mr', 'Jim', 'Morrison', Timestamp('2008-09-19 00:00:00'), 'US', 'en', 'A', Timestamp('1967-07-27 00:00:00'), 'Y', 'Gold'), (3042166, 'GIB', 'Mr', 'Keith', 'Moon', Timestamp('2011-01-11 00:00:00'), 'UK ', 'en', 'A', Timestamp('1970-07-26 00:00:00'), 'Y', 'Gold'), (5694730, 'GIB', 'Mr', 'James', 'Hendrix', Timestamp('2012-10-10 00:00:00'), 'US', 'en', 'A', Timestamp('1976-04-05 00:00:00'), 'N', 'Bronze'), (4704925, 'GIB', 'Mr', 'Marc', 'Bolan', Timestamp('2012-03-26 00:00:00'), 'UK ', 'en', 'A', Timestamp('1982-03-11 00:00:00'), 'Y', 'Bronze'), (1569944, 'GIB', 'Miss', 'Janice', 'Joplin', Timestamp('2009-04-09 00:00:00'), 'US', 'en', 'A', Timestamp('1954-08-22 00:00:00'), 'Y', 'Gold'), (3531845, 'GIB', 'Mr', 'Bon', 'Scott', Timestamp('2011-04-02 00:00:00'), 'AU', 'en', 'A', Timestamp('1975-10-22 00:00:00'), 'N', 'Silver'), (2815836, 'GIB', 'Mr', 'Buddy', 'Holly', Timestamp('2010-10-17 00:00:00'), 'US', 'en', 'A', Timestamp('1964-01-13 00:00:00'), 'Y', 'Silver'), (889782, 'GIB', 'Mr', 'Bob', 'Marley', Timestamp('2008-01-16 00:00:00'), 'UK ', 'en', 'A', Timestamp('1964-04-18 00:00:00'), 'Y', 'Silver'), (1965214, 'GIB', 'Mr', 'Sidney', 'Vicious', Timestamp('2009-12-18 00:00:00'), 'UK ', 'en', 'A', Timestamp('1976-08-12 00:00:00'), 'N', 'Bronze');

