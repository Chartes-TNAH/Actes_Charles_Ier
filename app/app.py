from flask import Flask
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

from .routes import accueil, projet, bibliographie, duc, sommaire, index_noms, index_prosopo, index_lieu, contact, acte, page_not_found