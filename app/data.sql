BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "conservation" (
	"id"	INTEGER,
	"depots"	TEXT,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "etats" (
	"id"	INTEGER,
	"etats"	TEXT,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "matieres" (
	"id"	INTEGER,
	"matieres"	TEXT,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "types" (
	"id"	INTEGER,
	"types"	TEXT,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "signataires" (
	"id"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"signataire"	TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "actes" (
	"id"	INTEGER,
	"cote"	TEXT NOT NULL,
	"annee"	TEXT NOT NULL,
	"date_temps"	TEXT NOT NULL,
	"date_lieu"	TEXT,
	"hauteur"	INTEGER,
	"largeur"	INTEGER,
	"repli"	INTEGER,
	"regeste"	TEXT,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "conserveDans" (
	"acteid"	INTEGER NOT NULL,
	"depotid"	INTEGER NOT NULL,
	FOREIGN KEY("depotid") REFERENCES "conservation"("id"),
	FOREIGN KEY("acteid") REFERENCES "actes"("id")
);
CREATE TABLE IF NOT EXISTS "possedeSignataire" (
	"acteid"	INTEGER NOT NULL,
	"signataireid"	INTEGER NOT NULL,
	FOREIGN KEY("acteid") REFERENCES "actes"("id"),
	FOREIGN KEY("signataireid") REFERENCES "signataires"("id")
);
CREATE TABLE IF NOT EXISTS "possedeMatiere" (
	"acteid"	INTEGER NOT NULL,
	"matiereid"	INTEGER NOT NULL,
	FOREIGN KEY("acteid") REFERENCES "actes"("id"),
	FOREIGN KEY("matiereid") REFERENCES "matieres"("id")
);
CREATE TABLE IF NOT EXISTS "possedeType" (
	"acteid"	INTEGER NOT NULL,
	"typeid"	INTEGER NOT NULL,
	FOREIGN KEY("typeid") REFERENCES "types"("id"),
	FOREIGN KEY("acteid") REFERENCES "actes"("id")
);
CREATE TABLE IF NOT EXISTS "possedeEtat" (
	"acteid"	INTEGER NOT NULL,
	"etatid"	INTEGER NOT NULL,
	FOREIGN KEY("etatid") REFERENCES "etats"("id"),
	FOREIGN KEY("acteid") REFERENCES "actes"("id")
);
INSERT INTO "conservation" VALUES (1,'Archives départementales du Tarn');
INSERT INTO "conservation" VALUES (2,'Archives municipales de Saint-Flour');
INSERT INTO "conservation" VALUES (3,'Archives nationales');
INSERT INTO "conservation" VALUES (4,'Archives départementales de la Côte-d’Or');
INSERT INTO "conservation" VALUES (5,'Bibliothèque nationale de France');
INSERT INTO "conservation" VALUES (6,'Archives municipales de Lyon');
INSERT INTO "conservation" VALUES (7,'Archives municipales de Riom');
INSERT INTO "conservation" VALUES (8,'Archives départementales du Puy-de-Dôme');
INSERT INTO "conservation" VALUES (9,'Archives municipales de Villefranche-sur-Saône');
INSERT INTO "conservation" VALUES (10,'Archives départementales de la Loire-Atlantique');
INSERT INTO "conservation" VALUES (11,'Archives municipales de Moulins');
INSERT INTO "etats" VALUES (1,'original');
INSERT INTO "etats" VALUES (2,'copie');
INSERT INTO "etats" VALUES (3,'minute');
INSERT INTO "etats" VALUES (4,'deperditum');
INSERT INTO "matieres" VALUES (1,'Famille_ducale');
INSERT INTO "matieres" VALUES (2,'Finances');
INSERT INTO "matieres" VALUES (3,'Bourbonnais');
INSERT INTO "matieres" VALUES (4,'Auvergne');
INSERT INTO "matieres" VALUES (5,'Forez');
INSERT INTO "matieres" VALUES (6,'Beujolais');
INSERT INTO "matieres" VALUES (7,'Fondation_pieuse');
INSERT INTO "matieres" VALUES (8,'Royaume');
INSERT INTO "types" VALUES (1,'charte');
INSERT INTO "types" VALUES (2,'lettre patente');
INSERT INTO "types" VALUES (3,'mandement');
INSERT INTO "types" VALUES (4,'lettre close');
INSERT INTO "signataires" VALUES (1,'Charles ier');
INSERT INTO "signataires" VALUES (2,'Agnes de Bourgogne');
INSERT INTO "signataires" VALUES (3,'Etienne Gort');
INSERT INTO "signataires" VALUES (4,'Etienne de Bar');
INSERT INTO "signataires" VALUES (5,'Laurent Andraut');
INSERT INTO "signataires" VALUES (6,'Jean Trichon');
INSERT INTO "signataires" VALUES (7,'Guillaume Cadier');
INSERT INTO "signataires" VALUES (8,'Jean Breneal');
INSERT INTO "actes" VALUES (1,'CC 176','1421','[Avant le 15 janvier 1421 (n. st.)]',NULL,NULL,NULL,NULL,'Lettre close à la ville d’Albi.');
INSERT INTO "actes" VALUES (2,'ch. XI, art. 2., n°32','1421','[Avant le 18 janvier 1421 (n. st.)]',NULL,NULL,NULL,NULL,'Lettre close aux villes d’Auvergne.');
INSERT INTO "actes" VALUES (3,'P 1370/2, c. 1919','1425','4 février 1425',NULL,600,830,70,'Contrat de mariage entre Charles, fils du duc de Bourbon, et Agnès, soeur du duc de Bourgogne.');
INSERT INTO "actes" VALUES (4,'B 297, PS 316','1425','7 février 1425','Autun',325,160,55,'Marie de Berry et Charles de Clermont promettent de respecter les engagements de Jean Ier.');
INSERT INTO "actes" VALUES (5,'B 299, PS 319','1425','6 août 1425',NULL,430,270,20,'Ratification par Charles de Bourbon et Agnès de Bourgogne du traité conclu pour leur mariage.');
INSERT INTO "conserveDans" VALUES (1,1);
INSERT INTO "conserveDans" VALUES (2,2);
INSERT INTO "conserveDans" VALUES (3,3);
INSERT INTO "conserveDans" VALUES (4,4);
INSERT INTO "conserveDans" VALUES (5,4);
INSERT INTO "possedeSignataire" VALUES (1,1);
INSERT INTO "possedeSignataire" VALUES (1,1);
INSERT INTO "possedeSignataire" VALUES (3,5);
INSERT INTO "possedeSignataire" VALUES (4,3);
INSERT INTO "possedeSignataire" VALUES (5,8);
INSERT INTO "possedeMatiere" VALUES (1,8);
INSERT INTO "possedeMatiere" VALUES (2,8);
INSERT INTO "possedeMatiere" VALUES (3,1);
INSERT INTO "possedeMatiere" VALUES (4,8);
INSERT INTO "possedeMatiere" VALUES (5,1);
INSERT INTO "possedeType" VALUES (1,4);
INSERT INTO "possedeType" VALUES (1,4);
INSERT INTO "possedeType" VALUES (3,2);
INSERT INTO "possedeType" VALUES (4,2);
INSERT INTO "possedeType" VALUES (5,2);
INSERT INTO "possedeEtat" VALUES (1,4);
INSERT INTO "possedeEtat" VALUES (2,4);
INSERT INTO "possedeEtat" VALUES (3,1);
INSERT INTO "possedeEtat" VALUES (4,1);
INSERT INTO "possedeEtat" VALUES (5,1);
COMMIT;
