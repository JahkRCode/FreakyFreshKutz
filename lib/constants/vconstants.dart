library vconstants;

import 'package:freakyfreshkutz/constants/constants.dart' as Constants;

// ! ***** Constants: import 'package:freakyfreshkutz/constants/vconstants.dart' as vConstants; *****
// ! ***** Constants file for commonly used hardcoded variables
// ! ***** Examples: db variables/names

// ! ***** DB Names *****
const String DB_CALENDAR = 'calendar';
const String DB_USERS = 'users';
const String DB_SERVICES = 'services';

// ! ***** DB SubCollection and Document Names *****
const String DB_TIMESLOTS = 'timeSlots';

// ! ***** Attribute Fields *****
const String FIRST_NAME = 'firstName';
const String LAST_NAME = 'lastName';
const String PHONE_NUMBER = 'phoneNumber';
const String EMAIL = 'email';
const String PASSWORD = 'password';
const String ISADMIN = 'isAdmin';
const String RETYPED_PASSWORD = 'retypedPassword';
const String LAST_LOGIN = 'lastLogin';
const String ADS_CLICKED = 'adsClicked';
const String APPOINTMENTS = 'appointments';

const String NAME = 'name';
const String DESCRIPTION = 'description';
const String PRICE = 'price';
const String TIME_SLOT = 'time_slot';
const String LOYALTY_PTS = 'loyalty_points';

const String HAS_TIMES = 'hasTimes';
const String SERVICE = 'service';
const String ORDER = 'order';
const String AVAILABLE = 'Available';

// ! ***** Private Form Fields *****
const String FORM_FIRST_NAME = '_firstName';
const String FORM_LAST_NAME = '_lastName';
const String FORM_PHONE_NUMBER = '_phoneNumber';
const String FORM_EMAIL = '_email';
const String FORM_PASSWORD = '_password';
const String FORM_RETYPED_PASSWORD = '_retypedPassword';
const String FORM_LAST_LOGIN = '_lastLogin';

const String FORM_NAME = '_name';
const String FORM_DESCRIPTION = '_description';
const String FORM_PRICE = '_price';
const String FORM_TIME_SLOT = '_time_slot';
const String FORM_LOYALTY_PTS = '_loyalty_points';

// ! ***** Alert Dialog Text *****
const String AD_UPDATE_SUCCESSFUL = 'Update Successful!';
const String AD_UPDATE_CONTENT =
    'Your information has been successfully updated!';

const String AD_LOGIN_ERROR = 'Login Error Detected!';
const String AD_PASSWORD_MISMATCH = 'Password Mistmatch Detected!';
const String AD_PASSWORD_MISMATCH_CONTENT =
    'Retyped Password does not match. Please verify both passwords are correct.';

// ! ***** Button Label Text *****
const String BL_OK = 'OK';
const String BL_UPDATE = 'UPDATE';
const String BL_EDIT_INFO = 'Edit Your Info';
const String BL_CLIENT_LOGIN = 'Client Login';
const String BL_BECOME_CLIENT = 'Become a Client';
const String BL_PREV = 'PREV';
const String BL_NEXT = 'NEXT';
const String BL_SIGN_OUT = 'Sign Out';
const String BL_CREATE_UPDATE = 'CREATE/UPDATE';
const String BL_ADD_TIME = 'Add Time';

// ! ***** Card Label *****
const String CL_PHONE_NUMBER = 'Phone Number: ';
const String CL_BOOKED_APPOINTMENTS = 'Booked Appointments: ';
const String CL_ADS_CLICKED = 'Ads Clicked: ';
const String CL_LAST_LOGIN = 'Last Login: ';
const String CL_PRICE = 'Price: ';
const String CL_DURATION = 'Duration: ';
const String CL_MINUTES = 'minutes';
const String CL_MIN = 'min\n';
const String CL_SELECTED_DATE = 'Selected Date: ';
const String CL_NO_SERVICE = 'No Service Selected';
const String CL_SERVICE_SELECTED = 'Service Selected:\n';
const String CL_BOOKING_INFO = 'Booking Info:\n';
const String CL_SERVICE = 'Service:';
const String CL_DATE_SELECTED = 'Date:';

