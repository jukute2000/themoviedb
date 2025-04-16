import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FirebaseHomeScreen extends StatefulWidget {
  const FirebaseHomeScreen({super.key});

  @override
  State<FirebaseHomeScreen> createState() => _FirebaseHomeScreenState();
}

class _FirebaseHomeScreenState extends State<FirebaseHomeScreen> {
  // Mock data cho danh sách chat
  final List<ChatModel> _chats = [
    ChatModel(
      id: '1',
      name: 'Nguyễn Văn A',
      avatarUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
      lastMessage: 'Hẹn gặp lại bạn vào ngày mai nhé!',
      time: DateTime.now().subtract(const Duration(minutes: 5)),
      unreadCount: 3,
      isOnline: true,
    ),
    ChatModel(
      id: '2',
      name: 'Trần Thị B',
      avatarUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      lastMessage: 'Đã gửi một hình ảnh',
      time: DateTime.now().subtract(const Duration(hours: 1)),
      unreadCount: 0,
      isOnline: true,
    ),
    ChatModel(
      id: '3',
      name: 'Lê Văn C',
      avatarUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
      lastMessage: 'Ok bạn nhé, tôi sẽ xem xét đề xuất của bạn',
      time: DateTime.now().subtract(const Duration(hours: 3)),
      unreadCount: 1,
      isOnline: false,
    ),
    ChatModel(
      id: '4',
      name: 'Phạm Thị D',
      avatarUrl: 'https://randomuser.me/api/portraits/women/4.jpg',
      lastMessage: 'Đã gửi một file đính kèm',
      time: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 0,
      isOnline: false,
    ),
    ChatModel(
      id: '5',
      name: 'Hoàng Văn E',
      avatarUrl: 'https://randomuser.me/api/portraits/men/5.jpg',
      lastMessage: 'Cuộc họp sẽ bắt đầu lúc 14h chiều nay',
      time: DateTime.now().subtract(const Duration(days: 2)),
      unreadCount: 0,
      isOnline: true,
    ),
    ChatModel(
      id: '6',
      name: 'Nhóm Marketing',
      avatarUrl: 'https://randomuser.me/api/portraits/women/6.jpg',
      lastMessage: 'Mai: Dự án sẽ được hoàn thành đúng thời hạn',
      time: DateTime.now().subtract(const Duration(days: 3)),
      unreadCount: 5,
      isOnline: false,
      isGroup: true,
    ),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tin nhắn',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Hành động tìm kiếm
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // Hiển thị menu
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Phần danh sách người dùng phía trên
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _chats.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 70, // Cố định chiều rộng
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              _chats[index].avatarUrl,
                            ),
                          ),
                          if (_chats[index].isOnline)
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        child: Text(
                          _chats[index].name.split(' ').last,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(),
          // Danh sách chat
          Expanded(
            child: ListView.builder(
              itemCount: _chats.length,
              itemBuilder: (context, index) {
                return ChatTile(chat: _chats[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tạo cuộc trò chuyện mới
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.chat),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Tin nhắn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Danh bạ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Khám phá',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Cá nhân',
          ),
        ],
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final ChatModel chat;

  const ChatTile({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(chat.avatarUrl),
          ),
          if (chat.isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 14,
                width: 14,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              chat.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            _formatTime(chat.time),
            style: TextStyle(
              fontSize: 12,
              color: chat.unreadCount > 0 ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              chat.lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: chat.unreadCount > 0 ? Colors.black : Colors.grey,
                fontWeight:
                    chat.unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          if (chat.unreadCount > 0)
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Text(
                chat.unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      onTap: () {
        // Điều hướng đến màn hình chat chi tiết
      },
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final timeDate = DateTime(time.year, time.month, time.day);

    if (timeDate == today) {
      return DateFormat('HH:mm').format(time);
    } else if (timeDate == yesterday) {
      return 'Hôm qua';
    } else {
      return DateFormat('dd/MM').format(time);
    }
  }
}

class ChatModel {
  final String id;
  final String name;
  final String avatarUrl;
  final String lastMessage;
  final DateTime time;
  final int unreadCount;
  final bool isOnline;
  final bool isGroup;

  ChatModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.isOnline,
    this.isGroup = false,
  });
}
