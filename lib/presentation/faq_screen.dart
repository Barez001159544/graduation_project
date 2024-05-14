import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../controllers/language_changer.dart';
import '../controllers/theme_changer.dart';
import '../custom theme data/themes.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class FaqStructure{
  String faqq;
  String faqa;

  FaqStructure(this.faqq, this.faqa);
}
// 11
List<FaqStructure> faqs=[
  FaqStructure("How to set up another account for one of my family members?", "If you're looking to establish an account or set up one for a family member, simply drop by your residential management office. Our dedicated staff will guide you through the process, ensuring everything is set up smoothly and efficiently. From creating new accounts to managing existing ones."),
  FaqStructure("How to recover the password of my current account?", "If you've forgotten your password, fear not! Simply navigate to the settings if you're logged into your account to recover it. Alternatively, swing by the residential management office, where our team can swiftly assist you in regaining access to your account within minutes."),
  FaqStructure("What are the services that are available through this app?", "Our residential management app boasts a plethora of features designed to streamline property management. From requesting repairs and protests to providing insights into your property portfolio and payment history, our app covers it all. Additionally, enjoy the convenience of digital payments seamlessly integrated with FIB, offering a comprehensive solution for all your property management needs."),
  FaqStructure("What if I had a complaint, how to inform the residential management?", "Our residential management app simplifies communication with our management staff by offering a dedicated 'Protest' section. Here, you can detail your concerns comprehensively, and our team will promptly address them."),
  FaqStructure("I need repairment, how to request one?", "Our residential management app streamlines the process of requesting assistance from our management staff. With our dedicated 'Maintenance' section, simply select the item requiring attention, and our staff will promptly address your needs."),
  FaqStructure("How to pay my monthly fee with this app?", "Accessing your monthly payment QR code is effortless with our app's integrated FIB QR code generator. Located conveniently at the top of the home screen, simply select your property from current month to generate the code instantly. Payment becomes a breeze as you can either scan the QR code directly or manually input the readable code."),
  FaqStructure("How to send money with my FIB account?", "To utilize this feature, ensure you have an active FIB account logged in. Once logged in, generate your unique payment QR code and readable code. From there, you have the option to scan the QR code directly from the FIB app or manually input the readable code. But don't forget to tap on DONE button once you pay."),
  FaqStructure("How to set up an FIB account?", "To create an FIB account, simply download it's mobile app and follow a few straightforward steps guided by the app's intuitive interface. Then you will have an account that just needs to be funded."),
  FaqStructure("Where can i find my payment history?", "From the home screen, you'll find a convenient button that directs you to the properties screen, where all the properties you own are displayed. Upon selecting a specific property, you'll gain access to its comprehensive payment history. Easily track and review all transactions associated with that property, ensuring transparency and peace of mind in your financial management."),
  FaqStructure("Who can see my repairment request?", "Your repairment requests are promptly dispatched to our dedicated engineering staff for immediate attention. Once received, they prioritize and address each request as swiftly as possible. Additionally, our management staff have visibility into these requests, enabling them to take appropriate actions if necessary."),
  FaqStructure("Who can see my protest request?", "Your compliance requests are securely accessible only to our management staff, ensuring confidentiality and swift action. They have the authority to review and take necessary actions promptly. "),
];

