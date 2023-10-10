import 'dart:developer';

import 'package:hive/hive.dart';

String getStatment(String word) {
  var box = Hive.box('myBox');

  String? language = box.get('mykey');

  return translateMap[word]![language]!;
}

void changeLanguage(String mykey) async {
  // Fetch the stored language key from shared preferences
  var box = Hive.box('myBox');

  box.put('mykey', mykey);
}

Map<String, Map<String, String>> translateMap = {
  "verifaction": {"ar": "تَحَقّق", "fr": "Vérification", "en": "Verification"},
  "Resend New Code": {
    "ar": "إعادة إرسال الرمز الجديد",
    "fr": "Renvoyer le nouveau code",
    "en": "Resend New Code"
  },
  "Didn't you receive any code?": {
    "ar": " لم تتلق أي رمز؟",
    "fr": "Vous n'avez reçu aucun code ?",
    "en": "Didn't you receive any code?"
  },
  "Enter your OTP code number": {
    "ar": "أدخل رقم رمز تَحَقّق الخاص بك",
    "fr": "Entrez votre numéro de code OTP",
    "en": "Verification"
  },
  "SharikCar provides you with the opportunity to profit from every trip you take in your car":
      {
    "ar": "SharikCar يوفر لك فرصة الربح من كل رحلة تقوم بها في سيارتك",
    "fr":
        "SharikCar vous offre la possibilité de profiter de chaque trajet que vous effectuez en voiture",
    "en":
        "SharikCar provides you with the opportunity to profit from every trip you take in your car"
  },
  "Ride": {"ar": "رحلة", "fr": "Voyage", "en": "Ride"},
  "Make your travel less expensive and more enjoyable by sharing your trip with other travelers":
      {
    "ar":
        "إجعل سفرك أقل تكلفة وأكثر متعة من خلال مشاركة رحلتك مع مسافرين آخرين",
    "fr":
        "Rendez votre voyage moins cher et plus agréable en partageant votre voyage avec d'autres voyageurs",
    "en":
        "Make your travel less expensive and more enjoyable by sharing your trip with other travelers"
  },
  "Try now!": {
    "ar": "جرب الآن !",
    "fr": "Essayez maintenant!",
    "en": "try now!"
  },
  "Hello!": {"ar": "مرحبًا!", "fr": "Bonjour!", "en": "Hello!"},
  "Language": {"ar": "لغة", "fr": "langue", "en": "language"},
  "Join our family": {
    "ar": "انضم إلى عائلتنا",
    "fr": "Rejoignez notre famille",
    "en": "Join our family"
  },
  "Register with us rither as a driver or as a passenger and enjoy a completely new experience with Sharikcar":
      {
    "ar":
        " سجل معنا كسائق أو كمسافر واستمتع بتجربة جديدة كليا مع  \nSharikcar \n",
    "fr":
        "Inscrivez-vous chez nous en tant que chauffeur ou passager et profitez d'une toute nouvelle expérience avec Sharikcar",
    "en":
        "Register with us rither as a driver or as a passenger and enjoy a completely new experience with Sharikcar"
  },
  "where do you want to go": {
    "ar": "إلى أين تريد الذهاب؟",
    "fr": "Où voulez-vous aller ?",
    "en": "where do you want to go"
  },
  "Name": {"ar": "اسم", "fr": "nom", "en": "Name"},
  "What is your current location?": {
    "ar": "ما هو موقعك الحالي؟",
    "fr": "Quelle est votre position actuelle ?",
    "en": "What is your current location?"
  },
  "What is your destination?": {
    "ar": "ما هي وجهتك؟",
    "fr": "Quelle est votre destination ?",
    "en": "What is your destination?"
  },
  "Search for rides": {
    "ar": "بحث",
    "fr": "Rechercher des courses",
    "en": "Search for rides"
  },
  "Book a ride": {
    "ar": "احجز رحلة",
    "fr": "Réserver une course",
    "en": "Book a ride"
  },
  "Date": {"ar": "التاريخ", "fr": "Date", "en": "Date"},
  "Price": {"ar": "السعر", "fr": "Prix", "en": "Price"},
  "Seats available": {
    "ar": "عدد المقاعد المتاحة",
    "fr": "Places disponibles",
    "en": "Seats available"
  },
  "Car Modele": {
    "ar": "نموذج السيارة",
    "fr": "modèle de voiture",
    "en": "Car Modele"
  },
  "Rating": {"ar": "التقييم", "fr": "Évaluation", "en": "Rating"},
  "Pay": {"ar": "دفع", "fr": "Payer", "en": "Pay"},
  "Choose payment method": {
    "ar": "اختر طريقة الدفع",
    "fr": "Choisir le mode de paiement",
    "en": "Choose payment method"
  },
  "hand to hand": {"ar": "يد بيد,", "fr": "main à avoir", "en": "Hand To hand"},
  "You can pay hand to hand or with baridi mob, please select a choice": {
    "ar": "يمكنك الدفع نقدًا أو باستخدام baridi mob ، يرجى الاختيار ",
    "fr":
        "Vous pouvez payer en espèces ou avec baridi mob, veuillez sélectionner une option",
    "en": "You can pay hand to hand or with baridi mob, please select a choice"
  },
  "pay with el dhahabia": {
    "ar": "ادفع مع الذهبية",
    "fr": "payer avec el dhahabia",
    "en": "pay with el dhahabia"
  },
  "Pay Driver": {
    "ar": " الدفع عند مقابلة السائق",
    "fr": "payez lorsque vous rencontrez le chauffeur",
    "en": "pay when you meet with the driver"
  },
  "Write a message": {
    "ar": "اكتب رسالة",
    "fr": "Écrire un message",
    "en": "Write a message"
  },
  "Profile": {"ar": "الملف الشخصي", "fr": "Profil", "en": "Profile"},
  "Update picture": {
    "ar": "تحديث الصورة",
    "fr": "Mettre à jour la photo",
    "en": "Update picture"
  },
  "Driver": {"ar": "سائق", "fr": "Chauffeur", "en": "Driver"},
  "Drivers": {"ar": "سائق", "fr": "Chauffeurs", "en": "Drivers"},
  "User": {"ar": "مسافر", "fr": "Utilisateur", "en": "User"},
  "Next": {"ar": "التالي", "fr": "Suivant", "en": "Next"},
  "Phone number": {
    "ar": "رقم الهاتف",
    "fr": "Numéro de téléphone",
    "en": "Phone number"
  },
  "Email": {"ar": "البريد الإلكتروني", "fr": "Email", "en": "Email"},
  "Continue": {"ar": "متابعة", "fr": "Continuer", "en": "Continue"},
  "Don't you have an account?": {
    "ar": " ليس لديك حساب؟",
    "fr": "Vous n'avez pas de compte ?",
    "en": "Don't you have an account?"
  },
  "Sign up": {"ar": "تسجل", "fr": "S'inscrire", "en": "Sign up"},
  "It seems that you don't have an account, let us help you to create one": {
    "ar": "يبدو أنك لا تملك حسابًا ، دعنا نساعدك على إنشائه ",
    "fr":
        "Il semble que vous n'ayez pas de compte, laissez-nous vous aider à en créer un",
    "en":
        "It seems that you don't have an account, let us help you to create one"
  },
  "Email": {"ar": "البريد الإلكتروني", "fr": "Email", "en": "Email"},
  "Phone number": {"ar": "رقم الهاتف", "fr": "Téléphone", "en": "Phone number"},
  "Name": {"ar": "الاسم", "fr": "Nom", "en": "Name"},
  "Password": {"ar": "كلمة المرور", "fr": "Mot de passe", "en": "Password"},
  "By selecting agree and continue below, i agree to terms of service and privacy policy":
      {
    "ar":
        "باختيار الموافقة والاستمرار أدناه ، أوافق على شروط الخدمة وسياسة الخصوصية",
    "fr":
        "En sélectionnant Accepter et continuer ci-dessous, j'accepte les conditions de service et la politique de confidentialité",
    "en":
        "By selecting agree and continue below, i agree to terms of service and privacy policy"
  },
  "Êtes-vous sûr de vouloir vous déconnecter?": {
    "ar": "هل أنت متأكد أنك تريد تسجيل الخروج؟",
    "fr": "Êtes-vous sûr de vouloir vous déconnecter?",
    "en": "Are you sure, you want to Logout?"
  },
  "Forget your password?": {
    "ar": "هل نسيت كلمة المرور؟",
    "fr": "Mot de passe oublié ?",
    "en": "Forget your password?"
  },
  "Log in": {"ar": "تسجيل الدخول", "fr": "Se connecter", "en": "Log in"},
  "Log out": {"ar": "تسجيل خروج", "fr": "Se déconnecter", "en": "Log out"},
  "Welcome back": {
    "ar": "مرحبا بك مرة أخرى",
    "fr": "Bienvenue",
    "en": "Welcome back"
  },
  "Password": {"ar": "كلمة المرور", "fr": "Mot de passe", "en": "Password"},
  "Continue": {"ar": "استمر", "fr": "Continuer", "en": "Continue"},
  "Forget your password?": {
    "ar": "هل نسيت كلمة مرورك؟",
    "fr": "Mot de passe oublié ?",
    "en": "Forget your password?"
  },
  "Happy to see you again, take your time and choose your rides": {
    "ar": "سعداء برؤيتك مرة أخرى ، خذ وقتك في اختيار رحلاتك",
    "fr":
        "Heureux de vous revoir, prenez votre temps et choisissez vos courses",
    "en": "Happy to see you again, take your time and choose your rides"
  },
  "Your rides": {"ar": "رحلاتك", "fr": "Vos trajets", "en": "Your rides"},
  "Time": {"ar": "وقت", "fr": "temps", "en": "Your rides"},
  "All active rides": {
    "ar": "جميع الرحلات النشطة",
    "fr": "Tous les trajets actifs",
    "en": "All active rides"
  },
  "Ride details": {
    "ar": "تفاصيل الرحلة",
    "fr": "Détails du trajet",
    "en": "Ride details"
  },
  "Seats available": {
    "ar": "المقاعد المتاحة",
    "fr": "Places disponibles",
    "en": "Seats available"
  },
  "Ride price": {
    "ar": "سعر الرحلة",
    "fr": "Prix du trajet",
    "en": "Ride price"
  },
  "Number of seats available": {
    "ar": "عدد المقاعد المتاحة",
    "fr": "Nombre de places disponibles",
    "en": "Number of seats available"
  },
  "Create new ride": {
    "ar": "إنشاء رحلة جديدة",
    "fr": "Créer un nouveau trajet",
    "en": "Create new ride"
  },
  "Biling details": {
    "ar": "تفاصيل الفواتير",
    "fr": "Détails de facturation",
    "en": "Biling details"
  },
};
