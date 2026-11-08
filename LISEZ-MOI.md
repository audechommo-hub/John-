# XACE IA Search

Application de recherche qui marche aussi sans connexion : emplois, produits, savoir-faire et publicités. Publication gratuite, abonnement Premium à 500 FCFA/mois.

## Les fichiers (tous à la racine, dans le même dossier)
- `index.html` : l'application
- `config.js` : vos réglages (numéros, prix, base de données)
- `sw.js` : fait fonctionner l'application sans connexion
- `manifest.json` et `icon.svg` : permettent de l'installer sur le téléphone
- `setup.sql` : à coller dans Supabase (mode réel)
- `LISEZ-MOI.md` : ce guide

## Étape 1 : mettre en ligne sur Vercel (mode démo, 10 minutes)
1. Sur **github.com**, créez un dépôt (« New repository »), par exemple `xace-search`.
2. « uploading an existing file » : envoyez les fichiers `index.html`, `config.js`, `sw.js`, `manifest.json`, `icon.svg`. Ils doivent être à la racine, pas dans un sous-dossier. Puis « Commit changes ».
3. Sur **vercel.com** : « Add New… » > « Project », choisissez le dépôt, laissez les réglages par défaut (Framework : « Other »), puis « Deploy ».
4. Vercel vous donne une adresse du type `xace-search.vercel.app`. Ouvrez-la sur le téléphone, puis menu du navigateur > « Ajouter à l'écran d'accueil » : l'application s'installe.

En mode démo, les données restent sur chaque téléphone : chaque utilisateur ne voit que les exemples et ses propres publications. Pour que tout le monde voie les mêmes publications, passez à l'étape 2.

## Étape 2 : mode réel, publications partagées (Supabase gratuit)
1. Sur **supabase.com** : créez un compte et un projet.
2. « SQL Editor » > « New query » : collez tout `setup.sql`, puis « Run ».
3. « Project Settings » > « API » : copiez le « Project URL » et la clé « anon public ». Collez-les dans `config.js` (`SUPABASE_URL` et `SUPABASE_ANON_KEY`). N'utilisez jamais la clé « service_role ».
4. Dans GitHub, ouvrez `config.js`, touchez le crayon, collez, puis « Commit changes ». Vercel remet le site à jour tout seul.

## Au quotidien
- **Valider les publications** : dans Supabase > « Table Editor » > `posts`, passez `approved` à `true` pour celles que vous acceptez. Sans cela, personne ne les voit. Cela vous protège contre les arnaques et les contenus interdits.
- **Vendre un abonnement** : le client envoie 500 FCFA par MoMo ou Orange Money et vous envoie la preuve sur WhatsApp. Vous créez un code dans le SQL Editor : `insert into public.codes (code, jours) values ('XACE-AB12CD', 30);` puis vous le lui envoyez. Le code ne marche qu'une fois.
- **Voir vos gains de pub** : la requête est à la fin de `setup.sql` (vues divisées par 1000, multipliées par le tarif que vous aurez négocié).

## Ce qu'il faut savoir
- **Recherche « partout dans le monde » sans connexion** : l'application cherche dans les données téléchargées au dernier passage en ligne. Elle ne peut pas interroger internet quand il n'y a pas de réseau. Plus il y a de publications, plus elle est utile.
- **Publicité à 100 $ pour 1000 vues** : c'est un tarif très élevé. Les régies publicitaires paient souvent moins de 5 $ pour 1000 vues en Afrique. Ce tarif n'est possible que si un annonceur accepte de le payer. Et si la publication est gratuite pour les entreprises, vos revenus viendront surtout des abonnements ou d'options payantes (mise en avant, par exemple).
- **Abonnement** : la vérification de l'abonnement se fait dans le téléphone. Un utilisateur très technique pourrait la contourner. C'est suffisant pour démarrer. Plus tard, on pourra la déplacer sur le serveur.
- **Prix** : vos notes disent « 10 $/mois » et « 500 FCFA ». J'ai mis 500 FCFA. Changez `PRIX_FCFA` dans `config.js` si vous voulez autre chose.