// ! ***** Form Labels *****
const String FL_FIRST_NAME = 'First Name';
const String FH_FIRST_NAME = 'Enter First Name';
const String FV_FIRST_NAME = 'First Name Required';

const String FL_LAST_NAME = 'Last Name';
const String FH_LAST_NAME = 'Enter Last Name';
const String FV_LAST_NAME = 'Last Name Required';

const String FL_PHONE_NUMBER = 'Phone Number';
const String FH_PHONE_NUMBER = 'Enter Phone Number';
const String FV_PHONE_NUMBER = 'Phone Number Required';

const String FL_EMAIL = 'Email';
const String FH_EMAIL = 'Enter Email';
const String FV_EMAIL = 'Email Required';

const String FL_PASSWORD = 'Password';
const String FH_PASSWORD = 'Enter Password';
const String FV_PASSWORD = 'Password Required';

const String FL_RETYPED_PASSWORD = 'Retype Password';
const String FH_RETYPED_PASSWORD = 'Retype Your Password';
const String FV_RETYPED_PASSWORD = 'Retyped Password Required';

const String FL_NAME = 'Service Name';
const String FH_NAME = 'Enter Service Name';
const String FV_NAME = 'Service Name Required';

const String FL_DESCRIPTION = 'Service Description';
const String FH_DESCRIPTION = 'Enter Service Description';
const String FV_DESCRIPTION = 'Service Description Required';

const String FL_PRICE = 'Service Price';
const String FH_PRICE = 'Enter Service Price';
const String FV_PRICE = 'Service Price Required';

const String FL_TIME_SLOT = 'Service Time Slot - # of 15min increments';
const String FH_TIME_SLOT =
    'Enter service duration by number of 15 minute increments';
const String FV_TIME_SLOT = 'Service Time Slot Required';

const String FV_SELECT_TIME_SLOT = 'SELECT TIME SLOT';

// ! ***** SCREEN LABELS *****
const String SL_ABOUT_COMPANY = 'About ${Constants.COMPANY_NAME}';
const String SL_CONTACT_COMPANY = 'Contact ${Constants.COMPANY_NAME}';
const String SL_BOOK_APPOINTMENT = 'Book Appointment';
const String SL_SCHEDULE_BOOKING = 'Schedule Booking';
const String SL_SERVICES = 'Services';
const String SL_SELECT_SERVICE = 'Select a Service';
const String SL_GALLERY = 'Gallery';
const String SL_CLIENT_LIST = 'Client List';
const String SL_EDIT_INFO = 'Edit Info';
const String SL_TIMESLOTS_AVAILABLE = 'Time Slots Available';
const String SL_SPLASH = 'splash';
// ! ***** DRAWER LABELS *****
const String DL_PROFILE = 'Profile:';
const String DL_NEXT_APPOINTMENT = 'Next Appointment:';
const String DL_SERVICES = 'Services';
const String DL_BOOK_APPOINTMENT = 'Book Appointment';
const String DL_GALLERY = 'Gallery';
const String DL_ABOUT_ME = 'About Me';
const String DL_CONTACT_ME = 'Contact Me';
const String DL_REFER_TO_FRIEND = 'Refer To Friend';
const String DL_MY_INFO = 'My Info';
const String DL_SHARE_SUBJECT = 'Refer Freaky Fresh Kutz';