List<FaqStructure> faqsInArabic=[
  FaqStructure("كيفية إعداد حساب آخر لأحد أفراد عائلتي؟", "إذا كنت ترغب في إنشاء حساب أو إعداد حساب لأحد أفراد عائلتك، ما عليك سوى زيارة مكتب إدارة الإقامة السكنية. سيقوم فريقنا المخصص بتوجيهك خلال العملية، مضمنًا أن يتم إعداد كل شيء بسلاسة وفعالية. بدءًا من إنشاء حسابات جديدة إلى إدارة الحسابات الحالية."),
  FaqStructure("كيف يمكنني استعادة كلمة المرور الخاصة بحسابي الحالي؟", "إذا نسيت كلمة المرور الخاصة بك، لا داعي للقلق! ما عليك سوى التنقل إلى الإعدادات إذا كنت مسجل الدخول إلى حسابك لاستعادتها. بالإضافة إلى ذلك، يمكنك زيارة مكتب إدارة الإقامة السكنية، حيث يمكن لفريقنا مساعدتك بسرعة في استعادة الوصول إلى حسابك خلال دقائق."),
  FaqStructure("ما هي الخدمات المتاحة من خلال هذا التطبيق؟", "يتميز تطبيق إدارة الإقامة السكنية لدينا بمجموعة من الميزات المصممة لتبسيط إدارة الممتلكات. من طلب الإصلاحات والاحتجاجات إلى توفير رؤى حول محفظتك العقارية وتاريخ الدفع، يغطي تطبيقنا كل شيء. بالإضافة إلى ذلك، تتمتع بسهولة الدفع الرقمي المتكاملة بسلاسة مع FIB، مما يوفر حلا شاملا لجميع احتياجات إدارة الممتلكات الخاصة بك."),
  FaqStructure("ماذا لو كان لدي شكوى؟ كيفية إبلاغ إدارة الإقامة السكنية؟", "يبسط تطبيق إدارة الإقامة السكنية لدينا التواصل مع فريق الإدارة لدينا من خلال تقديم قسم 'الاحتجاج' المخصص. هنا، يمكنك تفصيل مخاوفك بشمول، وسيقوم فريقنا بمعالجتها على الفور."),
  FaqStructure("أحتاج إلى إصلاح، كيف يمكنني طلبه؟", "يبسط تطبيق إدارة الإقامة السكنية لدينا عملية طلب المساعدة من فريق الإدارة لدينا. من خلال قسم 'الصيانة' المخصص، ما عليك سوى تحديد العنصر الذي يحتاج إلى اهتمام، وسيقوم فريقنا بمعالجة احتياجاتك على الفور."),
  FaqStructure("كيف يمكنني دفع رسومي الشهرية باستخدام هذا التطبيق؟", "من السهل الوصول إلى رمز الدفع الشهري الخاص بك مع مولد رمز الاستجابة السريعة المتكامل في تطبيقنا. تقع بشكل ملائم في أعلى الشاشة الرئيسية، ما عليك سوى تحديد العقار الخاص بك للشهر الحالي لتوليد الرمز على الفور. يصبح الدفع أسهل حيث يمكنك إما مسح رمز الاستجابة السريعة مباشرة أو إدخال الرمز القابل للقراءة يدوياً."),
  FaqStructure("كيف يمكنني إرسال الأموال باستخدام حسابي FIB؟", "للاستفادة من هذه الميزة، تأكد من أن لديك حساب FIB نشط تم تسجيل الدخول إليه. بمجرد تسجيل الدخول، قم بإنشاء رمز الدفع الخاص بك والرمز القابل للقراءة الفريد. من هناك، لديك خيار مسح رمز الاستجابة السريعة مباشرة من تطبيق FIB أو إدخال الرمز القابل للقراءة يدويًا. ولكن لا تنسى النقر على زر 'تم' بمجرد دفعك."),
  FaqStructure("كيف يمكنني إعداد حساب FIB؟", "لإنشاء حساب FIB، ما عليك سوى تنزيل تطبيقه على الهاتف المحمول واتباع عدد قليل من الخطوات البسيطة الموجهة من خلال واجهة التطبيق البديهية. بعد ذلك، سيكون لديك حساب يحتاج فقط إلى التمويل."),
  FaqStructure("أين يمكنني العثور على تاريخ دفعاتي؟", "من الشاشة الرئيسية، ستجد زرًا ملائمًا يوجهك إلى شاشة الخصائص، حيث يتم عرض جميع العقارات التي تمتلكها. عند اختيار عقار معين، ستحصل على وصول إلى تاريخ الدفع الشامل له. يمكنك بسهولة تتبع ومراجعة جميع المعاملات المرتبطة بهذا العقار، مما يضمن الشفافية والراحة في إدارة أمورك المالية."),
  FaqStructure("من يمكنه رؤية طلبي الإصلاح؟", "تُرسل طلبات الإصلاح الخاصة بك على الفور إلى فريق الهندسة المخصص لدينا للتنفيذ الفوري. عند الاستلام، يقومون بتحديد أولوياتها ومعالجة كل طلب بأسرع ما يمكن. بالإضافة إلى ذلك، يمتلك فريق الإدارة رؤية لهذه الطلبات، مما يمكنهم من اتخاذ الإجراءات المناسبة إذا لزم الأمر."),
  FaqStructure("من يمكنه رؤية طلبي الاحتجاج؟", "يمكن الوصول الآمن إلى طلبات الامتثال الخاصة بك فقط لفريق الإدارة لدينا، مما يضمن السرية واتخاذ الإجراءات السريعة. لديهم السلطة لمراجعة واتخاذ الإجراءات اللازمة بسرعة."),
];

