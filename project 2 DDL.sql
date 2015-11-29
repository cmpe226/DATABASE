
SET foreign_key_checks = 0;
drop database if exists PropertyListing;
create database PropertyListing;
use PropertyListing;


create table PropertyOwner(

OwnerId      integer AUTO_INCREMENT,
UserName     varchar(30) not null ,
ProfileID    integer,
Password      varchar(30),
primary key (OwnerId),
unique (UserName)



);

create table Profile(

ProfileID    integer not null AUTO_INCREMENT,
Photo        varchar(30),
FirstName    varchar(30),
LastName     varchar(30),
primary key (ProfileID)



);
create table Property(

PropertyID   integer not null AUTO_INCREMENT,
Street       varchar(40),
City         varchar(40),
State        varchar(4),
Zip          integer,
Description  varchar(60),
OwnerId      integer not null,
AgentId      integer,
primary key (PropertyID)



);
create table RealEstateAgent(

AgentId       integer     not null AUTO_INCREMENT,
LicenseNumber varchar(40) not null,
UserName      varchar(40) not null,
Password      varchar(40) not null,
ProfileID     integer     not null,
primary key (AgentId),
unique (LicenseNumber),
unique (UserName)




);
create table RegisteredUser(

UserID        integer     not null AUTO_INCREMENT,
UserName      varchar(40) not null,
Password      varchar(40) not null,
ProfileID     integer     not null,
primary key (UserID),
unique (UserName)


);
create table Log(

Log_id        integer not null AUTO_INCREMENT,
Decription          varchar(40),
Timestamp     TIMESTAMP,
primary key   (Log_id)


);
create table Listing(

ListingID       integer AUTO_INCREMENT,
ListingDateTime TIMESTAMP,
SalePrice       integer,
SoldPrice       integer,
PropertyID      integer not null,
Viewcount       integer,
SoldDate        DATE,
primary key (ListingID)



);
create table Bookmarks(

ListingId integer not null,
UserId    integer not null,
primary key (ListingId,UserId)



);
create table Property_features(

PropertyId    integer,
Features      varchar(40),
primary key  (PropertyId,Features),
foreign key  (PropertyId) references Property(PropertyId)


);
create table Listing_Pictures(

ListingId   integer,
Pictures     varchar(40),
primary key (ListingId,pictures)



);




-- PropertyOwner
ALTER TABLE PropertyOwner ADD CONSTRAINT FK_prepertyowner_profile_id FOREIGN KEY (ProfileID) REFERENCES Profile(ProfileID);


-- Property
ALTER TABLE Property ADD CONSTRAINT FK_property_owner_id FOREIGN KEY (ownerId) REFERENCES PropertyOwner(OwnerId);
ALTER TABLE Property ADD CONSTRAINT FK_property_agent_id FOREIGN KEY (AgentId) REFERENCES RealEstateAgent(agentId);





-- RealEstateAgent
ALTER TABLE RealEstateAgent ADD CONSTRAINT FK_agent_profile_no FOREIGN KEY (ProfileID) REFERENCES Profile(ProfileID);
ALTER TABLE RegisteredUser ADD CONSTRAINT FK_user_profile_no FOREIGN KEY (ProfileID) REFERENCES Profile(ProfileID);





-- Listing
ALTER TABLE Listing ADD CONSTRAINT FK_listing_propertyID_id FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID);

-- Bookmarks
ALTER TABLE Bookmarks ADD CONSTRAINT FK_bookmar_listing_no FOREIGN KEY (ListingId) REFERENCES Listing(ListingID);
ALTER TABLE Bookmarks ADD CONSTRAINT FK_bookmar_user_no FOREIGN KEY (UserId) REFERENCES RegisteredUser(UserID);

-- Listing_Pictures
ALTER TABLE Listing_Pictures ADD CONSTRAINT FK_listingpic_listing_no FOREIGN KEY (ListingId) REFERENCES Listing(ListingId);


-- usercreations(transaction)
DELIMITER $$
CREATE PROCEDURE usercreations(IN FirstName varchar(30), IN LastName varchar(30), IN UserName varchar(40),IN Password varchar(40)) BEGIN
DECLARE `_rollback` BOOL DEFAULT 0;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollback` = 1; START TRANSACTION;
INSERT INTO Profile (FirstName,LastName) VALUES (FirstName,LastName);
INSERT INTO RegisteredUser (UserName,Password,ProfileID) VALUES (UserName,Password,(select count(ProfileID) from Profile)) ;
IF `_rollback` THEN
ROLLBACK; ELSE
COMMIT; END IF;
END$$
DELIMITER ;
-- QUERY

-- EX: call usercreations('Harry', 'Gate' ,'Harrygate','13132424');
				           FirNam   LasNam  username    password

-- agentcreations(transaction)

DELIMITER $$
CREATE PROCEDURE agentcreations(IN FirstName varchar(30), IN LastName varchar(30),IN LicenseNumber varchar(40) ,IN UserName varchar(40),IN Password varchar(40)) BEGIN
DECLARE `_rollback` BOOL DEFAULT 0;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollback` = 1; START TRANSACTION;
INSERT INTO Profile (FirstName,LastName) VALUES (FirstName,LastName);
INSERT INTO RealEstateAgent (LicenseNumber,UserName,Password,ProfileID) VALUES (LicenseNumber, UserName,Password,(select count(ProfileID) from Profile)) ;
IF `_rollback` THEN
ROLLBACK; ELSE
COMMIT; END IF;
END$$
DELIMITER ;


-- QUERY
-- EX:   call agentcreations('TOM', 'swift','123ese' ,'tommy','13132424');
				              FirNam  LasNam LicenNum  UserName password

-- propertyownercreation (transaction)
DELIMITER $$
CREATE PROCEDURE propertyownercreation(IN FirstName varchar(30), IN LastName varchar(30), IN UserName varchar(40),IN Password varchar(40)) BEGIN
DECLARE `_rollback` BOOL DEFAULT 0;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollback` = 1; START TRANSACTION;
INSERT INTO Profile (FirstName,LastName) VALUES (FirstName,LastName);
INSERT INTO PropertyOwner (UserName,Password,ProfileID) VALUES (UserName,Password,(select count(ProfileID) from Profile)) ;
IF `_rollback` THEN
ROLLBACK; ELSE
COMMIT; END IF;
END$$
DELIMITER ;
-- QUERY
-- call propertyownercreation('Jill',  'Hanson' ,'jellyson',  'erer234');
--EX :				         FirNam   LasNam   username     password





















