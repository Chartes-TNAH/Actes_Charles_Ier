from flask import Flask, render_template, request
from flask_sqlalchemy import SQLAlchemy
from lxml import etree
import re

from .app import app, source_doc
from .modeles.donnees import actes

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
	Actes_total = actes.query.all()
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
	list_Allier = []
	list_Loire = []
	list_IndreetLoire = []
	list_Puy = []
	list_SaoineetLoire = []
	list_years = []
	for institution in actes.query.group_by(actes.lieu_conservation).all():
		if 'nationale' in institution.lieu_conservation:
			national = institution.lieu_conservation
			list_institutions.append(national)
		elif 'départementales' in institution.lieu_conservation:
			AD = str(institution.lieu_conservation)
			AD = re.sub('Archives départementales (du)?(de)?(du)?(des)? ?(la)?(l\')? ?', '', AD)
			list_AD.append(AD)
		elif 'municipales' in institution.lieu_conservation:
			AM = str(institution.lieu_conservation)
			AM = re.sub('Archives municipales (du)?(de)?(du)?(des)? ?(la)?(d\')? ?', '', AM)
			list_AM.append(AM)
		elif 'deperditum' in institution.lieu_conservation:
			deperditum = str(institution.lieu_conservation)
			deperditum = deperditum.replace(', deperditum', '')
			list_deperdita.append(deperditum)
	for city in actes.query.group_by(actes.date_lieu).all():
		if '(Allier)' in city.date_lieu:
			allier = str(city.date_lieu)
			allier = re.sub(' \(.*\)', '', allier)
			list_Allier.append(allier)
		elif '(Loire)' in city.date_lieu:
			loire = str(city.date_lieu)
			loire = re.sub(' \(.*\)', '', loire)
			list_Loire.append(loire)
		elif '(Puy-de-Dôme)' in city.date_lieu:
			puy = str(city.date_lieu)
			puy = re.sub(' \(.*\)', '', puy)
			list_Puy.append(puy)
		elif '(Saône-et-Loire)' in city.date_lieu:
			saoineetloire = str(city.date_lieu)
			saoineetloire = re.sub(' \(.*\)', '', saoineetloire)
			list_SaoineetLoire.append(saoineetloire)
		elif '(Indre-et-Loire)' in city.date_lieu:
			indreetLoire = str(city.date_lieu)
			indreetLoire = re.sub(' \(.*\)', '', indreetLoire)
			list_IndreetLoire.append(indreetLoire)
	for time in actes.query.group_by(actes.annee).all():
		year = time.annee
		list_years.append(year)
	return render_template("pages/recherche.html", list_institutions=list_institutions, list_AD=list_AD, 
		list_AM=list_AM, list_deperdita=list_deperdita, list_years=list_years, list_Allier=list_Allier, 
		list_Loire=list_Loire, list_IndreetLoire=list_IndreetLoire, list_SaoineetLoire=list_SaoineetLoire, list_Puy=list_Puy)

@app.route("/recherche/resultats")
def resultats():
	motclef = request.args.get("keyword", None)
	motclef_annee = request.args.get("year", None)
	motclef_lieu_conservation = request.args.get("archives", None)
	motclef_lieu_production = request.args.get("place", None)
	motclef_state = request.args.get("state", None)
	motclef_type = request.args.get("type", None)
	resultats = []
	resultats_annee = []
	resultats_lieu_conservation = []
	resultats_lieu_production = []
	resultats_state = []
	resultats_type = []
	if motclef or motclef_lieu_conservation or motclef_annee or motclef_lieu_production or motclef_type or motclef_state:
		resultats = actes.query.filter(
			actes.regeste.like("%{}%".format(motclef))
			).all()
		resultats_lieu_conservation = actes.query.filter(
			actes.lieu_conservation.like("%{}%".format(motclef_lieu_conservation))
			).all()
		resultats_annee = actes.query.filter(
			actes.annee.like("%{}%".format(motclef_annee))
			).all()
		resultats_lieu_production = actes.query.filter(
			actes.date_lieu.like("%{}%".format(motclef_lieu_production))
			).all()
		resultats_state = actes.query.filter(
			actes.etatActe.like("%{}%".format(motclef_state))
			).all()
		resultats_type = actes.query.filter(
			actes.typeActe.like("%{}%".format(motclef_type))
			).all()
		return render_template("pages/resultats.html", resultats=resultats, 
			resultats_annee=resultats_annee, 
			resultats_lieu_conservation=resultats_lieu_conservation, 
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