List<FaqStructure> faqsInKurdish=[
  FaqStructure("چۆن ئەکاونتێکی تر بۆ یەکێک لە ئەندامانی خێزانەکەم دابنێم؟", "ئەگەر تۆ بەدوای دامەزراندنی ئەکاونتێکدا دەگەڕێیت یان ئەکاونتێک بۆ ئەندامێکی خێزانەکەت دابنێیت، تەنها سەردانی ئۆفیسی بەڕێوەبردنی نیشتەجێبوونەکەت بکە. ستافی تایبەتمەندمان ڕێنماییتان دەکەن لە پرۆسەکەدا، دڵنیا دەبن لە ڕێکخستنی هەموو شتێک بە شێوەیەکی ڕێک و پێک و کارا. لە دروستکردنی ئەکاونتی نوێوە تا بەڕێوەبردنی ئەکاونتەکانی ئێستا."),
  FaqStructure("چۆن پاسۆردی ئەکاونتی ئێستام بگەڕێنمەوە؟", "ئەگەر پاسۆردەکەت لەبیر کردووە، مەترسە! تەنها بچۆ بۆ بەشی ڕێکخستنەکان ئەگەر ئەکاونتەکەت کراوەتەوە بۆ وەرگرتنەوەی. یانیش، بەلای ئۆفیسی بەڕێوەبردنی نیشتەجێبووندا بڕۆن، کە تیمەکەمان دەتوانێت بە خێرایی یارمەتیت بدات بۆ وەرگرتنەوەی ئەکاونتەکەت لە ماوەی چەند خولەکێکدا."),
  FaqStructure("ئەو خزمەتگوزاریانە چین کە لە ڕێگەی ئەم ئەپە بەردەستن؟", "ئەپی بەڕێوەبردنی نیشتەجێبوونمان کۆمەڵێک تایبەتمەندی لەخۆدەگرێت کە بۆ ڕێکخستنی بەڕێوەبردنی موڵک و ماڵەکەت داڕێژراون. لە داوای چاککردنەوە و ناڕەزایەتییەوە تا پێشکەشکردنی تێڕوانینێک بۆ پۆرتفۆلیۆی موڵکەکانت و مێژووی پارەدان، ئەپەکەمان هەمووی دەگرێتەوە. سەرەڕای ئەوەش، چێژ لە ئاسانکاری پارەدانی دیجیتاڵی وەربگرە کە بە شێوەیەکی بێ کێشە لەگەڵ FIB یەکخراوە، کە چارەسەرێکی گشتگیر پێشکەش دەکات بۆ هەموو پێداویستییەکانی بەڕێوەبردنی موڵکەکەت."),
  FaqStructure("چی ئەگەر سکاڵایەکم هەبوو، چۆن بەڕێوەبەرایەتی نیشتەجێبوون ئاگادار بکەمەوە؟", "ئەپی بەڕێوەبردنی نیشتەجێبوونمان پەیوەندی لەگەڵ ستافی بەڕێوەبردنەکەمان ئاسان دەکات بە دانانی بەشێکی تایبەت بە 'ناڕەزایەتی'. لێرەدا، دەتوانن بە شێوەیەکی گشتگیر نیگەرانییەکانتان بە وردی بخەنەڕوو، تیمەکەمان بەپەلە چارەسەریان دەکات."),
  FaqStructure("پێویستم بە چاککردنەوە هەیە، چۆن داوای بکەم؟", "ئەپی بەڕێوەبردنی نیشتەجێبوونمان پرۆسەی داوای یارمەتی رێکدەخات لە ستافی بەڕێوەبردنەکەمان. بە بەشی تایبەتی 'خزمەتگوزاری'مان، بە سادەیی ئەو شتە هەڵبژێرە کە پێویستی بە سەرنجدان هەیە، و ستافەکەمان بەپەلە چارەسەری پێداویستییەکانتان دەکەن."),
  FaqStructure("چۆن بەم ئەپە قستی مانگانەم بدەم؟", "دەستگەیشتن بە کۆدی QR ی پارەدانی مانگانەت بێ ماندووبوونە لەگەڵ درووستکەری کۆدی QR FIB ی یەکگرتووی ئەپەکەمان. بە شێوەیەکی گونجاو لە سەرەوەی شاشەی سەرەکیدا هەڵکەوتووە، بە سادەیی موڵکەکەت لە مانگی ئێستا هەڵبژێرە بۆ ئەوەی کۆدەکە دەستبەجێ دروست بکەیت. پارەدان دەبێتە شتێکی ئاسان چونکە دەتوانیت یان ڕاستەوخۆ کۆدی QR سکان بکەیت یان بە دەست کۆدی خوێنەرەوە دابنێیت."),
  FaqStructure("چۆن پارە بنێرم بە ئەکاونتی FIB؟", "بۆ بەکارهێنانی ئەم تایبەتمەندییە، دڵنیابە کە ئەژمێری FIB چالاکت هەیە کە چوویتە ژوورەوە. کاتێک چوویتە ژوورەوە، کۆدی QRی پارەدانی تایبەتی خۆت و کۆدی خوێنەرەوە دروست بکە. لەوێشەوە بژاردەی ئەوەت هەیە کە کۆدی QR ڕاستەوخۆ لە ئەپی FIB ەوە سکان بکەیت یان بە دەستی کۆدی خوێنەرەوە بخەیتە ناوەوە. بەڵام لەبیرت نەچێت کاتێک پارەت دا، پەنجە بنێیت لەسەر دوگمەی DONE."),
  FaqStructure("چۆن ئەکاونتی FIB دابنێین؟", "بۆ دروستکردنی ئەکاونتی FIB، تەنها ئەپی مۆبایلەکەی دابەزێنە و چەند هەنگاوێکی ڕاستەوخۆ پەیڕەو بکە کە بە ڕێنمایی ڕووکاری ئینتێلێکتیڤی ئەپەکە. پاشان ئەکاونتێکت دەبێت کە تەنها پێویستی بە بودجە هەیە."),
  FaqStructure("لە کوێ دەتوانم مێژووی پارەدانەکەم بدۆزمەوە؟", "لە شاشەی سەرەکییەوە دوگمەیەکی گونجاوت بۆ دەردەکەوێت کە ئاراستەت دەکات بۆ شاشەی موڵکەکان، کە هەموو ئەو موڵکانەی کە خاوەندارێتی دەکەیت پیشان دەدرێن. لەگەڵ هەڵبژاردنی موڵکێکی دیاریکراو، دەستت دەگات بە مێژووی گشتگیری پارەدانەکەی. بە ئاسانی بەدواداچوون و پێداچوونەوە بە هەموو مامەڵەکانی پەیوەست بەو موڵکە بکە، دڵنیابە لە شەفافیەت و ئارامی دەروونی لە بەڕێوەبردنی دارایی خۆتدا."),
  FaqStructure("کێ دەتوانێت داواکاری چاککردنەوەکەم ببینێت؟", "داواکاری چاککردنەوەتان بەپەلە دەنێردرێت بۆ ستافی ئەندازیاری تایبەتمەندمان بۆ ئەوەی دەستبەجێ ئاگاداربن. کاتێک وەرگیراون، هەر داواکارییەک بە خێرایی دادەنێن و چارەسەری دەکەن. سەرەڕای ئەوەش، ستافی بەڕێوەبردنمان توانای بینینیان هەیە بۆ ئەم داواکاریانە، ئەمەش وایان لێدەکات کە ئەگەر پێویست بوو ڕێوشوێنی گونجاو بگرنەبەر."),
  FaqStructure("کێ دەتوانێت داواکاری ناڕەزایی من ببینێت؟", "داواکارییەکانی ناڕەزایت تەنها ستافی بەڕێوەبردنمان بە شێوەیەکی پارێزراو دەستیان پێدەگات، ئەمەش نهێنی و کردەوەی خێرا مسۆگەر دەکات. دەسەڵاتی پێداچوونەوە و گرتنەبەری ڕێوشوێنی پێویستیان هەیە بەپەلە."),
];



