DROP DATABASE IF EXISTS P-MDLD-MLD;

CREATE DATABASE IF NOT EXISTS P-MDLD-MLD;
USE P-MDLD-MLD;
# -----------------------------------------------------------------------------
#       TABLE : GAME
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS GAME
 (
   ID_PRODUCT BIGINT(7) NOT NULL  ,
   ID_PUBLISHER BIGINT(7) NOT NULL  ,
   ID_DEVELOPER BIGINT(7) NOT NULL  ,
   ISDEMO BOOL NOT NULL  
   , PRIMARY KEY (ID_PRODUCT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE GAME
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_GAME_PUBLISHER
     ON GAME (ID_PUBLISHER ASC);

CREATE  INDEX I_FK_GAME_DEVELOPER
     ON GAME (ID_DEVELOPER ASC);

# -----------------------------------------------------------------------------
#       TABLE : STAFF
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS STAFF
 (
   ID_PERSON BIGINT(7) NOT NULL  
   , PRIMARY KEY (ID_PERSON) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : SUPPORTCATEGORY
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS SUPPORTCATEGORY
 (
   ID_SUPPORTCATEGORY BIGINT(7) NOT NULL  ,
   SCANAME VARCHAR(128) NOT NULL  
   , PRIMARY KEY (ID_SUPPORTCATEGORY) 
   , UNIQUE INDEX AK_SUPPORTCATEGORY (SCANAME) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : USER
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS USER
 (
   ID_PERSON BIGINT(7) NOT NULL  ,
   ID_LANGUAGE BIGINT(7) NOT NULL  ,
   USEPASSWORD VARCHAR(128) NOT NULL  ,
   USEDISPLAYNAME VARCHAR(100) NOT NULL  
   , PRIMARY KEY (ID_PERSON) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE USER
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_USER_LANGUAGE
     ON USER (ID_LANGUAGE ASC);

# -----------------------------------------------------------------------------
#       TABLE : PUBLISHER
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PUBLISHER
 (
   ID_PERSON BIGINT(7) NOT NULL  
   , PRIMARY KEY (ID_PERSON) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : REDEEMCODE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS REDEEMCODE
 (
   ID_REDEEMCODE BIGINT(7) NOT NULL  ,
   ID_PRODUCT BIGINT(7) NOT NULL  ,
   REDCODE VARCHAR(32) NOT NULL  ,
   REDEXPIRESAT DATE NOT NULL  ,
   REDREDEEMEDAT DATE NULL  ,
   REDISACTIVE BOOL NOT NULL  
   , PRIMARY KEY (ID_REDEEMCODE) 
   , UNIQUE INDEX AK_REDEEMCODE (REDCODE) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE REDEEMCODE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_REDEEMCODE_PRODUCT
     ON REDEEMCODE (ID_PRODUCT ASC);

# -----------------------------------------------------------------------------
#       TABLE : RESOURCETYPE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS RESOURCETYPE
 (
   ID_RESOURCETYPE BIGINT(7) NOT NULL  ,
   RETTYPE VARCHAR(15) NOT NULL  
   , PRIMARY KEY (ID_RESOURCETYPE) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : CONTRIBUTOR
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CONTRIBUTOR
 (
   ID_PERSON BIGINT(7) NOT NULL  
   , PRIMARY KEY (ID_PERSON) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : FEATURE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS FEATURE
 (
   ID_FEATURE BIGINT(7) NOT NULL  ,
   FEANAME VARCHAR(50) NOT NULL  
   , PRIMARY KEY (ID_FEATURE) 
   , UNIQUE INDEX AK_FEATURE (FEANAME) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : PLATFORM
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PLATFORM
 (
   ID_PLATFORM BIGINT(7) NOT NULL  ,
   PLANAME VARCHAR(50) NOT NULL  
   , PRIMARY KEY (ID_PLATFORM) 
   , UNIQUE INDEX AK_PLATFORM (PLANAME) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : PURCHASE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PURCHASE
 (
   ID_PURCHASE BIGINT(7) NOT NULL  ,
   ID_PAYMENTMETHOD BIGINT(7) NOT NULL  ,
   ID_PERSON BIGINT(7) NOT NULL  ,
   PURPRICEPAID DECIMAL(10,2) NOT NULL  ,
   PURDATE DATE NOT NULL  
   , PRIMARY KEY (ID_PURCHASE) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE PURCHASE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_PURCHASE_USER
     ON PURCHASE (ID_PERSON ASC);

CREATE  INDEX I_FK_PURCHASE_PAYMENTMETHOD
     ON PURCHASE (ID_PAYMENTMETHOD ASC);

# -----------------------------------------------------------------------------
#       TABLE : PERSON
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PERSON
 (
   ID_PERSON BIGINT(7) NOT NULL  ,
   PERNAME VARCHAR(100) NOT NULL  ,
   PERSURNAME VARCHAR(100) NOT NULL  ,
   PEREMAIL VARCHAR(255) NOT NULL  ,
   PERBIRTHDATE DATE NULL  ,
   PERCREATIONDATE DATE NOT NULL  
   , PRIMARY KEY (ID_PERSON) 
   , UNIQUE INDEX AK_PERSON (PEREMAIL) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : VERSION
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS VERSION
 (
   ID_VERSION BIGINT(7) NOT NULL  ,
   ID_ENGINE BIGINT(7) NOT NULL  ,
   ID_PRODUCT BIGINT(7) NOT NULL  ,
   VERNAME VARCHAR(128) NOT NULL  ,
   VERCHANGELOG VARCHAR(1000) NULL  ,
   VERRELEASEDATE DATE NOT NULL  ,
   VERISMAJOR BOOL NULL  
   , PRIMARY KEY (ID_VERSION) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE VERSION
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_VERSION_GAME
     ON VERSION (ID_PRODUCT ASC);

CREATE  INDEX I_FK_VERSION_ENGINE
     ON VERSION (ID_ENGINE ASC);

# -----------------------------------------------------------------------------
#       TABLE : SPECIFICATION
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS SPECIFICATION
 (
   ID_SPECIFICATION BIGINT(7) NOT NULL  ,
   SPEOSVERSION VARCHAR(50) NULL  ,
   SPECPU VARCHAR(150) NULL  ,
   SPEMEMORY VARCHAR(20) NULL  ,
   SPEGPU VARCHAR(150) NULL  ,
   SPEDIRECTX VARCHAR(100) NULL  ,
   SPEADDITIONALNOTES VARCHAR(255) NULL  ,
   SPETYPE VARCHAR(50) NULL  ,
   SPESTORAGE VARCHAR(30) NULL  
   , PRIMARY KEY (ID_SPECIFICATION) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : PAYMENTMETHOD
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PAYMENTMETHOD
 (
   ID_PAYMENTMETHOD BIGINT(7) NOT NULL  ,
   PAYNAME VARCHAR(50) NOT NULL  ,
   PAYENABLED BOOL NULL  ,
   PAYFEEPERCENT DECIMAL(3,2) NULL  
      DEFAULT 0
   , PRIMARY KEY (ID_PAYMENTMETHOD) 
   , UNIQUE INDEX AK_PAYMENTMETHOD (PAYNAME) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : SUPPORTTICKET
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS SUPPORTTICKET
 (
   ID_SUPPORTTICKET BIGINT(7) NOT NULL  ,
   ID_SUPPORTCATEGORY BIGINT(7) NOT NULL  ,
   ID_PERSON BIGINT(7) NOT NULL  ,
   SUPSUBJECT VARCHAR(150) NOT NULL  ,
   SUPDESCRIPTION VARCHAR(1000) NOT NULL  ,
   SUPCREATEDAT DATE NOT NULL  ,
   SUPCLOSEDAT DATE NOT NULL  
   , PRIMARY KEY (ID_SUPPORTTICKET) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE SUPPORTTICKET
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_SUPPORTTICKET_USER
     ON SUPPORTTICKET (ID_PERSON ASC);

CREATE  INDEX I_FK_SUPPORTTICKET_SUPPORTCATEGORY
     ON SUPPORTTICKET (ID_SUPPORTCATEGORY ASC);

# -----------------------------------------------------------------------------
#       TABLE : DLC
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS DLC
 (
   ID_PRODUCT BIGINT(7) NOT NULL  ,
   ID_GAME BIGINT(7) NOT NULL  ,
   DLCBASEGAMEREQUIRED BOOL NOT NULL  
   , PRIMARY KEY (ID_PRODUCT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE DLC
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_DLC_GAME
     ON DLC (ID_GAME ASC);

# -----------------------------------------------------------------------------
#       TABLE : ENGINE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ENGINE
 (
   ID_ENGINE BIGINT(7) NOT NULL  ,
   ENGNAME VARCHAR(128) NOT NULL  
   , PRIMARY KEY (ID_ENGINE) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : SUBSCRIPTION
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS SUBSCRIPTION
 (
   ID_PRODUCT BIGINT(7) NOT NULL  
   , PRIMARY KEY (ID_PRODUCT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : PRODUCT
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PRODUCT
 (
   ID_PRODUCT BIGINT(7) NOT NULL  ,
   PROTITLE VARCHAR(150) NOT NULL  ,
   PRODESCRIPTION VARCHAR(1000) NULL  ,
   PRORELEASEDATE DATE NOT NULL  ,
   PROPRICE DECIMAL(10,2) NOT NULL  ,
   PRODISCOUNT DECIMAL(3,2) NULL  
      DEFAULT 0,
   PROREWARDPERCENTAGE INTEGER NULL  ,
   PROREFUNDABLE BOOL NOT NULL  
   , PRIMARY KEY (ID_PRODUCT) 
   , UNIQUE INDEX AK_PRODUCT (PROTITLE) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : NEW
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS NEW
 (
   ID_NEW BIGINT(7) NOT NULL  ,
   ID_PERSON BIGINT(7) NOT NULL  ,
   NEWTITLE VARCHAR(150) NOT NULL  ,
   NEWCONTENT CHAR(10000) NOT NULL  ,
   NEWPUBLISHEDAT DATE NOT NULL  
   , PRIMARY KEY (ID_NEW) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE NEW
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_NEW_CONTRIBUTOR
     ON NEW (ID_PERSON ASC);

# -----------------------------------------------------------------------------
#       TABLE : COLLECTION
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS COLLECTION
 (
   ID_COLLECTION BIGINT(7) NOT NULL  ,
   ID_USER BIGINT(7) NOT NULL  ,
   COLNAME VARCHAR(100) NOT NULL  
   , PRIMARY KEY (ID_COLLECTION) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE COLLECTION
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_COLLECTION_USER
     ON COLLECTION (ID_USER ASC);

# -----------------------------------------------------------------------------
#       TABLE : GENRE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS GENRE
 (
   ID_GENRE BIGINT(7) NOT NULL  ,
   GENNAME VARCHAR(50) NOT NULL  
   , PRIMARY KEY (ID_GENRE) 
   , UNIQUE INDEX AK_GENRE (GENNAME) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : LANGUAGE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS LANGUAGE
 (
   ID_LANGUAGE BIGINT(7) NOT NULL  ,
   LANCODE VARCHAR(10) NOT NULL  ,
   LANNAME VARCHAR(128) NULL  
   , PRIMARY KEY (ID_LANGUAGE) 
   , UNIQUE INDEX AK_LANGUAGE (LANCODE) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : BUNDLE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS BUNDLE
 (
   ID_PRODUCT BIGINT(7) NOT NULL  
   , PRIMARY KEY (ID_PRODUCT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : DEVELOPER
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS DEVELOPER
 (
   ID_PERSON BIGINT(7) NOT NULL  
   , PRIMARY KEY (ID_PERSON) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : ADRESS
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ADRESS
 (
   ID_ADRESS BIGINT(7) NOT NULL  ,
   ID_PERSON BIGINT(7) NOT NULL  ,
   ADRSTREET VARCHAR(100) NULL  ,
   ADRPOSTALCODE VARCHAR(20) NULL  ,
   ADRCITY VARCHAR(100) NULL  ,
   ADRCOUNTRY VARCHAR(60) NOT NULL  
   , PRIMARY KEY (ID_ADRESS) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE ADRESS
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_ADRESS_PERSON
     ON ADRESS (ID_PERSON ASC);

# -----------------------------------------------------------------------------
#       TABLE : TICKETMESSAGE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS TICKETMESSAGE
 (
   ID_TICKETMESSAGE BIGINT(7) NOT NULL  ,
   ID_SUPPORTTICKET BIGINT(7) NOT NULL  ,
   ID_STAFF BIGINT(7) NOT NULL  ,
   ID_USER BIGINT(7) NOT NULL  ,
   TICMESSAGE VARCHAR(500) NOT NULL  
   , PRIMARY KEY (ID_TICKETMESSAGE) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE TICKETMESSAGE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_TICKETMESSAGE_SUPPORTTICKET
     ON TICKETMESSAGE (ID_SUPPORTTICKET ASC);

CREATE  INDEX I_FK_TICKETMESSAGE_USER
     ON TICKETMESSAGE (ID_USER ASC);

CREATE  INDEX I_FK_TICKETMESSAGE_STAFF
     ON TICKETMESSAGE (ID_STAFF ASC);

# -----------------------------------------------------------------------------
#       TABLE : ACHIEVEMENT
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ACHIEVEMENT
 (
   ID_ACHIEVEMENT BIGINT(7) NOT NULL  ,
   ID_PRODUCT BIGINT(7) NOT NULL  ,
   ACHTITLE VARCHAR(100) NOT NULL  ,
   ACHDESCRIPTION VARCHAR(255) NULL  ,
   ACHISHIDDEN BOOL NOT NULL  ,
   ACHXPREWARD BIGINT(4) NOT NULL  
   , PRIMARY KEY (ID_ACHIEVEMENT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE ACHIEVEMENT
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_ACHIEVEMENT_GAME
     ON ACHIEVEMENT (ID_PRODUCT ASC);

# -----------------------------------------------------------------------------
#       TABLE : PROJECT
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PROJECT
 (
   ID_PROJECT BIGINT(7) NOT NULL  ,
   ID_ENGINE BIGINT(7) NOT NULL  ,
   PRONAME VARCHAR(128) NOT NULL  ,
   PRODESCRIPTION CHAR(255) NULL  
   , PRIMARY KEY (ID_PROJECT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE PROJECT
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_PROJECT_ENGINE
     ON PROJECT (ID_ENGINE ASC);

# -----------------------------------------------------------------------------
#       TABLE : RESOURCE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS RESOURCE
 (
   ID_RESOURCE BIGINT(7) NOT NULL  ,
   ID_PRODUCT BIGINT(7) NOT NULL  ,
   ID_NEW BIGINT(7) NULL  ,
   ID_ACHIEVEMENT BIGINT(7) NULL  ,
   ID_RESOURCETYPE BIGINT(7) NOT NULL  ,
   RESNAME VARCHAR(128) NOT NULL  ,
   RESPATH VARCHAR(255) NOT NULL  
   , PRIMARY KEY (ID_RESOURCE) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE RESOURCE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_RESOURCE_PRODUCT
     ON RESOURCE (ID_PRODUCT ASC);

CREATE  INDEX I_FK_RESOURCE_NEW
     ON RESOURCE (ID_NEW ASC);

CREATE  INDEX I_FK_RESOURCE_ACHIEVEMENT
     ON RESOURCE (ID_ACHIEVEMENT ASC);

CREATE  INDEX I_FK_RESOURCE_RESOURCETYPE
     ON RESOURCE (ID_RESOURCETYPE ASC);

# -----------------------------------------------------------------------------
#       TABLE : LIBRARYITEM
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS LIBRARYITEM
 (
   ID_PERSON BIGINT(7) NOT NULL  ,
   ID_PRODUCT BIGINT(7) NOT NULL  ,
   LIFAVOURITED BOOL NOT NULL  ,
   LIREVIEW VARCHAR(500) NULL  
   , PRIMARY KEY (ID_PERSON,ID_PRODUCT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE LIBRARYITEM
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_LIBRARYITEM_USER
     ON LIBRARYITEM (ID_PERSON ASC);

CREATE  INDEX I_FK_LIBRARYITEM_PRODUCT
     ON LIBRARYITEM (ID_PRODUCT ASC);

# -----------------------------------------------------------------------------
#       TABLE : DEVELOPER_PROJECT
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS DEVELOPER_PROJECT
 (
   ID_PERSON BIGINT(7) NOT NULL  ,
   ID_PROJECT BIGINT(7) NOT NULL  
   , PRIMARY KEY (ID_PERSON,ID_PROJECT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE DEVELOPER_PROJECT
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_DEVELOPER_PROJECT_DEVELOPER
     ON DEVELOPER_PROJECT (ID_PERSON ASC);

CREATE  INDEX I_FK_DEVELOPER_PROJECT_PROJECT
     ON DEVELOPER_PROJECT (ID_PROJECT ASC);

# -----------------------------------------------------------------------------
#       TABLE : GAME_GENRE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS GAME_GENRE
 (
   ID_PRODUCT BIGINT(7) NOT NULL  ,
   ID_GENRE BIGINT(7) NOT NULL  
   , PRIMARY KEY (ID_PRODUCT,ID_GENRE) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE GAME_GENRE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_GAME_GENRE_GAME
     ON GAME_GENRE (ID_PRODUCT ASC);

CREATE  INDEX I_FK_GAME_GENRE_GENRE
     ON GAME_GENRE (ID_GENRE ASC);

# -----------------------------------------------------------------------------
#       TABLE : FRIEND
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS FRIEND
 (
   ID_USER BIGINT(7) NOT NULL  ,
   ID_FRIEND BIGINT(7) NOT NULL  
   , PRIMARY KEY (ID_USER,ID_FRIEND) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE FRIEND
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_FRIEND_USER
     ON FRIEND (ID_USER ASC);

CREATE  INDEX I_FK_FRIEND_USER1
     ON FRIEND (ID_FRIEND ASC);

# -----------------------------------------------------------------------------
#       TABLE : COLLECTION_GAME
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS COLLECTION_GAME
 (
   ID_COLLECTION BIGINT(7) NOT NULL  ,
   ID_PRODUCT BIGINT(7) NOT NULL  
   , PRIMARY KEY (ID_COLLECTION,ID_PRODUCT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE COLLECTION_GAME
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_COLLECTION_GAME_COLLECTION
     ON COLLECTION_GAME (ID_COLLECTION ASC);

CREATE  INDEX I_FK_COLLECTION_GAME_GAME
     ON COLLECTION_GAME (ID_PRODUCT ASC);

# -----------------------------------------------------------------------------
#       TABLE : GAME_FEATURE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS GAME_FEATURE
 (
   ID_FEATURE BIGINT(7) NOT NULL  ,
   ID_PRODUCT BIGINT(7) NOT NULL  
   , PRIMARY KEY (ID_FEATURE,ID_PRODUCT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE GAME_FEATURE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_GAME_FEATURE_FEATURE
     ON GAME_FEATURE (ID_FEATURE ASC);

CREATE  INDEX I_FK_GAME_FEATURE_GAME
     ON GAME_FEATURE (ID_PRODUCT ASC);

# -----------------------------------------------------------------------------
#       TABLE : CARTITEM
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CARTITEM
 (
   ID_PERSON BIGINT(7) NOT NULL  ,
   ID_PRODUCT BIGINT(7) NOT NULL  
   , PRIMARY KEY (ID_PERSON,ID_PRODUCT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE CARTITEM
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_CARTITEM_USER
     ON CARTITEM (ID_PERSON ASC);

CREATE  INDEX I_FK_CARTITEM_PRODUCT
     ON CARTITEM (ID_PRODUCT ASC);

# -----------------------------------------------------------------------------
#       TABLE : USER_ACHIEVEMENT
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS USER_ACHIEVEMENT
 (
   ID_PERSON BIGINT(7) NOT NULL  ,
   ID_ACHIEVEMENT BIGINT(7) NOT NULL  
   , PRIMARY KEY (ID_PERSON,ID_ACHIEVEMENT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE USER_ACHIEVEMENT
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_USER_ACHIEVEMENT_USER
     ON USER_ACHIEVEMENT (ID_PERSON ASC);

CREATE  INDEX I_FK_USER_ACHIEVEMENT_ACHIEVEMENT
     ON USER_ACHIEVEMENT (ID_ACHIEVEMENT ASC);

# -----------------------------------------------------------------------------
#       TABLE : GAME_SPECIFICATION
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS GAME_SPECIFICATION
 (
   ID_PRODUCT BIGINT(7) NOT NULL  ,
   ID_SPECIFICATION BIGINT(7) NOT NULL  
   , PRIMARY KEY (ID_PRODUCT,ID_SPECIFICATION) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE GAME_SPECIFICATION
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_GAME_SPECIFICATION_GAME
     ON GAME_SPECIFICATION (ID_PRODUCT ASC);

CREATE  INDEX I_FK_GAME_SPECIFICATION_SPECIFICATION
     ON GAME_SPECIFICATION (ID_SPECIFICATION ASC);

# -----------------------------------------------------------------------------
#       TABLE : GAME_PLATFORM
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS GAME_PLATFORM
 (
   ID_PRODUCT BIGINT(7) NOT NULL  ,
   ID_PLATFORM BIGINT(7) NOT NULL  
   , PRIMARY KEY (ID_PRODUCT,ID_PLATFORM) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE GAME_PLATFORM
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_GAME_PLATFORM_GAME
     ON GAME_PLATFORM (ID_PRODUCT ASC);

CREATE  INDEX I_FK_GAME_PLATFORM_PLATFORM
     ON GAME_PLATFORM (ID_PLATFORM ASC);

# -----------------------------------------------------------------------------
#       TABLE : PURCHASEITEM
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PURCHASEITEM
 (
   ID_PURCHASE BIGINT(7) NOT NULL  ,
   ID_PRODUCT BIGINT(7) NOT NULL  ,
   PIPRICE DECIMAL(10,2) NOT NULL  
   , PRIMARY KEY (ID_PURCHASE,ID_PRODUCT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE PURCHASEITEM
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_PURCHASEITEM_PURCHASE
     ON PURCHASEITEM (ID_PURCHASE ASC);

CREATE  INDEX I_FK_PURCHASEITEM_PRODUCT
     ON PURCHASEITEM (ID_PRODUCT ASC);

# -----------------------------------------------------------------------------
#       TABLE : WISHLISTITEM
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS WISHLISTITEM
 (
   ID_PERSON BIGINT(7) NOT NULL  ,
   ID_PRODUCT BIGINT(7) NOT NULL  
   , PRIMARY KEY (ID_PERSON,ID_PRODUCT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE WISHLISTITEM
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_WISHLISTITEM_USER
     ON WISHLISTITEM (ID_PERSON ASC);

CREATE  INDEX I_FK_WISHLISTITEM_PRODUCT
     ON WISHLISTITEM (ID_PRODUCT ASC);


# -----------------------------------------------------------------------------
#       CREATION DES REFERENCES DE TABLE
# -----------------------------------------------------------------------------


ALTER TABLE GAME 
  ADD FOREIGN KEY FK_GAME_PUBLISHER (ID_PUBLISHER)
      REFERENCES PUBLISHER (ID_PERSON) ;


ALTER TABLE GAME 
  ADD FOREIGN KEY FK_GAME_DEVELOPER (ID_DEVELOPER)
      REFERENCES DEVELOPER (ID_PERSON) ;


ALTER TABLE GAME 
  ADD FOREIGN KEY FK_GAME_PRODUCT (ID_PRODUCT)
      REFERENCES PRODUCT (ID_PRODUCT) ;


ALTER TABLE STAFF 
  ADD FOREIGN KEY FK_STAFF_PERSON (ID_PERSON)
      REFERENCES PERSON (ID_PERSON) ;


ALTER TABLE USER 
  ADD FOREIGN KEY FK_USER_LANGUAGE (ID_LANGUAGE)
      REFERENCES LANGUAGE (ID_LANGUAGE) ;


ALTER TABLE USER 
  ADD FOREIGN KEY FK_USER_PERSON (ID_PERSON)
      REFERENCES PERSON (ID_PERSON) ;


ALTER TABLE PUBLISHER 
  ADD FOREIGN KEY FK_PUBLISHER_PERSON (ID_PERSON)
      REFERENCES PERSON (ID_PERSON) ;


ALTER TABLE REDEEMCODE 
  ADD FOREIGN KEY FK_REDEEMCODE_PRODUCT (ID_PRODUCT)
      REFERENCES PRODUCT (ID_PRODUCT) ;


ALTER TABLE CONTRIBUTOR 
  ADD FOREIGN KEY FK_CONTRIBUTOR_PERSON (ID_PERSON)
      REFERENCES PERSON (ID_PERSON) ;


ALTER TABLE PURCHASE 
  ADD FOREIGN KEY FK_PURCHASE_USER (ID_PERSON)
      REFERENCES USER (ID_PERSON) ;


ALTER TABLE PURCHASE 
  ADD FOREIGN KEY FK_PURCHASE_PAYMENTMETHOD (ID_PAYMENTMETHOD)
      REFERENCES PAYMENTMETHOD (ID_PAYMENTMETHOD) ;


ALTER TABLE VERSION 
  ADD FOREIGN KEY FK_VERSION_GAME (ID_PRODUCT)
      REFERENCES GAME (ID_PRODUCT) ;


ALTER TABLE VERSION 
  ADD FOREIGN KEY FK_VERSION_ENGINE (ID_ENGINE)
      REFERENCES ENGINE (ID_ENGINE) ;


ALTER TABLE SUPPORTTICKET 
  ADD FOREIGN KEY FK_SUPPORTTICKET_USER (ID_PERSON)
      REFERENCES USER (ID_PERSON) ;


ALTER TABLE SUPPORTTICKET 
  ADD FOREIGN KEY FK_SUPPORTTICKET_SUPPORTCATEGORY (ID_SUPPORTCATEGORY)
      REFERENCES SUPPORTCATEGORY (ID_SUPPORTCATEGORY) ;


ALTER TABLE DLC 
  ADD FOREIGN KEY FK_DLC_GAME (ID_GAME)
      REFERENCES GAME (ID_PRODUCT) ;


ALTER TABLE DLC 
  ADD FOREIGN KEY FK_DLC_PRODUCT (ID_PRODUCT)
      REFERENCES PRODUCT (ID_PRODUCT) ;


ALTER TABLE SUBSCRIPTION 
  ADD FOREIGN KEY FK_SUBSCRIPTION_PRODUCT (ID_PRODUCT)
      REFERENCES PRODUCT (ID_PRODUCT) ;


ALTER TABLE NEW 
  ADD FOREIGN KEY FK_NEW_CONTRIBUTOR (ID_PERSON)
      REFERENCES CONTRIBUTOR (ID_PERSON) ;


ALTER TABLE COLLECTION 
  ADD FOREIGN KEY FK_COLLECTION_USER (ID_USER)
      REFERENCES USER (ID_PERSON) ;


ALTER TABLE BUNDLE 
  ADD FOREIGN KEY FK_BUNDLE_PRODUCT (ID_PRODUCT)
      REFERENCES PRODUCT (ID_PRODUCT) ;


ALTER TABLE DEVELOPER 
  ADD FOREIGN KEY FK_DEVELOPER_PERSON (ID_PERSON)
      REFERENCES PERSON (ID_PERSON) ;


ALTER TABLE ADRESS 
  ADD FOREIGN KEY FK_ADRESS_PERSON (ID_PERSON)
      REFERENCES PERSON (ID_PERSON) ;


ALTER TABLE TICKETMESSAGE 
  ADD FOREIGN KEY FK_TICKETMESSAGE_SUPPORTTICKET (ID_SUPPORTTICKET)
      REFERENCES SUPPORTTICKET (ID_SUPPORTTICKET) ;


ALTER TABLE TICKETMESSAGE 
  ADD FOREIGN KEY FK_TICKETMESSAGE_USER (ID_USER)
      REFERENCES USER (ID_PERSON) ;


ALTER TABLE TICKETMESSAGE 
  ADD FOREIGN KEY FK_TICKETMESSAGE_STAFF (ID_STAFF)
      REFERENCES STAFF (ID_PERSON) ;


ALTER TABLE ACHIEVEMENT 
  ADD FOREIGN KEY FK_ACHIEVEMENT_GAME (ID_PRODUCT)
      REFERENCES GAME (ID_PRODUCT) ;


ALTER TABLE PROJECT 
  ADD FOREIGN KEY FK_PROJECT_ENGINE (ID_ENGINE)
      REFERENCES ENGINE (ID_ENGINE) ;


ALTER TABLE RESOURCE 
  ADD FOREIGN KEY FK_RESOURCE_PRODUCT (ID_PRODUCT)
      REFERENCES PRODUCT (ID_PRODUCT) ;


ALTER TABLE RESOURCE 
  ADD FOREIGN KEY FK_RESOURCE_NEW (ID_NEW)
      REFERENCES NEW (ID_NEW) ;


ALTER TABLE RESOURCE 
  ADD FOREIGN KEY FK_RESOURCE_ACHIEVEMENT (ID_ACHIEVEMENT)
      REFERENCES ACHIEVEMENT (ID_ACHIEVEMENT) ;


ALTER TABLE RESOURCE 
  ADD FOREIGN KEY FK_RESOURCE_RESOURCETYPE (ID_RESOURCETYPE)
      REFERENCES RESOURCETYPE (ID_RESOURCETYPE) ;


ALTER TABLE LIBRARYITEM 
  ADD FOREIGN KEY FK_LIBRARYITEM_USER (ID_PERSON)
      REFERENCES USER (ID_PERSON) ;


ALTER TABLE LIBRARYITEM 
  ADD FOREIGN KEY FK_LIBRARYITEM_PRODUCT (ID_PRODUCT)
      REFERENCES PRODUCT (ID_PRODUCT) ;


ALTER TABLE DEVELOPER_PROJECT 
  ADD FOREIGN KEY FK_DEVELOPER_PROJECT_DEVELOPER (ID_PERSON)
      REFERENCES DEVELOPER (ID_PERSON) ;


ALTER TABLE DEVELOPER_PROJECT 
  ADD FOREIGN KEY FK_DEVELOPER_PROJECT_PROJECT (ID_PROJECT)
      REFERENCES PROJECT (ID_PROJECT) ;


ALTER TABLE GAME_GENRE 
  ADD FOREIGN KEY FK_GAME_GENRE_GAME (ID_PRODUCT)
      REFERENCES GAME (ID_PRODUCT) ;


ALTER TABLE GAME_GENRE 
  ADD FOREIGN KEY FK_GAME_GENRE_GENRE (ID_GENRE)
      REFERENCES GENRE (ID_GENRE) ;


ALTER TABLE FRIEND 
  ADD FOREIGN KEY FK_FRIEND_USER (ID_USER)
      REFERENCES USER (ID_PERSON) ;


ALTER TABLE FRIEND 
  ADD FOREIGN KEY FK_FRIEND_USER2 (ID_FRIEND)
      REFERENCES USER (ID_PERSON) ;


ALTER TABLE COLLECTION_GAME 
  ADD FOREIGN KEY FK_COLLECTION_GAME_COLLECTION (ID_COLLECTION)
      REFERENCES COLLECTION (ID_COLLECTION) ;


ALTER TABLE COLLECTION_GAME 
  ADD FOREIGN KEY FK_COLLECTION_GAME_GAME (ID_PRODUCT)
      REFERENCES GAME (ID_PRODUCT) ;


ALTER TABLE GAME_FEATURE 
  ADD FOREIGN KEY FK_GAME_FEATURE_FEATURE (ID_FEATURE)
      REFERENCES FEATURE (ID_FEATURE) ;


ALTER TABLE GAME_FEATURE 
  ADD FOREIGN KEY FK_GAME_FEATURE_GAME (ID_PRODUCT)
      REFERENCES GAME (ID_PRODUCT) ;


ALTER TABLE CARTITEM 
  ADD FOREIGN KEY FK_CARTITEM_USER (ID_PERSON)
      REFERENCES USER (ID_PERSON) ;


ALTER TABLE CARTITEM 
  ADD FOREIGN KEY FK_CARTITEM_PRODUCT (ID_PRODUCT)
      REFERENCES PRODUCT (ID_PRODUCT) ;


ALTER TABLE USER_ACHIEVEMENT 
  ADD FOREIGN KEY FK_USER_ACHIEVEMENT_USER (ID_PERSON)
      REFERENCES USER (ID_PERSON) ;


ALTER TABLE USER_ACHIEVEMENT 
  ADD FOREIGN KEY FK_USER_ACHIEVEMENT_ACHIEVEMENT (ID_ACHIEVEMENT)
      REFERENCES ACHIEVEMENT (ID_ACHIEVEMENT) ;


ALTER TABLE GAME_SPECIFICATION 
  ADD FOREIGN KEY FK_GAME_SPECIFICATION_GAME (ID_PRODUCT)
      REFERENCES GAME (ID_PRODUCT) ;


ALTER TABLE GAME_SPECIFICATION 
  ADD FOREIGN KEY FK_GAME_SPECIFICATION_SPECIFICATION (ID_SPECIFICATION)
      REFERENCES SPECIFICATION (ID_SPECIFICATION) ;


ALTER TABLE GAME_PLATFORM 
  ADD FOREIGN KEY FK_GAME_PLATFORM_GAME (ID_PRODUCT)
      REFERENCES GAME (ID_PRODUCT) ;


ALTER TABLE GAME_PLATFORM 
  ADD FOREIGN KEY FK_GAME_PLATFORM_PLATFORM (ID_PLATFORM)
      REFERENCES PLATFORM (ID_PLATFORM) ;


ALTER TABLE PURCHASEITEM 
  ADD FOREIGN KEY FK_PURCHASEITEM_PURCHASE (ID_PURCHASE)
      REFERENCES PURCHASE (ID_PURCHASE) ;


ALTER TABLE PURCHASEITEM 
  ADD FOREIGN KEY FK_PURCHASEITEM_PRODUCT (ID_PRODUCT)
      REFERENCES PRODUCT (ID_PRODUCT) ;


ALTER TABLE WISHLISTITEM 
  ADD FOREIGN KEY FK_WISHLISTITEM_USER (ID_PERSON)
      REFERENCES USER (ID_PERSON) ;


ALTER TABLE WISHLISTITEM 
  ADD FOREIGN KEY FK_WISHLISTITEM_PRODUCT (ID_PRODUCT)
      REFERENCES PRODUCT (ID_PRODUCT) ;

