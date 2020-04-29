from lxml import etree
# import de la base de données (db) depuis le fichier app.py :
from .app import db
# import de la classe Acts depuis le fichier donnees.py situé dans le dossier modeles :
from .modeles.donnees import Acts 

def database_init(xml_file):
    """Fonction permettant de compléter la base de données db avec les informations issues de xml_file.
        (1) Définition de listes vides, correspondant aux colonnes de la base, et de deux compteurs.
        (2) Boucle sur chaque élément texte de l'arbre XML pour remplir les listes, number permettant
            d'indiquer l'id des actes dans le document XML.
        (3) Boucle sur le contenu :
            * L'ancienne base est écrasée (db) ;
            * Une nouvelle base est créée (db) ;
            * Le compteur count_id augmente de un à chaque cycle de la boucle ;
            * Sont ajoutés à db : le compteur, correspondant à l'id de l'acte, et l'entrée de chaque
              liste avec comme index count_id - 1 (puisque le premier index d'une liste est 0).
        :param xml_file: un document XML parsé avec la méthode .parse() d'etree.
    """
    list_id = []
    list_institution = []
    list_state = []
    list_type = []
    list_date = []
    list_place = []
    list_analyse = []
    number = 0
    count_id = 0
    for item in xml_file.xpath("//group/text"):
        number += 1
        item_institution = xml_file.xpath("//text[@n=" + str(number) + "]//institution/text()")
        list_institution.append(item_institution[0])
        list_state.append(item.attrib['type'])
        list_type.append(item.attrib['subtype'])
        item_date = xml_file.xpath("//text[@n=" + str(number) + "]//date/text()")
        list_date.append(item_date[0])
        item_place = xml_file.xpath("//text[@n=" + str(number) + "]//docDate/placeName/text()")
        list_place.append(item_place[0])
        item_analyse = xml_file.xpath("//text[@n=" + str(number) + "]//argument[1]/p/text()")
        list_analyse.append(item_analyse[0])
    for item in list_date:
        db.drop_all()
        db.create_all()
        count_id +=1
        db.session.add(Acts(count_id, list_institution[count_id - 1], list_state[count_id - 1], 
            list_type[count_id - 1], list_date[count_id - 1], list_place[count_id - 1], 
            list_analyse[count_id - 1]))
    db.session.commit()