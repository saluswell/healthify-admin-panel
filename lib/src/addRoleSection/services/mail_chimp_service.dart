import 'dart:convert';

import 'package:http/http.dart' as http;

class MailService {
  static const String apiKey =
      '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';
  static const String baseUrl = 'https://api.sendgrid.com/v3/mail/send';

  static Future<void> sendWelcomeEmail(String recipientEmail) async {
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };

    final email = {
      'personalizations': [
        {
          'to': [
            {'email': recipientEmail},
          ],
          'subject': 'Welcome to MyApp!',
        },
      ],
      'from': {'email': 'saluswell123@gmail.com'},
      'content': [
        {
          'type': 'text/plain',
          'value': 'Welcome to MyApp! We are excited to have you on board.',
        },
      ],
    };

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: json.encode(email),
      );

      if (response.statusCode == 202) {
        print('Welcome email sent successfully.');
      } else {
        print(
            'Failed to send welcome email. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } on Exception catch (e) {
      print("exception " + e.toString());
      // TODO
    }
  }

// static const String apiKey = 'YOUR_MAILCHIMP_API_KEY';
// static const String serverPrefix = 'YOUR_MAILCHIMP_SERVER_PREFIX';
// static const String audienceId = 'YOUR_AUDIENCE_ID';
//
// static Future<void> sendEmail(
//     String emailAddress, String subject, String message) async {
//   final url = Uri.https(
//       '$serverPrefix.api.mailchimp.com', '/3.0/lists/$audienceId/members');
//   final headers = {
//     'Content-Type': 'application/json',
//     'Authorization': 'apikey $apiKey',
//   };
//
//   final payload = {
//     'email_address': emailAddress,
//     'status': 'subscribed',
//     'merge_fields': {
//       'FNAME': 'First Name', // Replace with actual first name
//       'LNAME': 'Last Name', // Replace with actual last name
//     },
//   };
//
//   final response =
//       await http.post(url, headers: headers, body: json.encode(payload));
//
//   if (response.statusCode == 200) {
//     print('Email sent successfully.');
//   } else {
//     print('Failed to send email. Status code: ${response.statusCode}');
//     print('Response body: ${response.body}');
//   }
// }
}
