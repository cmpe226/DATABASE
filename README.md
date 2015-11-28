
![alt tag] (http://2.bp.blogspot.com/-hwYhixmJbgw/UkxWfUz24WI/AAAAAAAAZ_w/piCUqTAS-Uo/s1600/Beautiful_House_In_Brentwood_by_Belzberg_Architects_Group_on_world_of_architecture_01.jpg)


# DATABASE
The "ERD" and the "SCHEMA" are purely based on the MARK's ERD(our last meeting)

## FUNCTION THIS DATABASE PROVIDE:

* **Transaction**        
User creation
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


-- Trigger (Listing creation --> log table)
DELIMITER $$ ;
CREATE TRIGGER ListingTriggerLog AFTER UPDATE ON Listing
FOR EACH ROW
BEGIN
INSERT into Log(Log_id,Decription,Timestamp)
VALUES ((SELECT ListingID FROM Listing ORDER BY ListingID DESC LIMIT 1),(SELECT Description FROM Listing,Property where Listing.PropertyID=Property.PropertyID ORDER BY ListingID DESC LIMIT 1),now()); 
END $$
DELIMITER ; $$


* **View**                   
Unregister user


* **Store procedure** 
Top 10 Listing(view+bookmark)


* **Trigger**                
Listing creation -> Log Table   