// ! ***** SQUARE REST API *****
const String SQ_SOURCE_ID = 'source_id';
const String SQ_CARD_NONCE = 'card_nonce';
const String SQ_AUTOCOMPLETE = 'autocomplete';
const String SQ_IDEMPOTENCY_KEY = 'idempotency_key';
const String SQ_AMOUNT_MONEY = 'amount_money';
const String SQ_AMOUNT = 'amount';
const String SQ_CURRENCY = 'currency';
const String SQ_APP_FEE_MONEY = 'app_fee_money';
const String SQ_LOCATION_ID = 'location_id';
// ! ***** Time Slot Reference Object *****
const TIMESLOTS = {
  '0': '12:00 AM',
  '1': '12:15 AM',
  '2': '12:30 AM',
  '3': '12:45 AM',
  '4': '01:00 AM',
  '5': '01:15 AM',
  '6': '01:30 AM',
  '7': '01:45 AM',
  '8': '02:00 AM',
  '9': '02:15 AM',
  '10': '02:30 AM',
  '11': '02:45 AM',
  '12': '03:00 AM',
  '13': '03:15 AM',
  '14': '03:30 AM',
  '15': '03:45 AM',
  '16': '04:00 AM',
  '17': '04:15 AM',
  '18': '04:30 AM',
  '19': '04:45 AM',
  '20': '05:00 AM',
  '21': '05:15 AM',
  '22': '05:30 AM',
  '23': '05:45 AM',
  '24': '06:00 AM',
  '25': '06:15 AM',
  '26': '06:30 AM',
  '27': '06:45 AM',
  '28': '07:00 AM',
  '29': '07:15 AM',
  '30': '07:30 AM',
  '31': '07:45 AM',
  '32': '08:00 AM',
  '33': '08:15 AM',
  '34': '08:30 AM',
  '35': '08:45 AM',
  '36': '09:00 AM',
  '37': '09:15 AM',
  '38': '09:30 AM',
  '39': '09:45 AM',
  '40': '10:00 AM',
  '41': '10:15 AM',
  '42': '10:30 AM',
  '43': '10:45 AM',
  '44': '11:00 AM',
  '45': '11:15 AM',
  '46': '11:30 AM',
  '47': '11:45 AM',
  '48': '12:00 PM',
  '49': '12:15 PM',
  '50': '12:30 PM',
  '51': '12:45 PM',
  '52': '01:00 PM',
  '53': '01:15 PM',
  '54': '01:30 PM',
  '55': '01:45 PM',
  '56': '02:00 PM',
  '57': '02:15 PM',
  '58': '02:30 PM',
  '59': '02:45 PM',
  '60': '03:00 PM',
  '61': '03:15 PM',
  '62': '03:30 PM',
  '63': '03:45 PM',
  '64': '04:00 PM',
  '65': '04:15 PM',
  '66': '04:30 PM',
  '67': '04:45 PM',
  '68': '05:00 PM',
  '69': '05:15 PM',
  '70': '05:30 PM',
  '71': '05:45 PM',
  '72': '06:00 PM',
  '73': '06:15 PM',
  '74': '06:30 PM',
  '75': '06:45 PM',
  '76': '07:00 PM',
  '77': '07:15 PM',
  '78': '07:30 PM',
  '79': '07:45 PM',
  '80': '08:00 PM',
  '81': '08:15 PM',
  '82': '08:30 PM',
  '83': '08:45 PM',
  '84': '09:00 PM',
  '85': '09:15 PM',
  '86': '09:30 PM',
  '87': '09:45 PM',
  '88': '10:00 PM',
  '89': '10:15 PM',
  '90': '10:30 PM',
  '91': '10:45 PM',
  '92': '11:00 PM',
  '93': '11:15 PM',
  '94': '11:30 PM',
  '95': '11:45 PM',
};

