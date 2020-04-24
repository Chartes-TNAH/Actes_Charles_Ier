# import de la base de données (db) depuis le fichier app.py situé dans le dossier parent (..) :
from ..app import db
# import du document XML (source_doc) depuis le fichier constantes.py situé dans le dossier parent (..) :
from ..constantes import source_doc

class Acts(db.Model):
    __tablename__ = "acts"
    id_acts = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    institution = db.Column(db.Text)
    state = db.Column(db.Text)
    type = db.Column(db.Text)
    date = db.Column(db.Text)
    place = db.Column(db.Text)
    analyse = db.Column(db.Text)

    def __init__(self, id_acts, institution, state, type, date, place, analyse):
        self.id_acts = id_acts
        self.institution = institution
        self.state = state
        self.type = type
        self.date = date
        self.place = place
        self.analyse = analyse

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
    db.session.add(Acts(id, list_institution[id - 1], list_state[id - 1], list_type[id - 1], list_date[id - 1], list_place[id - 1], list_analyse[id - 1]))
db.session.commit()