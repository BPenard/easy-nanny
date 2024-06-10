RAF :
- gérer les deux icones pour les deux boutons
- intégrer en db la date d'envoi à PAJEemploi
- S'il y a une date dans la DB le bouton est grisé et une date d'envoi est affichée

Questions
- Payslips icons : comment gérer le même comportement pour 2 boutons ? 2 contrôleurs ?

- Button controler : Comment gérer l'URL dans l'appli
- Dans le payslip_controler : comment gérer dans la méthode save pour récupérer la date et la mettre en DB ?


Payslip index / Show
Je veux faire de l'AJAX pour gérer 2 cas :
- 1 On peut avoir plusieurs contrats et donc je veux pouvoir changer de contrat
- 2 sur chaque contrat je peux avoir plusieurs payslips, je veux pouvoir changer de payslip via un bouton
    Je sais afficher dans une drop down la liste des payslips
    comment je peux faire pour identifier quel payslip j'affiche dans mon contrôleur ?
    -> Mon envie ce serait de passer dans les query params l'id du contrat et le mois de la payslip
      récupérer les éléments et les intégrer dans une page skeleton html.


TODO : remettre la seed correctement