const REF_TIMESLOTS = {
  '12:00 AM': '0',
  '12:15 AM': '1',
  '12:30 AM': '2',
  '12:45 AM': '3',
  '01:00 AM': '4',
  '01:15 AM': '5',
  '01:30 AM': '6',
  '01:45 AM': '7',
  '02:00 AM': '8',
  '02:15 AM': '9',
  '02:30 AM': '10',
  '02:45 AM': '11',
  '03:00 AM': '12',
  '03:15 AM': '13',
  '03:30 AM': '14',
  '03:45 AM': '15',
  '04:00 AM': '16',
  '04:15 AM': '17',
  '04:30 AM': '18',
  '04:45 AM': '19',
  '05:00 AM': '20',
  '05:15 AM': '21',
  '05:30 AM': '22',
  '05:45 AM': '23',
  '06:00 AM': '24',
  '06:15 AM': '25',
  '06:30 AM': '26',
  '06:45 AM': '27',
  '07:00 AM': '28',
  '07:15 AM': '29',
  '07:30 AM': '30',
  '07:45 AM': '31',
  '08:00 AM': '32',
  '08:15 AM': '33',
  '08:30 AM': '34',
  '08:45 AM': '35',
  '09:00 AM': '36',
  '09:15 AM': '37',
  '09:30 AM': '38',
  '09:45 AM': '39',
  '10:00 AM': '40',
  '10:15 AM': '41',
  '10:30 AM': '42',
  '10:45 AM': '43',
  '11:00 AM': '44',
  '11:15 AM': '45',
  '11:30 AM': '46',
  '11:45 AM': '47',
  '12:00 PM': '48',
  '12:15 PM': '49',
  '12:30 PM': '50',
  '12:45 PM': '51',
  '01:00 PM': '52',
  '01:15 PM': '53',
  '01:30 PM': '54',
  '01:45 PM': '55',
  '02:00 PM': '56',
  '02:15 PM': '57',
  '02:30 PM': '58',
  '02:45 PM': '59',
  '03:00 PM': '60',
  '03:15 PM': '61',
  '03:30 PM': '62',
  '03:45 PM': '63',
  '04:00 PM': '64',
  '04:15 PM': '65',
  '04:30 PM': '66',
  '04:45 PM': '67',
  '05:00 PM': '68',
  '05:15 PM': '69',
  '05:30 PM': '70',
  '05:45 PM': '71',
  '06:00 PM': '72',
  '06:15 PM': '73',
  '06:30 PM': '74',
  '06:45 PM': '75',
  '07:00 PM': '76',
  '07:15 PM': '77',
  '07:30 PM': '78',
  '07:45 PM': '79',
  '08:00 PM': '80',
  '08:15 PM': '81',
  '08:30 PM': '82',
  '08:45 PM': '83',
  '09:00 PM': '84',
  '09:15 PM': '85',
  '09:30 PM': '86',
  '09:45 PM': '87',
  '10:00 PM': '88',
  '10:15 PM': '89',
  '10:30 PM': '90',
  '10:45 PM': '91',
  '11:00 PM': '92',
  '11:15 PM': '93',
  '11:30 PM': '94',
  '11:45 PM': '95',
};
const AVAILABLE_TIMESLOTS = [
  '12:00 AM',
  '12:15 AM',
  '12:30 AM',
  '12:45 AM',
  '01:00 AM',
  '01:15 AM',
  '01:30 AM',
  '01:45 AM',
  '02:00 AM',
  '02:15 AM',
  '02:30 AM',
  '02:45 AM',
  '03:00 AM',
  '03:15 AM',
  '03:30 AM',
  '03:45 AM',
  '04:00 AM',
  '04:15 AM',
  '04:30 AM',
  '04:45 AM',
  '05:00 AM',
  '05:15 AM',
  '05:30 AM',
  '05:45 AM',
  '06:00 AM',
  '06:15 AM',
  '06:30 AM',
  '06:45 AM',
  '07:00 AM',
  '07:15 AM',
  '07:30 AM',
  '07:45 AM',
  '08:00 AM',
  '08:15 AM',
  '08:30 AM',
  '08:45 AM',
  '09:00 AM',
  '09:15 AM',
  '09:30 AM',
  '09:45 AM',
  '10:00 AM',
  '10:15 AM',
  '10:30 AM',
  '10:45 AM',
  '11:00 AM',
  '11:15 AM',
  '11:30 AM',
  '11:45 AM',
  '12:00 PM',
  '12:15 PM',
  '12:30 PM',
  '12:45 PM',
  '01:00 PM',
  '01:15 PM',
  '01:30 PM',
  '01:45 PM',
  '02:00 PM',
  '02:15 PM',
  '02:30 PM',
  '02:45 PM',
  '03:00 PM',
  '03:15 PM',
  '03:30 PM',
  '03:45 PM',
  '04:00 PM',
  '04:15 PM',
  '04:30 PM',
  '04:45 PM',
  '05:00 PM',
  '05:15 PM',
  '05:30 PM',
  '05:45 PM',
  '06:00 PM',
  '06:15 PM',
  '06:30 PM',
  '06:45 PM',
  '07:00 PM',
  '07:15 PM',
  '07:30 PM',
  '07:45 PM',
  '08:00 PM',
  '08:15 PM',
  '08:30 PM',
  '08:45 PM',
  '09:00 PM',
  '09:15 PM',
  '09:30 PM',
  '09:45 PM',
  '10:00 PM',
  '10:15 PM',
  '10:30 PM',
  '10:45 PM',
  '11:00 PM',
  '11:15 PM',
  '11:30 PM',
  '11:45 PM',
];

// ! ***** Miscellaneous Text *****
const String MT_HERO = 'hero';
const int CENT_CONVERSION = 100;
