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
        