from lxml import etree

# Variable pour la page de résultat
RESULT_PAR_PAGES = 5

# Parsage du document XML-TEI avec la méthode .parse() d'etree, et stockage du résultat dans source_doc :
source_doc = etree.parse("../Actes_Charles_Ier/app/static/xml/corpus-act-ch.xml")

# Parsage de la feuille de transformation XSL de la partie "Projet" avec la méthode .parse() d'etree, et stockage du résultat dans xslt_projet_doc :
xslt_projet_doc = etree.parse("../Actes_Charles_Ier/app/static/xslt/projet-xslt.xslt")

# Parsage de la feuille de transformation XSL de la partie "Index nominum" avec la méthode .parse() d'etree, et stockage du résultat dans xslt_index_nom_doc :
xslt_index_nom_doc = etree.parse("../Actes_Charles_Ier/app/static/xslt/index-nominum.xsl")

# Parsage de la feuille de transformation XSL de la partie "Index prosopographique" avec la méthode .parse() d'etree, et stockage du résultat dans xslt_index_prosopo_doc :
xslt_index_prosopo_doc = etree.parse("../Actes_Charles_Ier/app/static/xslt/index-xslt.xsl")

# Parsage de la feuille de transformation XSL de la partie "Index locorum" avec la méthode .parse() d'etree, et stockage du résultat dans xslt_index_lieux_doc :
xslt_index_lieux_doc = etree.parse("../Actes_Charles_Ier/app/static/xslt/index-locorum.xsl")