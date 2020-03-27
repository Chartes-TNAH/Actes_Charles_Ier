from ..app import db

class actes(db.Model):
	__tablename__ = "actes"
	id_acte = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
	lieu_conservation = db.Column(db.Text)
	#(db.Integer, db.ForeignKey('depots.id_depots'))
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
	"""
	depots = db.relationship("actes", back_populates="id_depots")

class depots(db.Model):
	__tablename__ = "depots"
	id_depots = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
	lieu_conservation = db.Column(db.Text)
	actes = db.relationship("depots", back_populates="actes_id_depots")
	conservation = db.relationship("actes", backref="document")
	"""