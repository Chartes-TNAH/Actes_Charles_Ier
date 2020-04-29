from flask import Flask, render_template, request
from flask_sqlalchemy import SQLAlchemy
from lxml import etree
import re

# import de l'application (app) depuis le fichier app.py :
from .app import app
# import de la variable RESULT_PAR_PAGES, du document XML (source_doc) et des feuilles de transformation XSLT depuis
# le fichier constantes.py :
from .constantes import RESULT_PAR_PAGES, source_doc, xslt_projet_doc, xslt_index_nom_doc, xslt_index_prosopo_doc, xslt_index_lieux_doc
# import de la fonction database_init depuis le fichier data.py
from .data import database_init
# import de la classe Acts depuis le fichier donnees.py situé dans le dossier modeles :
from .modeles.donnees import Acts 

# activation de la fonction d'initialisation de la base de données avec pour paramètre souce_doc
database_init(source_doc)

@app.route("/")
def accueil():
	"""Route permettant d'afficher la page accueil en retournant une template via l'objet Flask render_template(),
	   où est défini le document html où le retour de la fonction sera affiché.
	"""
	return render_template("accueil.html")

@app.route("/projet")
def projet():
	"""Route permettant d'afficher la page projet :
	(1) la méthode .XSLT() d'etree est appliquée à xslt_projet_doc, le résultat est stocké dans la variable
		xslt_projet_transformer ;
	(2) la feuille de transformation est appliquée au document XML (source_doc), le résultat est stocké
		dans la variable output_projet_doc ;
	(3) la fonction retourne une template via l'objet Flask render_template(), où sont définis le chemin vers
		le document html où le retour de la fonction sera affiché (pages/projet.html) et la template Flask
		qui contient le résultat de la transformation XSL (contenu_projet).
	"""
	xslt_projet_transformer = etree.XSLT(xslt_projet_doc)
	output_projet_doc = xslt_projet_transformer(source_doc)
	return render_template("pages/projet.html", contenu_projet=output_projet_doc)

@app.route("/bibliographie")
def bibliographie():
	"""Route permettant d'afficher la page bibliographie en retournant une template via l'objet Flask render_template(),
		où est défini le chemin vers le document html où le retour de la fonction sera affiché.
	"""
	return render_template("pages/bibliographie.html")

@app.route("/duc")
def duc():
	"""Route permettant d'afficher la page de biographie du duc en retournant une template via l'objet Flask render_template(),
		où est défini le chemin vers le document html où le retour de la fonction sera affiché.
	"""
	return render_template("pages/duc.html")

@app.route("/actes")
def corpus():
	"""Route permettant d'afficher la page de présentation du corpus des actes ducaux en retournant une template via
		l'objet Flask render_template(), où est défini le chemin vers le document html où le retour de la fonction sera affiché.
		La variable Actes_total contient le résultat d'une requête sur l'ensemble de la classe Acts et est stockée
		dans la template Flask document.
	"""
	Actes_total = Acts.query.all()
	return render_template("pages/corpus.html", document=Actes_total)

@app.route("/index-nominum")
def index_noms():
	"""Route permettant d'afficher la page de l'index nominum :
	(1) la méthode .XSLT() d'etree est appliquée à xslt_index_nom_doc, le résultat est stocké dans la variable
		xslt_index_nom_transformer ;
	(2) la feuille de transformation est appliquée au document XML (source_doc), le résultat est stocké dans la variable
		output_index_nom_doc ;
	(3) la fonction retourne une template via l'objet Flask render_template(), où sont définis le chemin vers le document
		html où le retour de la fonction sera affiché (pages/index_nominum.html) et la template Flask qui contient le
		résultat de la transformation XSL (contenu_index_nom).
	"""
	xslt_index_nom_transformer = etree.XSLT(xslt_index_nom_doc)
	output_index_nom_doc = xslt_index_nom_transformer(source_doc)
	return render_template("pages/index_nominum.html", contenu_index_nom=output_index_nom_doc)