class _FAQScreenState extends State<FAQScreen> {
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    ThemeData cTheme = Provider.of<ThemeChanger>(context).isDark? darkTheme:lightTheme;
    List lChanger;
    return Consumer<LanguageChanger>(
        builder: (_, languageChanger, __) {
          lChanger= languageChanger.data;
          return Directionality(
          textDirection: languageChanger.selectedLanguage=="ENG"?TextDirection.ltr:TextDirection.rtl,
          child: Scaffold(
            backgroundColor: cTheme.scaffoldBackgroundColor,
            body: SafeArea(
              child: Row(
                children: [
                  wid>600?Expanded(
                    flex: 1,
                    child: Container(
                        // color: Colors.blue,
                        padding: EdgeInsets.all(10),
                        // height: wid>600?hei:100,
                        // width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("FAQ", style: TextStyle(color: cTheme.primaryColor, fontSize: 90),),
                                Text(lChanger[4]["subtitle"], style: TextStyle(color: cTheme.primaryColorDark),),
                                RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: lChanger[4]["message1"],
                                          style: TextStyle(color: cTheme.primaryColorDark, fontFamily: "NotoSans"),
                                        ),
                                        TextSpan(
                                          text: lChanger[4]["message2"],
                                          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontFamily: "NotoSans"),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => launchUrlString('https://www.example.com'),
                                        ),
                                        TextSpan(
                                          text: lChanger[4]["message3"],
                                          style: TextStyle(color: cTheme.primaryColorDark, fontFamily: "NotoSans"),
                                        ),
                                      ],
                                    ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            ElevatedButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: cTheme.primaryColorLight,
                                foregroundColor: cTheme.primaryColorLight,
                                elevation: 0,
                              ),
                              child: Icon(Icons.arrow_back_rounded, color: cTheme.primaryColorDark,),
                            ),
                            // Center(child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_rounded, color: cTheme.primaryColorDark,))),
                          ],
                        )
                    ),
                  ):SizedBox(),
                  Expanded(
                    flex: 2,
                    child: Container(
                      // color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      // height: hei,
                      // width: wid>600?wid-100:wid,
                      child: ListView(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              wid>600?SizedBox():Container(
                                // color: Colors.blue,
                                  height: 280,
                                  padding: EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ElevatedButton(
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: cTheme.primaryColorLight,
                                          foregroundColor: cTheme.primaryColorLight,
                                          elevation: 0,
                                        ),
                                        child: Icon(Icons.arrow_back_rounded, color: cTheme.primaryColorDark,),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text("FAQ", style: TextStyle(color: cTheme.primaryColor, fontSize: 90),),
                                      Text(lChanger[4]["subtitle"], style: TextStyle(color: cTheme.primaryColorDark),),
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: lChanger[4]["message1"],
                                              style: TextStyle(color: cTheme.primaryColorDark, fontFamily: "NotoSans"),
                                            ),
                                            TextSpan(
                                              text: lChanger[4]["message2"],
                                              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontFamily: "NotoSans"),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () => launchUrlString('https://www.example.com'),
                                            ),
                                            TextSpan(
                                              text: lChanger[4]["message3"],
                                              style: TextStyle(color: cTheme.primaryColorDark, fontFamily: "NotoSans"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              Container(
                                // width: wid>600?wid*0.7:wid,
                                // color: Colors.red,
                                child: Column(
                                  children: List.generate(faqs.length, (index){
                                    return Container(
                                      margin: EdgeInsets.only(top: 10, bottom: index==faqs.length-1?10:0),
                                      decoration: BoxDecoration(
                                        // color: cTheme.primaryColorLight,
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      child: Theme(
                                        data: cTheme.copyWith(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                        ),
                                        child: ExpansionTile(
                                          shape: Border(),
                                          childrenPadding: EdgeInsets.all(10),
                                          iconColor: cTheme.primaryColorDark,
                                          // backgroundColor: Colors.blue,
                                          title: Text(languageChanger.selectedLanguage=="ENG"?faqs[index].faqq:(languageChanger.selectedLanguage=="ARB"?faqsInArabic[index].faqq:faqsInKurdish[index].faqq), style: TextStyle(color: cTheme.primaryColorDark, fontSize: 16),),
                                          children: [
                                            Text(languageChanger.selectedLanguage=="ENG"?faqs[index].faqa:(languageChanger.selectedLanguage=="ARB"?faqsInArabic[index].faqa:faqsInKurdish[index].faqa), style: TextStyle(color: cTheme.primaryColorDark, fontSize: 12),),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
