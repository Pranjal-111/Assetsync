import 'dart:convert';

import 'package:assetsync/model/assests_count_model.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mysql1/mysql1.dart';

final connectionSettings = ConnectionSettings(
    host: "sql830.main-hosting.eu",
    port: 3306,
    user: "u921198258_vivekbudakoti",
    password: 'Dev123456',
    db: 'u921198258_Assets');

final FTPConnect ftpConnect =
    FTPConnect('ftp.assetsync.tech', user: 'u921198258.sih', pass: '#Dev@123');

final secretKey = utf8.encode('assetsync');
// ignore: deprecated_member_use
final smtpServer = gmail('sihasset595@gmail.com', "kjbzhewujmfmhwyl");

const senderAdress = Address('sihasset595@gmail.com', 'Admin Asset Sync');

const List<String> userType = [
  'superAdmin',
  'stateAdmin',
  'districtAdmin',
  'subAreaAdmin'
];

const List<String> assetType = [
  'Schools',
  'College',
  'District Center',
  'Block Center',
  'Cluster Center',
  'Regional Office',
  'Central Government Office',
  'State Government Office'
];

const String privacyUrl =
    'https://www.privacypolicygenerator.info/live.php?token=QfO7qxtOD8IVz5MV0rFPMAj2OiqEx80K';

const String termsAndCondtionsURL =
    'https://www.termsandconditionsgenerator.com/live.php?token=Ls4vzHGoNltHWUEFjIakrDseeWXNRqfi';

const String aboutUsContent =
    'Since its launch on 26th July 2014, by Hon’ble Prime Minister, Shri Narendra Modi, MyGov has more than 24.5 million registered users. Almost all Government Departments leverage MyGov platform for their citizen engagement activities, consultations for policy formulation and also to disseminate information to citizens for various Government schemes and programs. MyGov is amongst the most active profiles on Social Media – Twitter, Facebook, Instagram, YouTube & LinkedIn with the username @MyGovIndia. MyGov has a significant presence on several Indian social media platforms like Koo, Sharechat, Chingari, Roposo, Bolo Indya and Mitron. MyGov has adopted multiple engagement methodologies like discussions, tasks, polls, surveys, blogs, talks, pledges, quizzes and on-ground activities by innovatively using internet, mobile apps, IVRS, SMS and outbound dialling (OBD) technologies.\n\nMyGov has also launched State instances in 18 States, namely Himachal Pradesh, Haryana, Maharashtra, Madhya Pradesh, Arunachal Pradesh, Assam, Manipur, Tripura, Chhattisgarh, Jharkhand, Nagaland, Uttarakhand, Goa, Tamil Nadu, Uttar Pradesh, Jammu & Kashmir, karnataka and Gujarat.\n\nMyGov is part of Digital India Corporation, a Section 8 company under Ministry of Electronics and IT, Government of India.\n\nMyGov has had significant success in terms of engaging with citizens. Logos and Tagline of key National Projects have been crowdsourced through MyGov. Few Notable crowdsourced initiatives are Logo for Swachh Bharat, Logo for National Education Policy, Logo for Digital India Campaign, etc. MyGov has time and again solicited inputs of draft policies from citizens few of those are National Education Policy, Data Centre Policy, Data Protection Policy, National Ports Policy, IIM Bill etc. MyGov have also been frequently soliciting ideas for Mann Ki Baat, Annual Budget, Pariksha Pe Charcha and many more such initiatives.\n\nMyGov has also launched State instances in 18 States, namely Himachal Pradesh, Haryana, Maharashtra, Madhya Pradesh, Arunachal Pradesh, Assam, Manipur, Tripura, Chhattisgarh, Jharkhand, Nagaland, Uttarakhand, Goa, Tamil Nadu, Uttar Pradesh, Jammu & Kashmir, karnataka and Gujarat.\n\nMyGov is part of Digital India Corporation, a Section 8 company under Ministry of Electronics and IT, Government of India.\n\nMyGov has had significant success in terms of engaging with citizens. Logos and Tagline of key National Projects have been crowdsourced through MyGov. Few Notable crowdsourced initiatives are Logo for Swachh Bharat, Logo for National Education Policy, Logo for Digital India Campaign, etc. MyGov has time and again solicited inputs of draft policies from citizens few of those are National Education Policy, Data Centre Policy, Data Protection Policy, National Ports Policy, IIM Bill etc. MyGov have also been frequently soliciting ideas for Mann Ki Baat, Annual Budget, Pariksha Pe Charcha and many more such initiatives.';

final List<AssetsCountModel> assetsCountList = [
  AssetsCountModel(title: 'Schools', count: 256),
  AssetsCountModel(title: 'Hospitals', count: 224),
  AssetsCountModel(title: 'Post Offices', count: 220),
  AssetsCountModel(title: 'CSC', count: 206),
  AssetsCountModel(title: 'Schools', count: 196),
  AssetsCountModel(title: 'Schools', count: 164)
];