@app.route("/index-prosopographique")
def index_prosopo():
	"""Route permettant d'afficher la page de l'index prosopographique :
	(1) la méthode .XSLT() d'etree est appliquée à xslt_index_prosopo_doc, le résultat est stocké dans la variable
		xslt_index_prosopo_transformer ;
	(2) la feuille de transformation est appliquée au document XML (source_doc), le résultat est stocké dans la
		variable output_index_prosopo_doc ;
	(3) la fonction retourne une template via l'objet Flask render_template(), où sont définis le chemin vers le
		document html où le retour de la fonction sera affiché (pages/index_prosopo.html) et la template Flask
		qui contient le résultat de la transformation XSL (contenu_index_prosopo).
	"""
	xslt_index_prosopo_transformer = etree.XSLT(xslt_index_prosopo_doc)
	output_index_prosopo_doc = xslt_index_prosopo_transformer(source_doc)
	return render_template("pages/index_prosopo.html", contenu_index_prosopo=output_index_prosopo_doc)

@app.route("/index-lieu")
def index_lieu():
	"""Route permettant d'afficher la page de l'index locorum :
	(1) la méthode .XSLT() d'etree est appliquée à xslt_index_lieux_doc, le résultat est stocké dans la variable
		xslt_index_lieux_transformer ;
	(2) la feuille de transformation est appliquée au document XML (source_doc), le résultat est stocké dans la
		variable output_index_lieux_doc ;
	(3) la fonction retourne une template via l'objet Flask render_template(), où sont définis le chemin vers le
		document html où le retour de la fonction sera affiché (pages/index-lieux.html) et la template Flask qui
		contient le résultat de la transformation XSL (contenu_index_lieux).
	"""
	xslt_index_lieux_transformer = etree.XSLT(xslt_index_lieux_doc)
	output_index_lieux_doc = xslt_index_lieux_transformer(source_doc)
	return render_template("pages/index-lieux.html", contenu_index_lieux=output_index_lieux_doc)

@app.route("/contact")
def contact():
	"""Route permettant d'afficher la page de contact en retournant une template via l'objet Flask render_template(),
		où est défini le chemin vers le document html où le retour de la fonction sera affiché.
	"""
	return render_template("pages/contact.html")

@app.route("/actes/<int:acte_id>")
def acte(acte_id):
	"""Route permettant d'afficher la page de présentation d'un acte :
	:param acte_id: numéro de l'acte
	(1) la méthode .XSLT() d'etree est appliquée à xslt_doc, le résultat est stocké dans la variable xslt_transformer ;
	(2) la feuille de transformation est appliquée au document XML (source_doc), le résultat est stocké dans la variable
		output_doc ;
	(3) la fonction retourne une template via l'objet Flask render_template(), où sont définis :
			* Le chemin vers le document html où le retour de la fonction sera affiché (pages/acte.html) ;
			* Les templates Flask qui contiennent le résultat de la transformation XSL (contenu_acte) et le numéro
			  de l'acte (id).
	"""
	xslt_doc = etree.parse("../Actes_Charles_Ier/app/static/xslt/corpus-xslt.xslt")
	xslt_transformer = etree.XSLT(xslt_doc)
	output_doc = xslt_transformer(source_doc, numero=str(acte_id))
	return render_template("pages/acte.html", contenu_acte=output_doc, id=acte_id)

