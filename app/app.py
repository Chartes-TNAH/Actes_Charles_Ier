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

# Configuration de la base de donnée et stockage du résultat dans db.
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:////Users/jdgenero/Desktop/M2_Cours/dev/Actes_Charles_Ier/app/corpus.sqlite'
db = SQLAlchemy(app)

# Parsage du document XML-TEI avec la méthode .parse() d'etree, et stockage du résultat dans source_doc :
source_doc = etree.parse("../Actes_Charles_Ier/app/static/xml/corpus-act-ch.xml")

# Import des différentes routes depuis le fichier routes.py
from .routes import accueil, projet, corpus, bibliographie, duc, index_noms, index_prosopo, index_lieu, contact, recherche, acte, page_not_found, mentions_legales, resultats