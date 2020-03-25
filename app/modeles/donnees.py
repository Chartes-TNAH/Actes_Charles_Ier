from ..app import db

class actes(db.Model):
	id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
	cote = db.Column(db.Text)
	annee = db.Column(db.Text)
	date_temps = db.Column(db.Text)
	date_lieu = db.Column(db.Text)
	hauteur = db.Column(db.Integer)
	largeur = db.Column(db.Integer)
	repli = db.Column(db.Integer)
	regeste = db.Column(db.Text)