BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "depots" (
	"id_depots"	INTEGER,
	"depots"	TEXT,
	PRIMARY KEY("id_depots")
);
CREATE TABLE IF NOT EXISTS "actes" (
	"id_acte"	INTEGER,
	"actes_id_depots"	INTEGER,
	"cote"	TEXT,
	"annee"	TEXT,
	"date_temps"	TEXT,
	"date_lieu"	TEXT NOT NULL,
	"regeste"	TEXT,
	"etatActe"	INTEGER,
	"typeActe"	INTEGER,
	"hauteur"	TEXT NOT NULL,
	"largeur"	TEXT NOT NULL,
	"repli"	TEXT NOT NULL,
	FOREIGN KEY("actes_id_depots") REFERENCES "depots"("id_depots"),
	FOREIGN KEY("typeActe") REFERENCES "types"("id"),
	FOREIGN KEY("etatActe") REFERENCES "etats"("id"),
	PRIMARY KEY("id_acte")
);
CREATE TABLE IF NOT EXISTS "signataires" (
	"id"	INTEGER,
	"nom_signataire"	TEXT NOT NULL,
	"prenom_signataire"	TEXT NOT NULL,
	"fromdate"	TEXT,
	"todate"	TEXT NOT NULL,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "types" (
	"id"	INTEGER,
	"type"	TEXT,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "etats" (
	"id"	INTEGER,
	"etat"	TEXT,
	PRIMARY KEY("id")
);
INSERT INTO "depots" VALUES (1,'Archives départementales du Tarn');
INSERT INTO "depots" VALUES (2,'Archives municipales de Saint-Flour');
INSERT INTO "depots" VALUES (3,'Archives nationales');
INSERT INTO "depots" VALUES (4,'Archives départementales de la Côte-d’Or');
INSERT INTO "depots" VALUES (5,'Bibliothèque nationale de France');
INSERT INTO "depots" VALUES (6,'Archives municipales de Lyon');
INSERT INTO "depots" VALUES (7,'Archives municipales de Riom');
INSERT INTO "depots" VALUES (8,'Archives départementales du Puy-de-Dôme');
INSERT INTO "depots" VALUES (9,'Archives municipales de Villefranche-sur-Saône');
INSERT INTO "depots" VALUES (10,'Archives départementales de la Loire-Atlantique');
INSERT INTO "depots" VALUES (11,'Archives municipales de Moulins');
INSERT INTO "actes" VALUES (1,1,'CC 176, f. 27r','1421','[Avant le 15 janvier 1421]','','Lettre close à la ville d’Albi',4,4,'','','');
INSERT INTO "actes" VALUES (2,2,'ch. XI, art. 2., n°32, f. 43v','1421','[Avant le 18 janvier 1421]','','Lettre close aux villes d’Auvergne',4,4,'','','');
INSERT INTO "actes" VALUES (3,3,'P 1370/2, c. 1919','1425','4 février 1425','','Traité de mariage de Charles de Bourbon et d’Agnès de Bourgogne',2,2,'600','830','70');
INSERT INTO "actes" VALUES (4,4,'B 297, PS 316','1425','7 février 1425','Autun','Marie de Berry et Charles de Clermont promettent de respecter les engagements de Jean Ier',2,2,'325','160','55');
INSERT INTO "actes" VALUES (5,4,'B 299, PS 319','1425','6 août 1425','','Charles et Agnès de Clermont ratifient leur traité de mariage',2,2,'430','270','20');
INSERT INTO "actes" VALUES (6,3,'P 1370/1, c. 1886','1425','13 août 1425','Moulins','Charles de Clermont confirme que l’Auvergne, le Bourbonnais, etc, sont des apanages',4,2,'','','');
INSERT INTO "actes" VALUES (7,4,'B 299, PS 338','1425','8 décembre 1425','Riom','Quittance pour la dot d’Agnès de Bourgogne (quatorze mille francs)',2,2,'335','170','');
INSERT INTO "actes" VALUES (8,5,'ms. fr. 20389','1426','13 mars 1426','','Quittance pour deux mille livres accordées par le roi sur les finances de Languedoc',2,2,'290','110','');
INSERT INTO "actes" VALUES (9,6,'AA 22, c. 78','1426 (?)','[Avant le 9 octobre 1426], 30 août','Montbrison','Lettres aux habitants de Lyon sur l’arrivée de deux conseillers',2,4,'160','275','');
INSERT INTO "actes" VALUES (10,4,'B 299, PS 339','1426','16 décembre 1426','','Reçu pour la dot d’Agnès de Bourgogne (six mille francs)',2,2,'330','185','');
INSERT INTO "actes" VALUES (11,7,'FF 32, c. 1324','1427','1er mai 1427','Souvigny','Commission pour faire réparer un chemin entre Riom et Saint-Bonnet-près-Riom',2,3,'395','220','');
INSERT INTO "actes" VALUES (12,8,'25 G 24, c. 2','1427','14 mai 1427','Gannat','Autorisation d’agrandissement de l’église des Marthuret de Riom',2,3,'310','205','');
INSERT INTO "actes" VALUES (13,11,'liasse 223','1427','27 juin 1427','','Octroie de subsides aux habitants de Moulins pour financer les réparations de leurs fortifications',5,2,'','','');
INSERT INTO "actes" VALUES (14,3,'P 1372/2, c. 2113','1427','4 août 1427','','Alliance entre Charles de Clermont et Arthur de Richemont',2,2,'280','185','');
INSERT INTO "actes" VALUES (15,4,'B 299, PS 341','1427','24 août 1427','Moulins','Reçu pour la dot d’Agnès de Bourgogne (huit cent vint livres)',2,2,'355','195','40');
INSERT INTO "actes" VALUES (16,4,'B299, PS 340','1427','24 août 1427','Moulins','Reçu pour la dot d’Agnès de Bourgogne (deux mille livres)',2,2,'340','210','40');
INSERT INTO "actes" VALUES (17,9,'AA 7','1427','28 août 1427','Moulins','Concession d’une aide sur les marchandises pour aider aux réparations de Villefranche-sur-Saône',2,2,'305','325','');
INSERT INTO "actes" VALUES (18,1,'CC 182, f. 27v','1428','[Avant le 20 janvier 1428]','','Lettre close adressée à la ville d’Albi par Charles de Bourbon, Bernard d’Armagnac et Arthur de Richemont',5,4,'','','');
INSERT INTO "actes" VALUES (19,10,'E 181, c. 16','1428','30 janvier 1428','Chinon','Promesse de Charles de Clermont, Bernard d’Armagnac et Arthur de Richemont au sujet des gens d’arme du duc de Bretagne',2,2,'350','250','');
INSERT INTO "actes" VALUES (20,11,'liasse 223','1428','4 novembre 1428','Moulins','Permission aux habitants de Moulins de prendre un droit sur le vin pour financer les réparations de la ville',2,2,'370','260','50');
INSERT INTO "actes" VALUES (21,3,'P 1370/1, c. 1879/1','1428','12 décembre 1428','Souvigny','Testament de Charles de Bourbon, comte de Clermont',2,2,'460','415','65');
INSERT INTO "actes" VALUES (22,7,'DD 1, c. 1644','1429','Avril 1429','Riom','Amortissement de l’hôtel du consulat de Riom',2,1,'640','365','95');
INSERT INTO "actes" VALUES (23,3,'P 1356/2, c. 294','1429','20 avril 1429','Riom','Procuration à Pierre de Toulon pour traiter de l’achat de Calvinet et Vinzelles',3,2,'','','');
INSERT INTO "actes" VALUES (24,3,'P 1356/2, c. 299','1429','19 mai 1429','Gannat','Don de cent livre à Janicot de Montmurat, pour ses services au siège d’Orléans',2,3,'325','110','');
INSERT INTO "types" VALUES (1,'charte');
INSERT INTO "types" VALUES (2,'lettre patente');
INSERT INTO "types" VALUES (3,'mandement');
INSERT INTO "types" VALUES (4,'lettre close');
INSERT INTO "etats" VALUES (1,'minute');
INSERT INTO "etats" VALUES (2,'original');
INSERT INTO "etats" VALUES (3,'vidimus');
INSERT INTO "etats" VALUES (4,'copie');
INSERT INTO "etats" VALUES (5,'deperditum');
COMMIT;
