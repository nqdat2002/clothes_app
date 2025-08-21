import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chính Sách Bảo Mật'),
        backgroundColor: Colors.white,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cảm ơn quý khách hàng đã tin tưởng lựa chọn và mua sắm tại Pattern. Chúng tôi luôn mong mọi người sẽ có những trải nghiệm tuyệt vời, thoải mái, đầy tiện ích khi tham gia mua sắm tại Pattern. Cũng vì lẽ đó, Pattern luôn thấu hiểu quyền riêng tư của khách hàng là một trong những điều kiện tiên quyết cùng yêu cầu quan trọng không chỉ với khách hàng mà còn là đối với Pattern. Vì thế sau đây là chính sách bảo mật của chúng tôi, nơi mà giúp mọi người có cái nhìn rõ hơn về cách thức mà chúng tôi sử dụng cũng như bảo vệ thông tin của quý khách hàng.',
              style: TextStyle(fontSize: 16.0, height: 1.5),
              textAlign: TextAlign.justify,

            ),
            SizedBox(height: 16.0),
            Text(
              '1. Việc thu thập thông tin:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Pattern thu thập, lưu trữ và xử lý thông tin của khách hàng để hoàn tất việc mua hàng và liên hệ với khách hàng để nâng cao chất lượng dịch vụ. Thông tin cá nhân của khách hàng sẽ chỉ được sử dụng trong nội bộ của công ty Pattern cho việc phục vụ khách hàng. Chúng tôi không sử dụng, không chuyển giao, cung cấp hay tiết lộ cho bất kỳ bên thứ 3 nào khác về thông tin cá nhân của khách hàng khi không có sự cho phép đồng ý từ khách hàng ngoại trừ bên dịch vụ vận chuyển để họ có thể liên hệ, đảm bảo việc hàng hóa được giao tận tay người nhận. Trong khuôn khổ chính sách bảo mật, chúng tôi sẽ không tiết lộ thông tin cá nhân của khách hàng đến bất cứ bên nào mà không được quý vị chấp nhận trước hoặc chúng tôi được yêu cầu cung cấp theo các điều khoản của pháp luật.',
              style: TextStyle( height: 1.5),
              textAlign: TextAlign.justify,

            ),
            SizedBox(height: 16.0),
            Text(
              '2. Việc an toàn/ bảo mật:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Mọi thông tin khách hàng, cũng như các thông tin trao đổi giữa khách hàng và Pattern đều được lưu giữ và bảo mật bởi hệ thống của Pattern. Pattern luôn có các biện pháp quản lý, đề phòng cũng như xử lý thích hợp về kỹ thuật, an ninh để ngăn chặn việc truy cập, sử dụng trái phép thông tin khách hàng. Pattern cũng thường xuyên phối hợp với các chuyên gia bảo mật nhằm cập nhật những thông tin cùng hệ thống mới nhất về an ninh mạng để đảm bảo sự an toàn cho thông tin khách hàng khi khách hàng truy cập, đăng ký mua hàng.',
              style: TextStyle( height: 1.5),
              textAlign: TextAlign.justify,

            ),
            SizedBox(height: 16.0),
            Text(
              '3. Việc chia sẻ thông tin khách hàng:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Pattern xin một lần nữa nhấn mạnh rằng Pattern sẽ không sử dụng, cung cấp, trao đổi thông tin khách hàng cho bất kỳ bên thứ 3 nào dưới bất kỳ mục đích, hình thức nào ngoại trừ trường hợp phải thực hiện theo yêu cầu của các cơ quan Nhà nước có thẩm quyền hoặc theo quy định của Pháp luật hoặc việc cung cấp thông tin đó là cần thiết để Pattern cung cấp dịch vụ/ tiện ích cho khách hàng mà một cụ thể ở đây là việc cung cấp thông tin cho các đơn vị đối tác vận chuyển…',
              style: TextStyle( height: 1.5),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16.0),
            Text(
              '4. Việc chỉnh sửa, cập nhật thông tin cá nhân:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Các thông tin cá nhân khách hàng muốn cập nhật và chỉnh sửa xin vui lòng liên hệ bộ phận Chăm sóc khách hàng của Pattern qua bất kỳ phương thức liên hệ có sẵn nào của chúng tôi. Các khách hàng có thắc mắc nào khác cũng xin liên hệ bộ phận này để được hỗ trợ một cách tốt nhất.',
              style: TextStyle(height: 1.5),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16.0),


            Text(
              'Các thông tin cá nhân khách hàng muốn cập nhật và chỉnh sửa xin vui lòng liên hệ bộ phận Chăm sóc khách hàng của Pattern qua bất kỳ phương thức liên hệ có sẵn nào của chúng tôi. Các khách hàng có thắc mắc nào khác cũng xin liên hệ bộ phận này để được hỗ trợ một cách tốt nhất.',
              style: TextStyle( height: 1.5),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16.0),
            Text(
              'Chính Sách Mua Hàng:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Đổi hàng trong vòng 7 ngày\n- Ship COD toàn quốc\n- Hỗ trợ 24/7 với các kênh chat, email & phone',
              style: TextStyle( height: 1.5),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
