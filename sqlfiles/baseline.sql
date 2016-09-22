CREATE DATABASE DNSDN;
USE DNSDN;
# Create our Tables
 
CREATE TABLE Request_Log (Request_Number BIGINT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
Source_IP INT UNSIGNED NOT NULL,
Request_URI TEXT,
Request_Date DATETIME,
Request_State_ID TINYINT UNSIGNED,
KEY IP_Date (Source_IP, Request_Date),
KEY Failed (Source_IP, Request_State_ID, Request_Date),
KEY FastRequestsByDate (Request_State_ID, Request_Date)
) ENGINE=InnoDB CHARSET=utf8mb4;

CREATE TABLE Request_States (Request_State_ID TINYINT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
Request_State_Value varchar(80),
KEY Request_State_Values (Request_State_Value)
)ENGINE=InnoDB CHARSET=utf8mb4;

CREATE TABLE Lists (List_ID BIGINT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
List_Type_ID TINYINT UNSIGNED NOT NULL,
List_Notes VARCHAR(255),
KEY List_Type (List_Type_ID)
) ENGINE=InnoDB CHARSET=utf8mb4;

CREATE TABLE List_Types (List_Type_ID TINYINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
List_Name VARCHAR(80)NOT NULL,
List_Description TEXT,
KEY List_Name (List_Name)
) ENGINE=InnoDB CHARSET=utf8mb4;

CREATE TABLE Listed_URI_Bases (Base_URI_ID BIGINT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
Base_URI_TEXT VARCHAR(255),
List_ID TINYINT unsigned not null,
KEY List_ID (List_ID, Base_URI_TEXT),
KEY URI (Base_URI_TEXT, List_ID)
) ENGINE=InnoDB CHARSET=utf8mb4;

CREATE TABLE Listed_URI ( Blacklist_ID BIGINT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
Base_URI_ID BIGINT UNSIGNED NOT NULL,
URI_Path TEXT,
List_ID TINYINT UNSIGNED NOT NULL,
KEY Base_URI (Base_URI_ID, List_ID),
FULLTEXT KEY (URI_Path)
) ENGINE=InnoDB CHARSET=utf8mb4;

CREATE TABLE List_Audit (Base_URI_ID BIGINT UNSIGNED NOT NULL, 
URI_Path TEXT NULL, 
List_ID_From TINYINT UNSIGNED NOT NULL, 
List_ID_TO TINYINT UNSIGNED NOT NULL,
KEY AllThingsGetAudited (List_ID_From, List_ID_To),
FULLTEXT KEY (URI_Path)
) ENGINE=InnoDB CHARSET=utf8mb4;

# Insert our system default List Types (Blacklist and Whitelist for now)
INSERT INTO List_Types(List_Type_ID, List_Name, List_Description) VALUES (1, 'Default Blacklist', 'This is the system default Blacklist type. This list type should be used on all lists that are scanned to exclude an address.');
INSERT INTO List_Types(List_Type_ID, List_Name, List_Description) VALUES (2, 'Default Whitelist', 'This is the system default Whitelist type. This list type should be used on all lists that are scanned to prevent exclusion of an address.');

# Insert The Default Blacklist and Whitelist
INSERT INTO Lists(List_ID, List_Type_ID, List_Notes) VALUES (1, 1, 'This is the default Blacklist.');
INSERT INTO Lists(List_ID, List_Type_ID, List_Notes) VALUES (2, 2, 'This is the default Whitelist.');

# Insert our default request states
INSERT INTO Request_States(Request_State_ID, Request_State_Value) VALUES (1, 'Received');
INSERT INTO Request_States(Request_State_ID, Request_State_Value) VALUES (2, 'Processing');
INSERT INTO Request_States(Request_State_ID, Request_State_Value) VALUES (3, 'Completed - Approved');
INSERT INTO Request_States(Request_State_ID, Request_State_Value) VALUES (4, 'Completed - Denied');
INSERT INTO Request_States(Request_State_ID, Request_State_Value) VALUES (5, 'Unknown');

