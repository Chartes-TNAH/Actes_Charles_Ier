BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "actes" (
	"id_acte"	INTEGER,
	"lieu_conservation"	TEXT,
	"cote"	TEXT,
	"annee"	TEXT,
	"date_temps"	TEXT,
	"date_lieu"	TEXT NOT NULL,
	"regeste"	TEXT,
	"etatActe"	TEXT,
	"typeActe"	TEXT,
	"hauteur"	TEXT NOT NULL,
	"largeur"	TEXT NOT NULL,
	"repli"	TEXT NOT NULL,
	PRIMARY KEY("id_acte")
);
INSERT INTO "actes" VALUES (1,"Archives départementales du Tarn",'CC 176, f. 27r','1421','[Avant le 15 janvier 1421]','','Lettre close à la ville d’Albi',"Deperditum","Lettre close",'','','');
INSERT INTO "actes" VALUES (2,"Archives municipales de Saint-Flour",'ch. XI, art. 2., n°32, f. 43v','1421','[Avant le 18 janvier 1421]','','Lettre close aux villes d’Auvergne',"Deperditum","Lettre close",'','','');
INSERT INTO "actes" VALUES (3,"Archives nationales",'P 1370/2, c. 1919','1425','4 février 1425','','Traité de mariage de Charles de Bourbon et d’Agnès de Bourgogne',"Original","Lettre patente",'600','830','70');
INSERT INTO "actes" VALUES (4,"Archvies départementales de la Côte-d'Or",'B 297, PS 316','1425','7 février 1425','Autun','Marie de Berry et Charles de Clermont promettent de respecter les engagements de Jean Ier',"Original","Lettre patente",'325','160','55');
INSERT INTO "actes" VALUES (5,"Archvies départementales de la Côte-d'Or",'B 299, PS 319','1425','6 août 1425','','Charles et Agnès de Clermont ratifient leur traité de mariage',"Original","Lettre patente",'430','270','20');
INSERT INTO "actes" VALUES (6,"Archives nationales",'P 1370/1, c. 1886','1425','13 août 1425','Moulins','Charles de Clermont confirme que l’Auvergne, le Bourbonnais, etc, sont des apanages',"Copie","Lettre patente",'','','');
INSERT INTO "actes" VALUES (7,"Archvies départementales de la Côte-d'Or",'B 299, PS 338','1425','8 décembre 1425','Riom','Quittance pour la dot d’Agnès de Bourgogne (quatorze mille francs)',"Original","Lettre patente",'335','170','');
INSERT INTO "actes" VALUES (8,"Bibliothèque nationale de France",'ms. fr. 20389','1426','13 mars 1426','','Quittance pour deux mille livres accordées par le roi sur les finances de Languedoc',"Original","Lettre patente",'290','110','');
INSERT INTO "actes" VALUES (9,"Archives municipales de Lyon",'AA 22, c. 78','1426 (?)','[Avant le 9 octobre 1426], 30 août','Montbrison','Lettres aux habitants de Lyon sur l’arrivée de deux conseillers',"Original","Lettre close",'160','275','');
INSERT INTO "actes" VALUES (10,"Archvies départementales de la Côte-d'Or",'B 299, PS 339','1426','16 décembre 1426','','Reçu pour la dot d’Agnès de Bourgogne (six mille francs)',"Original","Lettre patente",'330','185','');
INSERT INTO "actes" VALUES (11,"Archives municipales de Riom",'FF 32, c. 1324','1427','1er mai 1427','Souvigny','Commission pour faire réparer un chemin entre Riom et Saint-Bonnet-près-Riom',"Original","Mandement",'395','220','');
INSERT INTO "actes" VALUES (12,"Archives départementales du Puy-de-Dôme",'25 G 24, c. 2','1427','14 mai 1427','Gannat','Autorisation d’agrandissement de l’église des Marthuret de Riom',"Original","Mandement",'310','205','');
INSERT INTO "actes" VALUES (13,"Archives municipales de Moulins",'liasse 223','1427','27 juin 1427','','Octroie de subsides aux habitants de Moulins pour financer les réparations de leurs fortifications',"Deperditum","Lettre patente",'','','');
INSERT INTO "actes" VALUES (14,"Archives nationales",'P 1372/2, c. 2113','1427','4 août 1427','','Alliance entre Charles de Clermont et Arthur de Richemont',"Original","Lettre patente",'280','185','');
INSERT INTO "actes" VALUES (15,"Archvies départementales de la Côte-d'Or",'B 299, PS 341','1427','24 août 1427','Moulins','Reçu pour la dot d’Agnès de Bourgogne (huit cent vint livres)',"Original","Lettre patente",'355','195','40');
INSERT INTO "actes" VALUES (16,"Archvies départementales de la Côte-d'Or",'B299, PS 340','1427','24 août 1427','Moulins','Reçu pour la dot d’Agnès de Bourgogne (deux mille livres)',"Original","Lettre patente",'340','210','40');
INSERT INTO "actes" VALUES (17,"Archives municipales de Villefranche-sur-Saône",'AA 7','1427','28 août 1427','Moulins','Concession d’une aide sur les marchandises pour aider aux réparations de Villefranche-sur-Saône',"Original","Lettre patente",'305','325','');
INSERT INTO "actes" VALUES (18,"Archives départementales du Tarn",'CC 182, f. 27v','1428','[Avant le 20 janvier 1428]','','Lettre close adressée à la ville d’Albi par Charles de Bourbon, Bernard d’Armagnac et Arthur de Richemont',"Deperditum","Lettre close",'','','');
INSERT INTO "actes" VALUES (19,"Archives départementales de la Loire-Atlantique",'E 181, c. 16','1428','30 janvier 1428','Chinon','Promesse de Charles de Clermont, Bernard d’Armagnac et Arthur de Richemont au sujet des gens d’arme du duc de Bretagne',"Original","Lettre patente",'350','250','');
INSERT INTO "actes" VALUES (20,"Archives municipales de Moulins",'liasse 223','1428','4 novembre 1428','Moulins','Permission aux habitants de Moulins de prendre un droit sur le vin pour financer les réparations de la ville',"Original","Lettre patente",'370','260','50');
INSERT INTO "actes" VALUES (21,"Archives nationales",'P 1370/1, c. 1879/1','1428','12 décembre 1428','Souvigny','Testament de Charles de Bourbon, comte de Clermont',"Original","Lettre patente",'460','415','65');
INSERT INTO "actes" VALUES (22,"Archives municipales de Riom",'DD 1, c. 1644','1429','Avril 1429','Riom','Amortissement de l’hôtel du consulat de Riom',"Original","Charte",'640','365','95');
INSERT INTO "actes" VALUES (23,"Archives nationales",'P 1356/2, c. 294','1429','20 avril 1429','Riom','Procuration à Pierre de Toulon pour traiter de l’achat de Calvinet et Vinzelles',"Vidimus","Lettre patente",'','','');
INSERT INTO "actes" VALUES (24,"Archives nationales",'P 1356/2, c. 299','1429','19 mai 1429','Gannat','Don de cent livre à Janicot de Montmurat, pour ses services au siège d’Orléans',"Original","Mandement",'325','110','');
COMMIT;
