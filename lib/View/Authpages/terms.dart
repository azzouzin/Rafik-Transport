import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafik/View/Compenents/theme.dart';

class TermesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TermesPageState();
}

class TermesPageState extends State<TermesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Text(
                  "Terms of use",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: maincolor),
                ),
                const Text(
                  "شروط الاستخدام\nالتعريف بالخدمة\n تطبيق Sharikcar لمشاركة السيارات يهدف إلى الربط بين المسافرين المتجهين إلى نفس الوجهة مع مقابل مادي يحدده السائق للمقعد الواحد .الغرض من شروط الاستخدام هذه هو تنظيم الوصول إلى التطبيق و استخدامه, وعند الضغط على زر التسجيل فإنك تُقِرُّ بقراءة كل هذه الشروط والموافقة عليها\n1.شروط إنشاء حساب في التطبيق\n يقتصر استخدام التطبيق على الأشخاص الذين يبلغون من العمر 18 عاما فأكثر .يشترط تقديم كل المعلومات والوثائق المطلوبة منك وإلا فإن التسجيل يعتبر ملغيا.عند التسجيل فإنك تتعهد بتقديم معلومات شخصية دقيقة وصادقة وتحديثها من ملف التعريف الخاص بك طول فترة تعاقدك مع تطبيق Sharikcar.2.استخدام الخدمات\nبالنقر على زر الموافقة فإنك تتعهد باستيفاء الشروط التالية والالتزام بها عند إنشاء الرحلات على التطبيق \nلديك رخصة سياقة سارية المفعول.أن تمتلك مركبتك الخاصة أو أن تستخدمها بإذن صريح من المالك.امتلاك السيارة لتأمين ساري المفعولأن تمتلك الأهلية الجسدية والنفسية للقيادة.السيارة التي تنوي استخدامها في الرحلة هي سيارة ذات 4 عجلات و 7 مقاعد كحد أقصى.إنك لا تقدم مقاعد أكثر مما هو متاح على سيارتك.أن تكون السيارة في حالة جيدة و خاضعة للفحص التقني الدوري .أن تستخدم التطبيق وفقا للقوانين المحلية والدولية.أن لا تحمل أي بضائع أو ممنوعات أو اشياء غير مرخصة أو غير قانونية، و تُخلي Sharikcar مسؤوليتها عن أي تجاوزات سواء من طرف السائق أو المسافرين.بصفتك عضوا مستوفيا للشروط فإنه يحق لك إنشاء الرحلات على التطبيق مع الإشارة إلى جميع معلومات الرحلة من \n تواريخ، مكان الوصول والانطلاق، معلوماتك الشخصية ومعلومات السيارة ، عدد المقاعد المتاحة، التكلفة...)أنت تُقِر بأنك المسؤول الوحيد عن إعلان الرحلة الذي تنشره على التطبيق وبهذا فإنك تتعهد بدقة وصدق جميع المعلومات الواردة في الإعلان كما تتعهد بتقديم خدمة تتوافق مع المعلومات الموضحة في إعلانك.تحتفظ Sharikcar بالحق في حذف كل إعلان لايتوافق مع الشروط المعمول بها وفقا لتقديرها ودون إشعار.3. الحجز بالنسبة للمسافرين\nيتقدم المسافر بطلب حجز رحلة عبر التطبيق ثم يتم قبول الحجز من طرف السائق على أن يتلقى المسافر تأكيدا للحجز بعد ذلك.يتم تدفع التكلفة بين السائق والمسافر بحسب طريقة الدفع التي يوفرها التطبيق ( يدويا، دفع الكتروني) 4.قبول الحجز والدفع بالنسبة للسائق\nالسائق مطالب بالرد على أي طلب حجز خلال فترة زمنية معينة وإن تعذر ذلك فإنه يتم إلغاء طلب الحجز تلقائيا.يجب على السائق دفع عمولة الرحلة المقدرة ب 18 % من مجموع التكلفة نهاية كل شهر .في حالة التملص من الدفع يتم اتخاذ الإجراءات اللازمة في حق السائق سواء بحظر حسابه أو متابعته قانونيا.بصفتك سائقا فإنك تتعهد بالالتزام بالمبلغ الذي حددته مسبقا للرحلة.5.سياسة الإلغاء\n بالنسبة للسائق\nيتعهد السائق بعدم إلغاء الرحلة إلا تحت ظرف قاهر على أن يعلم المسافرين بقرار الإلغاء ساعتين على الأقل قبل موعد الرحلة.يحق للسائق إلغاء حجز المسافر في حالة عدم حضوره إلى نقطة الالتقاء في أجل أقصاه 15 دقيقة.بالنسبة للمسافرين\n يتعهد المسافر بإعلام السائق بإلغاء حجزه ساعتين على الأقل قبل انطلاق الرحلة.يحق للمسافر إلغاء حجزه في حالة عدم حضور السائق إلى نقطة الالتقاء في أجل أقصاه 15 دقيقة.5.المسؤوليات والتعويض\nتنحصر مسؤولية التطبيق في الربط بين السائق والمسافرنحن غير مسؤولين عن أي ضياع للأغراض الشخصية أو عن الحوادث المختلفة الوقوع أو أي أضرار ناتجة عن استخدام التطبيق .",
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: maincolor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        minimumSize:
                            Size(Get.size.width * 0.8, Get.size.height * 0.07)),
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("OK"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
