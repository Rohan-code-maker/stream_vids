import 'package:get/get.dart';

class Languages extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      "english":"English",
      "hindi":"हिंदी",
      "nepali":"नेपाली",
      "choose_language":"Choose Language",
      'email_hint': "Enter Your Email",
      'password_hint': "Enter Your Password",
      "fullName_hint":"Enter Your Full Name",
      "username_hint":"Enter Your Username",
      "avatar_hint" : "Select Avatar Photo",
      "coverImage_hint" : "Select cover Image",
      'internet_exception': "Internet Unavailable\nPlease check your internet connection",
      'retry': "Retry",
      'general_exception': "We're unable to process your request.\nPlease try again",
      "setting_up":"We're setting things up for you. This will only take a moment.",
      "welcome": "Hello and Welcome",
      "login_screen":"Login Screen",
      "register_screen":"Register Screen",
      "home_screen":"Home Screen",
      "login": "Login",
      "register":"Register",
      "forgot_password":"Forgot Password",
      "old_password_hint":"Enter Old Password",
      "new_password_hint":"Enter New Password",
      "invalid_email": "Invalid Email",
      "password_length": "Password must be at least 8 characters"
    },
    'hi_IN': {
      'email_hint': "अपना ईमेल दर्ज करें",
      'password_hint': "अपना पासवर्ड दर्ज करें",
      'internet_exception': "इंटरनेट अनुपलब्ध\nकृपया अपने इंटरनेट कनेक्शन की जांच करें",
      'retry': "पुनः प्रयास करें",
      'general_exception': "हम आपका अनुरोध संसाधित नहीं कर पा रहे हैं।\nकृपया पुनः प्रयास करें",
    },
    'ne_NP': {
      'email_hint': "तपाईंको इमेल प्रविष्ट गर्नुहोस्",
      'password_hint': "तपाईंको पासवर्ड प्रविष्ट गर्नुहोस्",
      'internet_exception': "इन्टरनेट उपलब्ध छैन\nकृपया तपाईंको इन्टरनेट जाँच गर्नुहोस्",
      'retry': "पुन: प्रयास गर्नुहोस्",
      'general_exception': "हामी तपाईंको अनुरोध प्रक्रिया गर्न असमर्थ छौं।\nकृपया फेरि प्रयास गर्नुहोस्",
    },
  };
  
}