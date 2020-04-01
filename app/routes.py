from flask import Flask, render_template, request
from flask_sqlalchemy import SQLAlchemy
from lxml import etree
import re

from .app import app, source_doc
from .modeles.donnees import Acts

@app.route("/")
def accueil():
    return render_template("accueil.html")

@app.route("/projet")
def projet():
	xslt_projet_doc = etree.parse("../Actes_Charles_Ier/app/static/xslt/projet-xslt.xslt")
	xslt_projet_transformer = etree.XSLT(xslt_projet_doc)
	output_projet_doc = xslt_projet_transformer(source_doc)
	return render_template("pages/projet.html", contenu_projet=output_projet_doc)

@app.route("/bibliographie")
def bibliographie():
    return render_template("pages/bibliographie.html")

@app.route("/duc")
def duc():
    return render_template("pages/duc.html")

@app.route("/actes")
def corpus():
	Actes_total = Acts.query.all()
	return render_template("pages/corpus.html", document=Actes_total)

@app.route("/index-nominum")
def index_noms():
	xslt_index_nom_doc = etree.parse("../Actes_Charles_Ier/app/static/xslt/index-nominum.xsl")
	xslt_index_nom_transformer = etree.XSLT(xslt_index_nom_doc)
	output_index_nom_doc = xslt_index_nom_transformer(source_doc)
	return render_template("pages/index_nominum.html", contenu_index_nom=output_index_nom_doc)

@app.route("/index-prosopographique")
def index_prosopo():
	xslt_index_prosopo_doc = etree.parse("../Actes_Charles_Ier/app/static/xslt/index-xslt.xsl")
	xslt_index_prosopo_transformer = etree.XSLT(xslt_index_prosopo_doc)
	output_index_prosopo_doc = xslt_index_prosopo_transformer(source_doc)
	return render_template("pages/index_prosopo.html", contenu_index_prosopo=output_index_prosopo_doc)

@app.route("/index-lieu")
def index_lieu():
	xslt_index_lieux_doc = etree.parse("../Actes_Charles_Ier/app/static/xslt/index-locorum.xsl")
	xslt_index_lieux_transformer = etree.XSLT(xslt_index_lieux_doc)
	output_index_lieux_doc = xslt_index_lieux_transformer(source_doc)
	return render_template("pages/index-lieux.html", contenu_index_lieux=output_index_lieux_doc)

@app.route("/contact")
def contact():
	return render_template("pages/contact.html")

@app.route("/actes/<int:acte_id>")
def acte(acte_id):
	xslt_doc = etree.parse("../Actes_Charles_Ier/app/static/xslt/corpus-xslt.xslt")
	xslt_transformer = etree.XSLT(xslt_doc)
	output_doc = xslt_transformer(source_doc, numero=str(acte_id))
	return render_template("pages/acte.html", contenu_acte=output_doc, id=acte_id)

@app.route("/recherche")
def recherche():
	list_institutions = []
	list_AD = []
	list_AM = []
	list_deperdita = []
	list_city = []
	list_years = []
	for institution in Acts.query.group_by(Acts.institution).all():
		if 'nationale' in institution.institution:
			national = institution.institution
			list_institutions.append(national)
		elif 'départementales' in institution.institution:
			AD = str(institution.institution)
			AD = re.sub('Archives départementales (du)?(de)?(du)?(des)? ?(la)?(l\')? ?', '', AD)
			list_AD.append(AD)
		elif 'municipales' in institution.institution:
			AM = str(institution.institution)
			AM = re.sub('Archives municipales (du)?(de)?(du)?(des)? ?(la)?(d\')? ?', '', AM)
			list_AM.append(AM)
		elif 'deperditum' in institution.institution:
			deperditum = str(institution.institution)
			deperditum = deperditum.replace(', deperditum', '')
			list_deperdita.append(deperditum)
	for city in Acts.query.group_by(Acts.date).all():
		place = city.place
		list_city.append(place)
	return render_template("pages/recherche.html", list_institutions=list_institutions, list_AD=list_AD, 
		list_AM=list_AM, list_deperdita=list_deperdita, list_city=list_city)

@app.route("/recherche/resultats")
def resultats():
	motclef = request.args.get("keyword", None)
	motclef_annee = request.args.get("year", None)
	motclef_institution = request.args.get("archives", None)
	motclef_lieu_production = request.args.get("place", None)
	motclef_state = request.args.get("state", None)
	motclef_type = request.args.get("type", None)
	resultats = []
	resultats_annee = []
	resultats_institution = []
	resultats_lieu_production = []
	resultats_state = []
	resultats_type = []
	if motclef or motclef_institution or motclef_annee or motclef_lieu_production or motclef_type or motclef_state:
		resultats = Acts.query.filter(
			Acts.analyse.like("%{}%".format(motclef))
			).all()
		resultats_institution = Acts.query.filter(
			Acts.institution.like("%{}%".format(motclef_institution))
			).all()
		#resultats_annee = Acts.query.filter(
			#Acts.annee.like("%{}%".format(motclef_annee))
			#).all()
		resultats_lieu_production = Acts.query.filter(
			Acts.place.like("%{}%".format(motclef_lieu_production))
			).all()
		resultats_state = Acts.query.filter(
			Acts.state.like("%{}%".format(motclef_state))
			).all()
		resultats_type = Acts.query.filter(
			Acts.type.like("%{}%".format(motclef_type))
			).all()
		return render_template("pages/resultats.html", resultats=resultats, 
			resultats_institution=resultats_institution, 
			resultats_lieu_production=resultats_lieu_production, 
			resultats_type=resultats_type, 
			resultats_state=resultats_state)
	else:
		return render_template('pages/error404.html')

@app.errorhandler(404)
def page_not_found(error):
   return render_template('pages/error404.html', title = '404'), 404

# Ce if permet de vérifier que ce fichier est celui qui est courrament exécuté. Cela permet par exemple d'éviter
# de lancer une fonction quand on importe ce fichier depuis un autre fichier.
# En python, lorsque l'on exécute un script avec la commande `python script.py`
# Le fichier `script.py` a en __name__ la valeur __main__.
if __name__ == "__main__":
    app.run(debug=True)