@app.route("/recherche")
def recherche():
	"""Route permettant d'afficher la page recherche.
	(1) Des listes vides sont définies.
	(2) Des requêtes sont effectuées en boucle sur la classe Acts et les éléments trouvés sont ajoutés à la liste
		correspondante.
		Dans le libellés des dépôts d'archives départemenaux et municipaux, la méthode sub() de la librairie
		re permet, via une regex, de n'ajouter à la liste correspondante que le nom du département ou de la
		commune.
	(3) Les mentions 'NS' ([ville] non spécifiée) est retirée de list_city.
	(4) La fonction retourne une template via l'objet Flask render_template(), où sont définis :
			* Le chemin vers le document html où le retour de la fonction sera affiché (pages/recherche.html) ;
			* Les templates Flask qui contiennent les listes python.
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
	return render_template("pages/recherche.html", list_year=list_year, list_AN=list_AN, list_bib=list_bib, list_AD=list_AD, 
		list_AM=list_AM, list_deperdita=list_deperdita, list_state=list_state, list_type=list_type, list_city=list_city)

@app.route("/recherche/resultats")
def resultats():
	"""Route permettant d'afficher la page de résultats.
	(1) 
	"""
	motclef = request.args.get("keyword", None)
	motclef_annee = request.args.get("year", None)
	motclef_institution = request.args.get("archives", None)
	motclef_lieu_production = request.args.get("place", None)
	motclef_state = request.args.get("state", None)
	motclef_type = request.args.get("type", None)
	page = request.args.get("page", 1)
	if isinstance(page, str) and page.isdigit():
		page = int(page)
	else:
		page = 1
	resultats = []
	resultats_annee = []
	resultats_institution = []
	resultats_production = []
	resultats_state = []
	resultats_type = []
	if motclef :
		resultats = Acts.query.filter(
			Acts.analyse.like("%{}%".format(motclef))
			).paginate(page=page, per_page=RESULT_PAR_PAGES)
		return render_template("pages/resultats.html", motclef=motclef, resultats=resultats)
	elif motclef_annee:
		resultats_annee = Acts.query.filter(
			Acts.date.like("%{}%".format(motclef_annee))
			).paginate(page=page, per_page=RESULT_PAR_PAGES)
		return render_template("pages/resultats.html", motclef_annee=motclef_annee, resultats_annee=resultats_annee)
	elif motclef_institution :
		resultats_institution = Acts.query.filter(
			Acts.institution.like("%{}%".format(motclef_institution))
			).paginate(page=page, per_page=RESULT_PAR_PAGES)
		return render_template("pages/resultats.html", motclef_institution=motclef_institution, resultats_institution=resultats_institution)
	elif motclef_lieu_production:
		resultats_production = Acts.query.filter(
			Acts.place.like("%{}%".format(motclef_lieu_production))
			).paginate(page=page, per_page=RESULT_PAR_PAGES)
		return render_template("pages/resultats.html", motclef_lieu_production=motclef_lieu_production, resultats_production=resultats_production)
	elif motclef_state:
		resultats_state = Acts.query.filter(
			Acts.state.like("%{}%".format(motclef_state))
			).paginate(page=page, per_page=RESULT_PAR_PAGES)
		return render_template("pages/resultats.html", motclef_state=motclef_state, resultats_state=resultats_state)
	elif motclef_type:
		resultats_type = Acts.query.filter(
			Acts.type.like("%{}%".format(motclef_type))
			).paginate(page=page, per_page=RESULT_PAR_PAGES)
		return render_template("pages/resultats.html", motclef_type=motclef_type, resultats_type=resultats_type)
	else:
		return render_template('pages/error404.html')

@app.route("/mentionslegales")
def mentions_legales():
	"""Route permettant d'afficher la page des mentions légales en retournant une template via l'objet Flask
		render_template(), où est défini le chemin vers le document html où le retour de la fonction sera affiché.
	"""
	return render_template('pages/mentionslegales.html')

@app.errorhandler(404)
def page_not_found(error):
   return render_template('pages/error404.html', title = '404'), 404

# Ce if permet de vérifier que ce fichier est celui qui est courrament exécuté. Cela permet par exemple d'éviter
# de lancer une fonction quand on importe ce fichier depuis un autre fichier.
# En python, lorsque l'on exécute un script avec la commande `python script.py`
# Le fichier `script.py` a en __name__ la valeur __main__.
if __name__ == "__main__":
    app.run(debug=True)
