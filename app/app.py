from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from lxml import etree
import os

chemin_actuel = os.path.dirname(os.path.abspath(__file__))
templates = os.path.join(chemin_actuel, "templates")
statics = os.path.join(chemin_actuel, "static")

app = Flask(
    "Application",
    template_folder=templates,
    static_folder=statics,
)

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:////Users/jdgenero/Desktop/M2_Cours/dev/Actes_Charles_Ier/app/db.sqlite'
db = SQLAlchemy(app)

from .routes import accueil, projet, corpus, bibliographie, duc, sommaire, index_noms, index_prosopo, index_lieu, contact, acte, page_not_found