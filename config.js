/* ====== CONFIGURATION XACE IA SEARCH ====== */
const CONFIG = {
  // Laissez vide pour le MODE DÉMO (données locales). Remplissez pour le mode réel (voir LISEZ-MOI.md).
  SUPABASE_URL: "",
  SUPABASE_ANON_KEY: "",      // clé "anon public" uniquement, jamais la clé service_role

  WHATSAPP: "237670752783",   // numéro WhatsApp (format international sans +)
  PAIEMENT_NUMERO: "670752783", // numéro MTN MoMo / Orange Money pour recevoir les abonnements
  PRIX_FCFA: 500,             // prix de l'abonnement par mois
  JOURS_ABONNEMENT: 30,
  RECHERCHES_GRATUITES: 10,   // recherches gratuites par jour sans abonnement
  CODE_DEMO: "XACE-DEMO"      // code d'activation valable seulement en mode démo
};
