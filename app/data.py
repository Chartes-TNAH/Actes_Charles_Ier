# import de la base de données (db) depuis le fichier app.py :
from ..app import db
# import du document XML (source_doc) depuis le fichier constantes.py :
from ..constantes import source_doc
# import de la classe Acts depuis le fichier donnees.py situé dans le dossier modeles :
from .modeles.donnees import Acts 

list_id = []
list_institution = []
list_state = []
list_type = []
list_date = []
list_place = []
list_analyse = []
number = 0
id = 0

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
    id +=1
    db.session.add(Acts(id, list_institution[id - 1], list_state[id - 1], list_type[id - 1], 
        list_date[id - 1], list_place[id - 1], list_analyse[id - 1]))
db.session.commit()