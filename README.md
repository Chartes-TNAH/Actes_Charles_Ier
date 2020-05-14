# Actes de Charles I<sup>er</sup> de Bourbon

"**Actes de Charles I<sup>er</sup>**" est une application Web visant à présenter un échantillon des actes de Charles I<sup>er</sup> de Bourbon et d’Agnès de Bourgogne, duc et et duchesse de Bourbon de 1434 à 1456. Elle s'appuie sur un mémoire de Master recherche dirigé par Olivier Mattéoni et présenté à l'École d'histoire de l'Université Paris I Panthéon-Sorbonne en juin 2018, dont le sujet était l'étude de la chancellerie de Charles I<sup>er</sup> au prisme de ses actes. 

Les actes présentés sont représentatifs de l'ensemble du corpus de par leurs états (originaux, *vidimus*, copies, *deperdita*) et leurs types (chartes, lettres patentes, mandements, lettres closes).

Cette application est développée par Jean-Damien Généro dans le cadre des enseignements du Master « Technologies numériques appliquées à l'histoire » de l'École nationale des chartes (```XML-TEI```, ```XSL```, ```HTML```, ```CSS```, ```Python```, ```SQL```).

---

## Fonctionnalités

  * Une édition diplomatique d'un échantillon des actes ducaux, sur une période allant de 1421 à 1431. Les actes se trouvent dans un fichier ```XML-TEI``` auquel est appliquée une feuille de transformation ```XSL``` dynamique. Celle-ci s'aplique à la section du fichier ```XML-TEI``` correspondant à l'```id``` de l'acte demandé dans l'url grâce à la librairie ```lxml``` de ```Python```. Le résultat de la transformation est ensuite placé dans un document ```HTML``` via des ```templates```, le contenu de ce document étant enfin affiché dans le navigateur.
  
  * Des index (anthroponymique, toponymique, prosopographique), constitués via le même système que l'édition diplomatique.
  
  * Des recherches par facettes (texte libre, années, lieux de production, lieux de conservation, états des actes, types des actes). Elles fonctionnent à partir de la librairie ```SQLAlchemy``` de ```Python``` et d'une base de données ```SQLite``` constituée automatiquement à partir du fichier ```XML-TEI``` et actualisée à chaque ouverture de l'application.
  
  * Des pages de présentation, de bibliographie et de biographie afin de contextualiser le projet.
  
---

## Installation

*Nota : commandes à exécuter dans le terminal (Linux ou macOS).*

  * Cloner le dossier : ```git clone https://github.com/Chartes-TNAH/Actes_Charles_Ier```
  
  * Installer l'environnement virtuel :
  
    * Vérifier que la version de Python est bien 3.x : ```python --version```;
    
    * Aller dans le dossier : ```cd Actes_Charles_Ier```;
    
    * Installer l'environnement : ```python3 -m venv [nom de l'environnement]```.
  
  * Installer les packages et librairies :
  
    * Activer l'environnement : ```source [nom de l'environnement]/bin/activate```;
    
    * Flask et lxml : ```pip3 install flask``` et ```pip3 install lxml``` ;
    
    * SQLAlchemy : ```pip install flask_sqlalchemy==2.3.2``` ;
    
    * Vérifier que tout est installé : ```pip freeze``` ;
    
    * Sortir de l'environnement : ```deactivate``` ;

---

## Lancement
  
  * Activer l'environnement : ```source [nom de l'environnement]/bin/activate``` ;
    
  * Lancement : ```python run.py``` ;
    
  * Aller sur ```http://127.0.0.1:5000/``` ;
    
  * Désactivation : ```ctrl + c``` ;
    
  * Sortir de l'environnement : ```deactivate```.

---

## Contact

Pour toutes questions ou remarques : :email: [jean-damien.genero@chartes.psl.eu](mailto:jean-damien.genero@chartes.psl.eu).

---
