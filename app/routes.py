from flask import Flask, render_template, request
from flask_sqlalchemy import SQLAlchemy
from lxml import etree
import re

from .app import app, source_doc # import de l'application (app) et du document XML (source_doc) depuis le fichier app.py
from .modeles.donnees import Acts # import de la classe Acts depuis le fichier donnees.py situé dans le dossier modeles

@app.route("/")
def accueil():
	"""Route permettant d'afficher la page accueil en retournant une template via l'objet Flask render_template(), où est défini le document html où le retour de la fonction sera affiché.
	"""
	return render_template("accueil.html")

@app.route("/projet")
def projet():
	"""Route permettant d'afficher la page projet :
	(1) la feuille de transformation XSL projet-xslt.xslt est parsée et le résultat du parsage est stocké dans la variable xslt_projet_doc ;
	(2) la méthode .XSLT() d'etree est appliquée à xslt_projet_doc, le résultat est stocké dans la variable xslt_projet_transformer ;
	(3) la feuille de transformation est appliquée au document XML (source_doc), le résultat est stocké dans la variable output_projet_doc ;
	(4) la fonction retourne une template via l'objet Flask render_template(), où sont définis le chemin vers le document html où le retour de la fonction sera affiché (pages/projet.html) et la template Flask qui contient le résultat de la transformation XSL (contenu_projet).
	"""
	xslt_projet_doc = etree.parse("../Actes_Charles_Ier/app/static/xslt/projet-xslt.xslt")
	xslt_projet_transformer = etree.XSLT(xslt_projet_doc)
	output_projet_doc = xslt_projet_transformer(source_doc)
	return render_template("pages/projet.html", contenu_projet=output_projet_doc)

@app.route("/bibliographie")
def bibliographie():
	"""Route permettant d'afficher la page bibliographie en retournant une template via l'objet Flask render_template(), où est défini le chemin vers le document html où le retour de la fonction sera affiché.
	"""
	return render_template("pages/bibliographie.html")

@app.route("/duc")
def duc():
	"""Route permettant d'afficher la page de biographie du duc en retournant une template via l'objet Flask render_template(), où est défini le chemin vers le document html où le retour de la fonction sera affiché.
	"""
	return render_template("pages/duc.html")

@app.route("/actes")
def corpus():
	"""Route permettant d'afficher la page de présentation du corpus des actes ducaux en retournant une template via l'objet Flask render_template(), où est défini le chemin vers le document html où le retour de la fonction sera affiché.
	La variable Actes_total contient le résultat d'une requête sur l'ensemble de la classe Acts et est stockée dans la template Flask document.
	"""
	Actes_total = Acts.query.all()
	return render_template("pages/corpus.html", document=Actes_total)

@app.route("/index-nominum")
def index_noms():
	"""Route permettant d'afficher la page de l'index nominum :
	(1) la feuille de transformation XSL index-nominum.xsl est parsée et le résultat du parsage est stocké dans la variable xslt_index_nom_doc ;
	(2) la méthode .XSLT() d'etree est appliquée à xslt_index_nom_doc, le résultat est stocké dans la variable xslt_index_nom_transformer ;
	(3) la feuille de transformation est appliquée au document XML (source_doc), le résultat est stocké dans la variable output_index_nom_doc ;
	(4) la fonction retourne une template via l'objet Flask render_template(), où sont définis le chemin vers le document html où le retour de la fonction sera affiché (pages/index_nominum.html) et la template Flask qui contient le résultat de la transformation XSL (contenu_index_nom).
	"""
	xslt_index_nom_doc = etree.parse("../Actes_Charles_Ier/app/static/xslt/index-nominum.xsl")
	xslt_index_nom_transformer = etree.XSLT(xslt_index_nom_doc)
	output_index_nom_doc = xslt_index_nom_transformer(source_doc)
	return render_template("pages/index_nominum.html", contenu_index_nom=output_index_nom_doc)

@app.route("/index-prosopographique")
def index_prosopo():
	"""Route permettant d'afficher la page de l'index prosopographique :
	(1) la feuille de transformation XSL index-xslt.xsl est parsée et le résultat du parsage est stocké dans la variable xslt_index_prosopo_doc ;
	(2) la méthode .XSLT() d'etree est appliquée à xslt_index_prosopo_doc, le résultat est stocké dans la variable xslt_index_prosopo_transformer ;
	(3) la feuille de transformation est appliquée au document XML (source_doc), le résultat est stocké dans la variable output_index_prosopo_doc ;
	(4) la fonction retourne une template via l'objet Flask render_template(), où sont définis le chemin vers le document html où le retour de la fonction sera affiché (pages/index_prosopo.html) et la template Flask qui contient le résultat de la transformation XSL (contenu_index_prosopo).
	"""
	xslt_index_prosopo_doc = etree.parse("../Actes_Charles_Ier/app/static/xslt/index-xslt.xsl")
	xslt_index_prosopo_transformer = etree.XSLT(xslt_index_prosopo_doc)
	output_index_prosopo_doc = xslt_index_prosopo_transformer(source_doc)
	return render_template("pages/index_prosopo.html", contenu_index_prosopo=output_index_prosopo_doc)

