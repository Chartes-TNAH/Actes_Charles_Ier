# import de la base de données (db) depuis le fichier app.py :
from .app import db
# import du document XML (source_doc) depuis le fichier constantes.py :
from .constantes import source_doc
# import de la classe Acts depuis le fichier donnees.py situé dans le dossier modeles :
from .modeles.donnees import Acts 

def database_init():
    """Fonction permettant de compléter la base de données db avec les informations issues de source_doc.
        (1) Définition de listes vides, correspondant aux colonnes de la base, et de deux compteurs.
        (2) Boucle sur chaque élément texte de l'arbre XML pour remplir les listes, number permettant
            d'indiquer l'id des actes dans le document XML.
        (3) Boucle sur le contenu :
            * L'ancienne base est écrasée (db) ;
            * Une nouvelle base est créée (db) ;
            * Le compteur count_id augmente de un à chaque cycle de la boucle ;
            * Sont ajoutés à db : le compteur, correspondant à l'id de l'acte, et l'entrée de chaque
              liste avec comme index count_id - 1 (puisque le premier index d'une liste est 0).
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
    for item in source_doc.xpath("//group/text"):
        number += 1
        item_institution = source_doc.xpath("//text[@n=" + str(number) + "]//institution/text()")
        list_institution.append(item_institution[0])
        list_state.append(item.attrib['type'])
        list_type.append(item.attrib['subtype'])
        item_date = source_doc.xpath("//text[@n=" + str(number) + "]//date/text()")
        list_date.append(item_date[0])
        item_place = source_doc.xpath("//text[@n=" + str(number) + "]//docDate/placeName/text()")
        list_place.append(item_place[0])
        item_analyse = source_doc.xpath("//text[@n=" + str(number) + "]//argument[1]/p/text()")
        list_analyse.append(item_analyse[0])
    for item in list_date:
        db.drop_all()
        db.create_all()
        count_id +=1
        db.session.add(Acts(count_id, list_institution[count_id - 1], list_state[count_id - 1], 
            list_type[count_id - 1], list_date[count_id - 1], list_place[count_id - 1], 
            list_analyse[count_id - 1]))
    db.session.commit()