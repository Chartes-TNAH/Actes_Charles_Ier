from flask import Flask, render_template
from lxml import etree

from .app import app

@app.route("/")
def accueil():
    return render_template("accueil.html")

@app.route("/projet")
def projet():
	xslt_projet_doc = etree.parse("../Actes_Charles_Ier/app/static/xslt/projet-xslt.xslt")
	xslt_projet_transformer = etree.XSLT(xslt_projet_doc)
	source_projet_doc = etree.parse("../Actes_Charles_Ier/app/static/xml/corpus-act-ch.xml")
	output_projet_doc = xslt_projet_transformer(source_projet_doc)
	return render_template("pages/projet.html", contenu_projet=output_projet_doc)

@app.route("/bibliographie")
def bibliographie():
    return render_template("pages/bibliographie.html")

@app.route("/duc")
def duc():
    return render_template("pages/duc.html")

@app.route("/sommaire")
def sommaire():
	xslt_sommaire_doc = etree.parse("../Actes_Charles_Ier/app/static/xslt/sommaire-2.xsl")
	xslt_sommaire_transformer = etree.XSLT(xslt_sommaire_doc)
	source_sommaire_doc = etree.parse("../Actes_Charles_Ier/app/static/xml/corpus-act-ch.xml")
	output_sommaire_doc = xslt_sommaire_transformer(source_sommaire_doc)
	return render_template("pages/sommaire2.html", contenu_sommaire=output_sommaire_doc)
    #return render_template("pages/sommaire.html")

@app.route("/index-nominum")
def index_noms():
	xslt_index_nom_doc = etree.parse("../Actes_Charles_Ier/app/static/xslt/index-nominum.xsl")
	xslt_index_nom_transformer = etree.XSLT(xslt_index_nom_doc)
	source_index_nom_doc = etree.parse("../Actes_Charles_Ier/app/static/xml/corpus-act-ch.xml")
	output_index_nom_doc = xslt_index_nom_transformer(source_index_nom_doc)
	return render_template("pages/index_nominum.html", contenu_index_nom=output_index_nom_doc)

@app.route("/index-prosopographique")
def index_prosopo():
	xslt_index_prosopo_doc = etree.parse("../Actes_Charles_Ier/app/static/xslt/index-xslt.xsl")
	xslt_index_prosopo_transformer = etree.XSLT(xslt_index_prosopo_doc)
	source_index_prosopo_doc = etree.parse("../Actes_Charles_Ier/app/static/xml/corpus-act-ch.xml")
	output_index_prosopo_doc = xslt_index_prosopo_transformer(source_index_prosopo_doc)
	return render_template("pages/index_prosopo.html", contenu_index_prosopo=output_index_prosopo_doc)

@app.route("/index-lieu")
def index_lieu():
	xslt_index_lieux_doc = etree.parse("../Actes_Charles_Ier/app/static/xslt/index-locorum.xsl")
	xslt_index_lieux_transformer = etree.XSLT(xslt_index_lieux_doc)
	source_index_lieux_doc = etree.parse("../Actes_Charles_Ier/app/static/xml/corpus-act-ch.xml")
	output_index_lieux_doc = xslt_index_lieux_transformer(source_index_lieux_doc)
	return render_template("pages/index-lieux.html", contenu_index_lieux=output_index_lieux_doc)

@app.route("/contact")
def contact():
    return render_template("pages/contact.html")

@app.route("/sommaire/<int:acte_id>")
def acte(acte_id):
	source_doc = etree.parse("../Actes_Charles_Ier/app/static/xml/corpus-act-ch.xml")
	xslt_doc = etree.parse("../Actes_Charles_Ier/app/static/xslt/corpus-xslt.xslt")
	xslt_transformer = etree.XSLT(xslt_doc)
	output_doc = xslt_transformer(source_doc, numero=str(acte_id))
	return render_template("pages/acte.html", contenu_acte=output_doc, id=acte_id)


@app.errorhandler(404)
def page_not_found(error):
   return render_template('pages/error404.html', title = '404'), 404

'''
@app.route("/sommaire/<int:acte_id>")
def acte(acte_id):
	arbre = etree.parse("../Actes_Charles_Ier/app/static/xml/corpus-act-ch.xml")
	# Date de l'acte 
	date = arbre.xpath("//text[" + str(acte_id) + "]/front/docDate/date/text()")
	date_tps = "".join(date)
	# Lieu de l'acte
	lieu = arbre.xpath("//text[" + str(acte_id) + "]/front/docDate/placeName/text()")
	lieu_tps = "".join(lieu)
	# Regeste de l'acte
	analyse = arbre.xpath("//text[" + str(acte_id) + "]/front/argument/p/text()")
	regeste = "".join(analyse)
	# Tableau de la tradition (1) : copies et autre
	witnessA = arbre.xpath("//text[" + str(acte_id) + "]/front/witness[@n='A']//text()")
	temoinA = "".join(witnessA)
	# Tableau de la tradition (2) : copies et autre
	witness = arbre.xpath("//text[" + str(acte_id) + "]/front/listWit//text()")
	temoins = "".join(witness)
	# Texte de l'acte
	text = arbre.xpath("//text[" + str(acte_id) + "]/body/div[@type='acte']//text()")
	charte = "".join(text)
	# Mention hors teneur de l'acte
	mention = arbre.xpath("//text[" + str(acte_id) + "]/body/div[@type='MHT']//text()")
	mht = "".join(mention)
	# Signatures
	sign = arbre.xpath("//text[" + str(acte_id) + "]/body/div[@type='sign']//text()")
	signature = "".join(sign)
	return render_template("pages/acte.html", date=date_tps, lieu=lieu_tps, regeste=regeste, temoinA=temoinA, temoins=temoins, acte=charte, MHT=mht, signatures=signature, id=acte_id)
'''

# Ce if permet de vérifier que ce fichier est celui qui est courrament exécuté. Cela permet par exemple d'éviter
# de lancer une fonction quand on importe ce fichier depuis un autre fichier.
# En python, lorsque l'on exécute un script avec la commande `python script.py`
# Le fichier `script.py` a en __name__ la valeur __main__.
if __name__ == "__main__":
    app.run(debug=True)
