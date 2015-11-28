
![alt tag] (http://2.bp.blogspot.com/-hwYhixmJbgw/UkxWfUz24WI/AAAAAAAAZ_w/piCUqTAS-Uo/s1600/Beautiful_House_In_Brentwood_by_Belzberg_Architects_Group_on_world_of_architecture_01.jpg)


# DATABASE
The "ERD" and the "SCHEMA" are purely based on the MARK's ERD(our last meeting)

## FUNCTION THIS DATABASE PROVIDE:

* **Transaction**        
*  User creation
QUERY
EX: call usercreations('Harry', 'Gate' ,'Harrygate','13132424')
                        FirNam   LasNam  username    password

agentcreations
QUERY
EX: call agentcreations('TOM', 'swift','123ese' ,'tommy','13132424');
		  		              FirNam  LasNam LicenNum  UserName password

propertyownercreation
QUERY
call propertyownercreation('Jill',  'Hanson' ,'jellyson',  'erer234');
EX :      				         FirNam   LasNam   username     password
* **View**                   
Unregister user


* **Store procedure** 
Top 10 Listing(view+bookmark)


* **Trigger**                
Listing creation -> Log Table   