@app.route("/index-lieu")
def index_lieu():
	"""Route permettant d'afficher la page de l'index locorum :
	(1) la feuille de transformation XSL index-locorum.xsl est parsée et le résultat du parsage est stocké dans la variable xslt_index_lieux_doc ;
	(2) la méthode .XSLT() d'etree est appliquée à xslt_index_lieux_doc, le résultat est stocké dans la variable xslt_index_lieux_transformer ;
	(3) la feuille de transformation est appliquée au document XML (source_doc), le résultat est stocké dans la variable output_index_lieux_doc ;
	(4) la fonction retourne une template via l'objet Flask render_template(), où sont définis le chemin vers le document html où le retour de la fonction sera affiché (pages/index-lieux.html) et la template Flask qui contient le résultat de la transformation XSL (contenu_index_lieux).
	"""
	xslt_index_lieux_doc = etree.parse("../Actes_Charles_Ier/app/static/xslt/index-locorum.xsl")
	xslt_index_lieux_transformer = etree.XSLT(xslt_index_lieux_doc)
	output_index_lieux_doc = xslt_index_lieux_transformer(source_doc)
	return render_template("pages/index-lieux.html", contenu_index_lieux=output_index_lieux_doc)

@app.route("/contact")
def contact():
	"""Route permettant d'afficher la page de contact en retournant une template via l'objet Flask render_template(), où est défini le chemin vers le document html où le retour de la fonction sera affiché.
	"""
	return render_template("pages/contact.html")

@app.route("/actes/<int:acte_id>")
def acte(acte_id):
	"""Route permettant d'afficher la page de présentation d'un acte :
	:param acte_id: numéro de l'acte
	(1) la feuille de transformation XSL corpus-xslt.xslt est parsée et le résultat du parsage est stocké dans la variable xslt_doc ;
	(2) la méthode .XSLT() d'etree est appliquée à xslt_doc, le résultat est stocké dans la variable xslt_transformer ;
	(3) la feuille de transformation est appliquée au document XML (source_doc), le résultat est stocké dans la variable output_doc ;
	(4) la fonction retourne une template via l'objet Flask render_template(), où sont définis le chemin vers le document html où le retour de la fonction sera affiché (pages/acte.html) et les templates Flask qui contiennent le résultat de la transformation XSL (contenu_acte) et le numéro de l'acte (id).
	"""
	xslt_doc = etree.parse("../Actes_Charles_Ier/app/static/xslt/corpus-xslt.xslt")
	xslt_transformer = etree.XSLT(xslt_doc)
	output_doc = xslt_transformer(source_doc, numero=str(acte_id))
	return render_template("pages/acte.html", contenu_acte=output_doc, id=acte_id)

@app.route("/recherche")
def recherche():
	"""Route permettant d'afficher la page recherche.
	(1) Des listes vides sont définies.
	(2) Des requêtes sont effectuées en boucle sur la class Acts et, les éléments trouvés sont ajoutés à la liste correspondante. Dans le libellés des dépôts d'archives départemenaux et municipaux, la méthode sub() de la librairie re permet, via une regex
	à compléter
	"""
	list_year = []
	list_AN = []
	list_bib = []
	list_AD = []
	list_AM = []
	list_deperdita = []
	list_state = []
	list_type = []
	list_city = []
	for item in Acts.query.all():
		year = item.date
		year = re.search('[0-9]{4}',year)
		list_year.append(int(year.group()))
	list_year.sort()
	list_year = set(list_year)
	for institution in Acts.query.group_by(Acts.institution).all():
		if 'nationales' in institution.institution:
			national = institution.institution
			list_AN.append(national)
		elif 'Bibliothèque' in institution.institution:
			library = str(institution.institution)
			list_bib.append(library)
		elif 'départementales' in institution.institution:
			AD = str(institution.institution)
			AD = re.sub('Archives départementales (du)?(de)?(du)?(des)? ?(la)?(l\')? ?', '', AD)
			list_AD.append(AD)
		elif 'municipales' in institution.institution:
			AM = str(institution.institution)
			AM = re.sub('Archives municipales (du)?(de)?(du)?(des)? ?(la)?(d\')? ?', '', AM)
			list_AM.append(AM)
		elif 'Deperditum' in institution.institution:
			deperditum = str(institution.institution)
			deperditum = deperditum.replace('Deperditum ', '')
			list_deperdita.append(deperditum)
	for item in Acts.query.group_by(Acts.state).all():
		state = item.state
		list_state.append(state)
	for item in Acts.query.group_by(Acts.type).all():
		Acttype = item.type
		list_type.append(Acttype)
	for city in Acts.query.group_by(Acts.place).all():
		place = city.place
		list_city.append(place)
	list_city.remove('NS')
	return render_template("pages/recherche.html", list_year=list_year, list_AN=list_AN, list_bib=list_bib, list_AD=list_AD, list_AM=list_AM, list_deperdita=list_deperdita, list_state=list_state, list_type=list_type, list_city=list_city)

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
		resultats_annee = Acts.query.filter(
			Acts.date.like("%{}%".format(motclef_annee))
			).all()
		resultats_lieu_production = Acts.query.filter(
			Acts.place.like("%{}%".format(motclef_lieu_production))
			).all()
		resultats_state = Acts.query.filter(
			Acts.state.like("%{}%".format(motclef_state))
			).all()
		resultats_type = Acts.query.filter(
			Acts.type.like("%{}%".format(motclef_type))
			).all()
		return render_template("pages/resultats.html", resultats=resultats, resultats_annee=resultats_annee, resultats_institution=resultats_institution, resultats_lieu_production=resultats_lieu_production, resultats_type=resultats_type, resultats_state=resultats_state)
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
