import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/service/setting_service.dart';
import 'package:citymall/util.dart';
import 'package:citymall/widgets/nointernet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicy extends StatelessWidget {

      SettingService setting=Get.put(SettingService());

      @override

      Widget build(BuildContext context) {
            setting.init();
            var name='${setting.setting?['company_name']}(${setting.setting?['tagname']})';
            var phone='${setting.setting?['phone']}';
            var address='${setting.setting?['address']}';
            var pin='${setting.setting?['pincode']}';
            var email='${setting.setting?['email']}';
            var website='${setting.setting?['website_url']}';
            var tagname='${setting.setting?['tagname']}';
            NetworkController nc=Get.find();
            return Obx(()=>nc.hasConnection.value?Scaffold(
                appBar: AppBar(
                      elevation: 0,
                      foregroundColor: Colors.white,
                      title: Text(
                            "Privacy Policy",
                      ),
                      centerTitle: true,
                      leading:
                      InkWell(onTap: () => {Get.back()}, child: Icon(Icons.arrow_back)),
                ),
                body: SafeArea(
                    child: SingleChildScrollView(
                        child: Column(children: [
                              SizedBox(
                              height: 20,
                        ),
                        Padding(
                            padding: EdgeInsets.all(08),
                            child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    border: Border.all(
                                          color: Colors.grey, //                   <--- border color
                                          width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(09))),
                                child: SingleChildScrollView(
                                    child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        SizedBox(height: 20),
                                    PolicyParagraph(context,
                                        '${name}” (“Us”, “We”, “Company” or “Our”) owns, operates and manages a website having domain name'
                                            '${website} and related mobile application under the name and style of “${setting.setting?['tagname']}” '
                                            '. "App is a part of ${setting.setting?['company_name']}". ${setting.setting?['tagname']} provides'
                                            ' certain services to end-users and customers/community leaders who are registered with ${setting.setting?['tagname']} (“Users”, “You” or “Your”) which can be accessed, used and availed in accordance with Our terms and conditions of use available at ${website}/terms-and-conditions (“Terms of Use”) . ${setting.setting?['tagname']}'
                                            ' is an online platform providing services for the sale and purchase of daily need products and fast-moving'
                                            ' consumer goods including but not limited to grocery, baby care, git items,home and kitchen ware'
                                            ' products by Users and for facilitation of the same for end retail buyers through third parties'),
                                    SizedBox(height: 16),
                                    PolicyParagraph(context,
                                        'This Privacy Policy, inter alia, states the following:'),
                                    SizedBox(height: 16),
                                    PolicyParagraph(
                                        context,
                                        'The type of information collected from the Users, including Personal Information (as defined below) and Sensitive Personal Data or Information (as defined below) relating to an individual;'
                                            'The purpose, means and modes of collection, usage, processing, retention and destruction of such information; and'
                                            'How and to whom We will disclose such information'
                                            'This Privacy Policy shall apply to any person who visits, browses, uses or accesses the Platform. This Privacy Policy is an electronic record in terms of the Information Technology Act, 2000 and rules made thereunder. Further, this electronic record is generated by a computer system and does not require any physical or digital signatures. This Privacy Policy is published in compliance with section 43A of the Information Technology Act, 2000, regulation 4 of the Information Technology (Reasonable Security Practices and Procedures and Sensitive Personal Information) Rules, 2011 (the “SPI rules”), regulation 3(1) of the Information Technology (Intermediaries’ Guidelines) Rules, 2011. Any new features and/or services that are added to Our current service at any point in the future shall also be subject to the terms set out in this policy.'),
                                    SizedBox(height: 16),
                                    PolicyParagraph(context,
                                        '“Personal Information” is defined under the SPI rules to mean any information that relates to a natural person, which, either directly or indirectly, in combination with other information available or likely to be available to a body corporate, is capable of identifying such person. The SPI rules further define “Sensitive Personal Data or Information” of a person to mean personal information about that person relating to: (i) passwords to access the account on the Platform (as and when applicable); (ii) financial information such as bank accounts, credit and debit card details or other payment instrument details; (iii) information received by body corporate under lawful contract or otherwise. Note that the information collected by Us from You may constitute ‘personal information’ or ‘sensitive personal data or information’ under the SPI Rules.'),
                                    SizedBox(height: 16),
                                    PolicyParagraph(
                                        context,
                                        'In order to have access to all the features and benefits on Our Platform, a User must first create an account on Our Platform. To create an account, a User may be required to provide the following information, which such User recognizes and expressly acknowledges is personal information allowing others, including Us, to identify the User i.e. name, User ID, mobile GPS location, email address, gender, complete postal address, country, ZIP/postal code, age, phone number, password chosen by the User. In addition, at the time of a registered User purchasing any product, the User is required to provide certain sensitive personal information which includes its bank account or card details for undertaking transactions on the Platform including without limitation processing of refunds on the Platform. We may further seek permission to: (i) view User’s contacts in the device being used to access the Platform; (ii) create new contact in the User’s device'
                                            '(including ${name} Support and Whatsapp number) for User’s ease of use in future; (iii) store items/files in the User’s device to enable the User to share the same through Whatsapp. Other information requested on the account registration page, including the ability to receive promotional offers from Us, is optional. We may, in future, include other optional requests for information from the User to help Us to customize the Platform to deliver personalized information to the User.'),
                                    SizedBox(height: 16),
                                    PolicyHeading(context, 'DISCLAIMER-'),
                                    SizedBox(height: 16),
                                    PolicyParagraph(context,
                                        'ABY USING AND ACCESSING THE PLATFORM AND BY AVAILING THE SERVICES OR BY OTHERWISE GIVING US YOUR INFORMATION, YOU WILL BE DEEMED TO HAVE READ, UNDERSTOOD AND AGREED TO THE PRACTICES AND POLICIES OUTLINED IN THIS PRIVACY POLICY AND AGREE TO BE BOUND BY THE PRIVACY POLICY. YOU HEREBY CONSENT TO OUR COLLECTION, USE AND SHARING, DISCLOSURE OF YOUR INFORMATION AS DESCRIBED IN THIS PRIVACY POLICY. WE RESERVE THE RIGHT TO CHANGE, MODIFY, ADD OR DELETE PORTIONS OF THE TERMS OF THIS PRIVACY POLICY, AT OUR SOLE DISCRETION, AT ANY TIME. IF YOU DO NOT AGREE WITH THIS PRIVACY POLICY AT ANY TIME, DO NOT USE ANY OF THE SERVICES OR GIVE US ANY OF YOUR INFORMATION. IF YOU USE THE SERVICES ON BEHALF OF SOMEONE ELSE (SUCH AS END RETAIL BUYER) YOU REPRESENT THAT YOU ARE (I) AUTHORIZED BY SUCH INDIVIDUAL OR ENTITY TO ACCEPT THIS PRIVACY POLICY ON SUCH INDIVIDUAL’S OR ENTITY’S BEHALF, AND (II) HAVE OBTAINED THE CONSENT OF OR ARE AUTHORISED TO PROVIDE CONSENT ON BEHALF OF SUCH INDIVIDUAL OR ENTITY TO OUR COLLECTION, USE AND DISCLOSURE OF SUCH INDIVIDUAL’S INFORMATION IN ACCORDANCE WITH THE TERMS CONTAINED HEREIN. YOU MAY NOTE THAT THIS PRIVACY POLICY IS BASED ON THE APPLICABLE LAWS OF INDIA AND GOOD DATA PRIVACY PRACTICES ADOPTED BY THE COMPANY IN INDIA AND MAY BE FOUND DEFICIENT WITH RESPECT TO CERTAIN PRIVACY LAWS OF SOME OTHER COUNTRIES. BY VISITING THE PLATFORM YOU AGREE TO BE BOUND BY THE TERMS AND CONDITIONS OF THIS PRIVACY POLICY. IF YOU DO NOT AGREE WITH THE TERMS CONTAINED HEREIN, PLEASE DO NOT USE OR ACCESS OUR PLATFORM OR AVAIL ANY SERVICES ON THE PLATFORM. BY MERE USE OF THE ELECTRONIC MEDIA PLATFORM, YOU EXPRESSLY CONSENT TO OUR USE AND DISCLOSURE OF YOUR PERSONAL INFORMATION IN ACCORDANCE WITH THIS PRIVACY POLICY.'),
                                    SizedBox(height: 16),
                                    PolicyHeading(context, 'PURPOSE OF THIS PRIVACY POLICY'),
                                    SizedBox(height: 16),
                                    PolicyParagraph(context,
                                        'We respect your need to understand how and why information is being collected, used, disclosed, transferred and stored. Thus, We have developed this policy to familiarize You with Our practices and demonstrate Our commitment to the protection of Your privacy and Your personal information. This Privacy Policy sets out the way in which We process Your information when You visit the Platform in accordance with applicable data protection laws. By accessing Our website, application and services, You agree to be bound by the terms of this policy. It is important that You read this policy together with any other policies We may provide on specific occasions when We are collecting or processing your personal data, so that You are fully aware of how and why We are using your personal data. This policy supplements the other notices and is not intended to override them.'),
                                    SizedBox(height: 16),
                                    PolicyParagraph(context,
                                        'The information contained on this Platform and the personal information collected by using/ login and or accessing this Platform are stored at a secured server. It is stated by the server service provider that they have all the best security practices required for the server. The Platform is owned by Us and is located in India. Hence, we are bound by duty to abide by the laws, including but not limited to, regulations, rules, circulars and notifications governing privacy in India.'),
                                    SizedBox(height: 16),
                                    PolicyHeading(context, 'SCOPE OF THIS PRIVACY POLICY'),
                                    SizedBox(height: 16),
                                    PolicyParagraph(context,
                                        'We provide this Privacy Policy to inform You of Our policies and procedures regarding collection, storage, and processing and sharing of personal data that We receive from Users of the Platform or those which are stored or accessed by Us at the time of making a transaction on the Platform.With regard to this Privacy Policy, the terms "using" and "processing" information include, without limitation; the use of cookies; and the collection, storage, transfer, evaluation, deletion, disclosure, management, handling, modifying and use of personal data.'),
                                    SizedBox(height: 16),
                                    PolicyParagraph(context,
                                        'This Privacy Policy applies only to personal data that You provide Us via the Platform. We reserve the right to update this Privacy Policy from time to time to reflect any changes to Our products and services. We will do this by amending the Privacy Policy on the Platform. The changes will take effect automatically, as soon as they are posted on the Platform. In addition, We will notify all users by SMS and/or Whatsapp notification if any material changes are made to the policy, subject to the Users’ acceptance to receive emails from Us.'),
                                    SizedBox(height: 16),
                                    PolicyParagraph(context,
                                        'This Privacy Policy is applicable to all Users of this Platform. By using the Platform, registering with Us or by otherwise giving Us Your information, You will be deemed to have read, understood and agreed to the practices and policies outlined in this Privacy Policy and agree to be bound by the terms hereof. You hereby consent to Us collecting, using and sharing and disclosing Your information as described in this Privacy Policy. We reserve the right to change, modify, add or delete portions of the terms of this Privacy Policy, at Our sole discretion, at any time. If You do not agree with this Privacy Policy at any time, do not use any of the services, use or access the Platform or give Us any of Your information. Any User that does not agree with any provisions of the Privacy Policy has the option to discontinue the use of the Platform immediately.'),
                                    SizedBox(height: 16),
                                    PolicyParagraph(context,
                                        'This Privacy Policy does not apply to any third-party website(s) and mobile app(s). You are requested to take note that information and privacy practices of Our business partners, advertisers, sponsors or other sites to which We provide hyperlink(s), may be different from this policy, Hence, it is recommended that You review the Privacy Policy of any such third parties before You interact with such interfaces.'),
                                    SizedBox(height: 16),
                                    PolicyHeading(context,
                                        'COLLECTION AND PROCESSING OF PERSONAL DATA'),
                                    SizedBox(height: 16),
                                    PolicyParagraph(context,
                                        'We may collect and process your personal data for, including without limitation, the following purposes:'),
                                    SizedBox(height: 16),
                                    PolicyHeading(context, 'Providing Our services:'),
                                    SizedBox(height: 16),
                                    PolicyParagraph(context,
                                        'We might process your personal data for the purposes of providing Our services, facilitation, processing and fulfilment of the orders placed by the User for the sale and purchase of the products and provision of the, and/or for carrying out the transaction of the Users. For example, personal data is processed in order to set up'
                                        'your ${name} account or for the end retail buyer as the case may be, allow You to place orders for the products, facilitating completion of payment, processing and delivery of order for the sale and purchase of the products through the Platform and submit reviews to the Platform. We process the following personal data: (i) name; (ii) phone number; (iii) email address; (iv) home address; (v) IP address; (vi) location; (vii)${tagname} user account profile data.'),
            SizedBox(height: 16),
            PolicyHeading(context, 'Customer service:'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'We need to process personal data for this purpose because it enables Us to adequately respond to Users’ questions/ concerns and to verify the correctness of the order for the products placed by User on the Platform and delivery of such orders.'),
            SizedBox(height: 16),
            PolicyHeading(context, 'Marketing (Direct): '),
            SizedBox(height: 16),
            PolicyParagraph(context,
            ' We process Users’ data for (direct) marketing purposes. This means that We can contact customers to draw attention to Our services. For this purpose, We process the following personal data: (i) website behaviour; (ii) IP address;(iii) email address; (iv) postal address; (v) phone number (vi) online identifiers; (vii) order information; (viii) location; (ix) and account information.'),
            SizedBox(height: 16),
            PolicyHeading(context, 'MCommercial Use: '),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'All the information provided to Us by a User, including personal information or any sensitive personal data or information, is provided voluntarily. You understand that We may use certain information provided by You, which may include your personal information or sensitive personal data or information for (i) the purpose of providing the products and services offered through the Platform to You; (ii) commercial purposes and in an aggregated and anonymized form for research, statistical analysis and/or business intelligence purposes; (iii) sale or transfer of such research, statistical or intelligence data in an aggregated or non-personally identifiable form to third parties and affiliates; (iv) customer support related issues; (v) and enabling You to complete any transaction through the Platform.'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'In addition to the above, We may also use Your personal data for the following reasons, including but not limited to; (i) keep You informed of the transaction status; (ii) send You order confirmations via'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'SMS or WhatsApp or any other messaging service; (iii) send You any updates or changes to Your order(s); (iv) allow Our customer service to contact You, if necessary; (v) enable processing and delivery of order for the sale and purchase of the products through the Platform; (vi) facilitating completion of payment (vii) customize the content of Our website and mobile app; (viii) request You for reviews of the products and services offered through the Platform; (ix) send You verification message(s) or email(s); (x) validate/authenticate Your account and to prevent any misuse or abuse; (xi) contact You on Your birthday and/or anniversary to inform You of any special offers; (xii) send You important notices and communications regarding Our services availed or changes to the terms and conditions and/or policies; (xiii) to administer Our business and Platform; (xiv) to send You marketing related communications; (xv) to deal with enquiries and complaints raised by You and to troubleshoot problems; (xvi) ensure compliance with all applicable laws and to ensure safety of the Platform and all Users; (xvii) to obtain your Know Your Customer (KYC) details and credit report; (xviii) to prevent fraud, errors and/or any illegal activity on the Platform; (xix) to send invoices, statements, agreements and/or to collect payment from You or make payments to You (as the case may be). (xx) notification and updates of the delivery schedule.'),
            SizedBox(height: 16),
            PolicyHeading(context, 'DISCLOSURE OF DATA'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'It may be necessary for Us to disclose Your personal data whether by law, legal process and/or by request from public and/or governmental authorities within or outside of your country of residence. We may also disclose Your personal information if We determine that disclosure is necessary or appropriate for the purposes of law enforcement, national security or to prevent or stop any activity We may consider to be, or to pose a risk of being, illegal, unethical or legally actionable.'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'Some sections on the Platform are freely accessible by all Users and visitors and require no prior registration. Further, certain sections on the Platform are accessible by Users only after entering their details, username and password. Therefore, We request You to use a safe and secure device connected to an equally safe and secure network to access the Platform to ensure the safety of Your username, password and other information. We do not guarantee the security and/or privacy of any information, which may be available to all Users and visitors of the Platform publicly. Further, the Platform may contain links to other websites. Please note that We do not endorse any links or websites and are not responsible for the privacy practices of such third-party websites.'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'We automatically receive the URL of the site from which anyone visits. We also receive the Internet Protocol (IP) address of each User’s computer (or the proxy server a User used to access the World Wide Web), User’s computer operating system and type of web browser the User is using, email patterns, as well as the name of User’s ISP. This information is used to analyze overall trends to help Us improve Our services. The linkage between User’s IP address and User’s personally identifiable information is not shared with or disclosed to third parties. Notwithstanding the above, We may share and/or disclose some of the aggregate findings (not the specific data) in anonymized form (i.e., non-personally identifiable) with advertisers, sponsors, investors, strategic partners, and others in order to help grow Our business.'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'Note that We maintain a strict no-spam policy and do not rent, sell, disclose or share personal information belonging to You with other people or non-affiliated companies without Your consent, except to provide products or services which You have requested/placed ordered for or otherwise as specifically provided for in this Policy.'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'You agree that in addition to as may be provided in this policy, We may also disclose Your personal information under the following circumstances:'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'Third party service professionals and/or providers: We engage, retain or might, as per requirement and business needs of the Company, employ, engage, contract with third party service professionals/providers to work on behalf of or with Us, under agreements containing confidentiality obligations and in accordance with law, in relation to the services provided by Us on the Platform. These third party service providers may use Your personal information in assisting Us to communicate with You about Our offers, products, delivery of products, placing of orders of products, feedback of services and products, assisting in payment facilities, verification of credit information to process payment, providing customer support, assisting in advertising on the Platform, obtaining your KYC details or credit report, etc. We may employ third party companies and/or individuals to help improve or facilitate Our service, to provide the service on Our behalf, to perform platform-related services, including but not limited to: payment processing, maintenance services, fraud detection services, database management, web analytics, monitoring, delivery/logistics and evaluation services. In this event, your information may be shared with such third-party companies and/or individuals;'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'Compliance with laws and protection of Users: We may release your personal information when the same is required in order to comply with the law, in response to court orders, court summons, judgments, decrees, injunctions, arbitral awards, administrative orders, governmental investigation or orders of any government authority or any other legal process, to establish/exercise Our legal rights or defend against legal claims or in the event We reasonably believe that doing so is legally required or is in your interest to protect Your property or other legal rights or property or rights of others. We may also share your personal information in order to enforce and fully comply with Our terms of service and other Company policies;'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'Business transfer and mergers: We may transfer Your personal information if the Company is acquired by or merged with another Company, to the extent permitted by applicable law and/or required under the scheme/arrangement of merger, etc. In such an event We will notify You before Your personal information is transferred/shared with the other entity and hence becomes subject to a different Privacy Policy;'),
            SizedBox(height: 16),
            PolicyHeading(context, 'Contracting parties: '),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'We transfer/share Your information with Our service professionals or third-party contractors to facilitate the services such as delivery of products, payment gateways etc. to You in order to consummate the transaction.'),
            SizedBox(height: 16),
            PolicyHeading(context, 'With Your consent: '),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'in addition to the aforementioned circumstances, We may share Your personal information with third parties with Your prior consent and/or at Your request.'),
            SizedBox(height: 16),
            PolicyHeading(context,
            'COLLECTION AND USE OF NON-PERSONAL DATA COOKIES'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'Non-personal data is data that can never be used to identify an individual. We may collect information regarding customer activities on Our Platform. This aggregated information shall be used by Us in research, analysis, to improve and monitor Our services and for various promotional schemes. Such non-personal data may be shared in aggregated, non-personal form with third party to enhance customer experience, offerings or services.'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'The Platform uses cookies, and while using the Platform You will be prompted to accept all cookies. We may place text files in the browser files of Your computer system. A cookie itself does not contain personal information and it will only enable Us to relate Your use of the Platform and Your behaviour on the Platform to information that You have specifically and knowingly provided. The only personal information that a cookie can contain is the information You supply to the cookie. A cookie can’t read data off Your hard disk or read cookie files created by other websites.'),
            SizedBox(
            height: 16,
            ),
            PolicyParagraph(context,
            'We may place both permanent and temporary cookies. A permanent cookie will remain on your web browser until its expiry date, unless deleted prior to such expiry date. However, most cookies are “session cookies” meaning that they automatically get deleted from your computer system at the end of the session. You can refuse cookies by turning them off in Your browser or alternatively You can also set your browser to warn You before accepting any cookies. Therefore, You are always free to decline Our cookies if Your browser permits, however We use certain cookies to authenticate Users on each page after the User logs on to the Platform. If you, as a casual visitor, have inadvertently browsed any other page of this Website prior to reading this Privacy Policy, and You do not agree with the manner in which such information is obtained, collected, processed, stored, used, disclosed or retained, merely quitting this browser application should ordinarily clear all temporary cookies installed by Us. All visitors, however, are encouraged to use the “clear cookies” functionality of their browsers to ensure such clearing / deletion, as We cannot guarantee, predict or provide for the behavior of the equipment of all the visitors of the Platform. Note that You are not a casual visitor if You have willingly submitted any personal data or information to Us through any means, including email, post or through the registration process on the Platform. All such visitors will be deemed to be, and will be treated as Users for the purposes of this Privacy Policy, and in which case, this Privacy Policy applies in its entirety to such persons.'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'The data that cookies collect will be used to process and/or analyse information by third parties to help improve or facilitate Our Platform-related services including but not limited to maintenance services; fraud detection services; database management; web analytics; monitoring; and evaluation services. If You have any questions about Our cookie usage, please contact Us at the contact details/information mentioned below.'),
            SizedBox(height: 16),
            PolicyParagraph(
            context,
            'YOUR RIGHTS AND HOW TO EXERCISE THEM'
            'We respect the exercise of the rights You have in relation to the personal data We process or use. You can request access to or a copy of your personal data collected and processed by Us. You may also request the rectification and removal of personal data or the restriction of the processing of Your personal data. You also have the right to data portability. If You have an objection to use of Your data under this policy, please write to Our privacy team at'
            '${email}. To prevent misuse, We will ask You to identify yourself.'),
            SizedBox(height: 16),
            PolicyHeading(context, 'NOTE FOR ALL USERS'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'We do not control or endorse the content, messages or information found in any products or services and, therefore, We specifically disclaim any liability with regard to the products or services and any actions resulting from Your participation in any products or services, and You agree that you waive any claims against Us relating to same, and to the extent such waiver may be ineffective, you agree to release any claims against Us relating to the same.'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'You are responsible for maintaining the accuracy, truthfulness, correctness and completeness of the information You submit or provide to Us, on the Platform; and shall hold harmless and indemnify'
            '${tagname} from and against all claims arising out of or in relation to the wrongful information posted, provided by You to Us, on the Platform.'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'If Your personal information changes, You may correct, delete inaccuracies, or amend information by making the change on Our member information page or by contacting Us on'
            '${email}. There may be circumstances where We will not correct, delete or update Your personal data, including; (i) where the personal data is opinion data that is kept solely for evaluative purpose; and (ii) the personal data is in documents related to a prosecution if all proceedings relating to the prosecution have not been completed. If you wish to cancel your account or request that We no longer use your information, contact Us on'
            '${email}.'),
            SizedBox(height: 16),
            PolicyHeading(context, 'SECURITY'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'We understand the serious implications of data security and take extensive measures to ensure Your data and information is secured. We take extensive technical, and legal measures to safeguard Your personal data. The Platform uses a reliable SSL certificate to ensure Your personal data is not misused in any manner whatsoever. We use SSL encryption when transmitting certain kinds of information, such as financial services information or payment information. An icon resembling a padlock is displayed on the bottom of most browser windows during SSL transactions that involve debit/credit cards and other forms of payment. In case We ask You for Your debit/credit card number for payment or for verification purposes, the same will be SSL encrypted. The information You provide will be stored securely on Our servers. Once You choose to store or enter Your debit/credit card number, it will not be displayed back to You in its entirety when You retrieve or edit it in the future. Instead of the entire number, You will only see asterisks and either the first four digits or the last four digits of your debit/credit card number.'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'We also work with third party service providers/experts/trainers/professional, suppliers who provide services on Our behalf or to Us. We enter into agreements with such third-party service providers, experts, trainers, professional and suppliers to ensure complete security and safety of the User information. Such third-party service providers do not have any independent right to the information provided by Us to them.'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'Our employees and data processors, who have access to, and are associated with the processing of sensitive personal data or information, are obliged to respect the confidentiality of every User’s personal information or sensitive personal data and information. We have put in place procedures and technologies as per good industry practices and in accordance with the applicable laws, to maintain security of all personal data from the point of collection to the point of destruction. Any third-party data processor to which We transfer Personal Data shall have to agree to comply with those procedures and policies, or put in place adequate measures on their own.'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'No administrator of the Platform will have knowledge of Your password. It is important for You to protect against unauthorized access to Your password, Your computer and Your mobile phone. Ensure You log off from the Platform when finished. We do not undertake any liability for any unauthorised use of Your account and password. If You suspect any unauthorized use of Your account, you must immediately notify Us by sending an SMS or WhatsApp to Us or update Us through the support section on the Platform . You shall be liable to indemnify Us due to any loss suffered by Us due to such unauthorized use of Your account and password. Note that We make all User information accessible to Our employees, agents or partners and third parties only on a need-to-know basis, and binds only its employees to strict confidentiality obligations. However, We are not responsible for the confidentiality, security or distribution of Your personal information by Our partners and third parties outside the scope of Our agreement with such partners and third parties.'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'In case there is any breach of security, We will make all legally required disclosures concerning the breach and the confidentiality, or integrity of Your unencrypted electronically stored "personal data" to You via email or by posting it on Platform without unreasonable delay, in as far as is consistent with any legitimate needs of law enforcement and any measures required to determine the scope of the breach and to safeguard the integrity of data.'),
            SizedBox(height: 16),
            PolicyHeading(context, 'APPLICABLE LAWS AND REGULATIONS'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'We ensure that your data and information shall be protected under the provisions of General Data Protection Regulation (“GDPR”), Information Technology Act, 2000 and Information Technology (Reasonable Security Practices and Procedures and Sensitive Personal Data or Information) Rules, 2011 along with any amendments made to these acts, rules and regulations.'),
            SizedBox(height: 16),
            PolicyHeading(context, 'RETENTION PERIODS'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'We do not keep your personal data longer than necessary for the purpose of the processing. This includes, for example, the purposes of satisfying any legal, regulatory, accounting, reporting requirements, to carry out legal work, for the establishment or defence of legal claims. We may aggregate and anonymize your personal data (so that it can no longer be associated with you) for research or statistical purposes, in which case We may use this information indefinitely without further notice to you.'),
            SizedBox(height: 16),
            PolicyHeading(context, 'DATA PROTECTION'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'Under certain circumstances, You have rights under applicable data protection laws in relation to Your personal data. It is Our policy to respect Your rights and We will act promptly and in accordance with any applicable law, rule or regulation relating to the processing of Your personal data. Details of Your rights under GDPR are set out below:'),
            SizedBox(height: 16),
            PolicyHeading(context,
            'Right to be informed about how personal data is used-'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'You have a right to be informed about how We will use and share Your personal data. This explanation will be provided to You in a concise, transparent, intelligible and easily accessible format and will be written in clear and plain language;'),
            SizedBox(height: 16),
            PolicyHeading(
            context, 'Right to access personal data – '),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'You have a right to obtain confirmation of whether We are processing Your personal data, access to Your personal data and information regarding how Your personal data is being used by Us;'),
            SizedBox(height: 16),
            PolicyHeading(context,
            'Right to have inaccurate personal data rectified – '),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'You have a right to have any inaccurate or incomplete personal data rectified. If We have disclosed the relevant personal data to any third parties, We will take reasonable steps to inform those third parties of the rectification where possible;'),
            SizedBox(height: 16),
            PolicyHeading(context,
            'Right to have personal data erased in certain circumstances –'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'You have a right to request that certain personal data held by Us is erased. This is also known as the ‘right to be forgotten’. This is not a blanket right to require all personal data to be deleted. We will consider each request carefully in accordance with the requirements of any laws relating to the processing of your personal data;'),
            SizedBox(height: 16),
            PolicyHeading(context,
            'Right to restrict processing of personal data in certain circumstances –'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'You have a right to block the processing of your personal data in certain circumstances. This right arises if You are disputing the accuracy of personal data, if You have raised an objection to processing, if processing of personal data is unlawful and You oppose erasure and request restriction instead or if the personal data is no longer required by Us but You require the personal data to be retained to establish, exercise or defend a legal claim;'),
            SizedBox(height: 16),
            PolicyHeading(context, 'Right to data portability –'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            ' under certain circumstances, You have the right to request to receive a copy of Your personal data in a commonly used electronic format. This right only applies to personal data that You have provided to Us (for example by completing a form or providing information through the Platform). Information about You which has been gathered by monitoring Your behaviour will also be subject to the right to data portability. The right to data portability only applies if the processing is based on Your consent or if the personal data must be processed for the performance of a contract and the processing is carried out by automated means (i.e. electronically);'),
            SizedBox(height: 16),
            PolicyHeading(context,
            'Right to object to processing of personal data in certain circumstances (including where personal data is used for marketing purposes) –'),
            SizedBox(height: 16),
            PolicyParagraph(
            context,
            'You have a right to object to processing being carried out by Us if (a) We are processing personal data based on legitimate interests or for the performance of a task in the public interest (including profiling), (b) if We are using personal data for direct marketing purposes, or (c) if information is being processed for scientific or historical research or statistical purposes. You will be informed that You have a right to object at the point of data collection and the right to object will be explicitly brought to Your attention and be presented clearly and separately from any other information; and'
            'Right not to be subject to automated decisions where the decision produces a legal effect or a similarly significant effect –You have a right not to be subject to a decision which is based on automated processing where the decision will produce a legal effect or a similarly significant effect on You.'
            'You may exercise any of the above-mentioned rights by sending a request to Us on Our contact information as detailed below. You will not have to pay a fee to access Your personal data (or to exercise any of the other rights). However, We may charge a reasonable fee if Your request is clearly unfounded, repetitive or excessive. Alternatively, We may refuse to comply with Your request in these circumstances.'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'We may need to request specific information from You to help Us confirm Your identity and ensure Your right to access Your personal data (or to exercise any of Your other rights). This is a security measure to ensure that personal data is not disclosed to any person who has no right to receive it. We may also contact You to ask You for further information in relation to Your request to speed up Our response.'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'We try to respond to all legitimate requests within one month. Occasionally it may take Us longer than one calendar month if Your request is particularly complex or You have made a number of requests. In this case, We will notify You and keep You updated.'),
            SizedBox(height: 16),
            PolicyHeading(context, 'QUESTIONS OR COMPLAINTS'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            'If you have any question or complaints about the processing of your personal data, write to Us at ${email}. Our team will be happy to assist you.'),
            SizedBox(height: 16),
            PolicyHeading(context, 'CONTACT INFORMATION'),
            SizedBox(height: 16),
            PolicyHeading(context, 'Address:'),
            SizedBox(height: 16),
            PolicyParagraph(context,
            '${address} - ${pin} Email – Customer Support : ${email}'),
            ]),
            ),
            ),
            ),
            ])))):NoInternet(context));
      }
}
