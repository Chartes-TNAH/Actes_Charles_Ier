from ..app import db

class actes(db.Model):
	id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
	conserveDans = db.Column(db.Integer, db.ForeignKey("depots.id_depots"))
	cote = db.Column(db.Text)
	annee = db.Column(db.Text)
	date_temps = db.Column(db.Text)
	date_lieu = db.Column(db.Text)
	regeste = db.Column(db.Text)
	etatActe = db.Column(db.Text)
	typeActe = db.Column(db.Text)
	hauteur = db.Column(db.Integer)
	largeur = db.Column(db.Integer)
	repli = db.Column(db.Integer)
	id_depots = db.relationship("depots", back_populates="conserveDans")

class depots(db.Model):
	id_depots = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
	depots = db.Column(db.Text)
	conserveDans = db.relationship("actes", back_populates="id_depots")
