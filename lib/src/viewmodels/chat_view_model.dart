import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/models/chat_message.dart';
import 'package:teamfit/src/models/chat_room.dart';
import 'package:teamfit/src/models/user_data.dart';

class ChatState {
  final List<ChatMessage> messages;
  final Map<String, UserData> users;
  final bool isLoading;
  final String? error;
  final ChatRoom? chatRoom;

  ChatState({
    this.messages = const [],
    this.users = const {},
    this.isLoading = false,
    this.error,
    this.chatRoom,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    Map<String, UserData>? users,
    bool? isLoading,
    String? error,
    ChatRoom? chatRoom,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      chatRoom: chatRoom ?? this.chatRoom,
    );
  }
}

class ChatViewModel extends StateNotifier<ChatState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String projectId;
  final bool useDummyData;

  // 더미 데이터 저장소
  List<ChatMessage> _dummyMessages = [];
  int _messageIdCounter = 0;

  ChatViewModel(this.projectId, {this.useDummyData = true})
    : super(ChatState(isLoading: true)) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      if (useDummyData) {
        await _initializeDummyData();
      } else {
        await _loadChatRoom();
        await _loadUsers();
        _listenToMessages();
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> _initializeDummyData() async {
    // 더미 사용자 데이터 생성
    final dummyUsers = {
      'user1': UserData(
        uid: 'user1',
        email: 'hyebin@example.com',
        nickname: '김혜빈',
        projectIds: [projectId],
      ),
      'user2': UserData(
        uid: 'user2',
        email: 'me@example.com',
        nickname: '나',
        projectIds: [projectId],
      ),
      'user3': UserData(
        uid: 'user3',
        email: 'cat@example.com',
        nickname: '냥냥이',
        projectIds: [projectId],
      ),
    };

    // 더미 채팅방 생성
    final dummyChatRoom = ChatRoom(
      id: 'dummy_chat_room',
      projectId: projectId,
      memberIds: ['user1', 'user2', 'user3'],
      chatType: ChatType.team,
      createdAt: DateTime.now().subtract(Duration(days: 1)),
    );

    // 더미 메시지 생성
    _dummyMessages = [
      ChatMessage(
        id: 'msg1',
        content: '안녕하세요~\n디자이너 경력 3년차 김혜빈입니다!\n잘 부탁 드려요~',
        senderId: 'user1',
        type: MessageType.text,
        timestamp: DateTime.now().subtract(Duration(minutes: 30)),
      ),
      ChatMessage(
        id: 'msg2',
        content: '안녕하세요! 반갑습니다~',
        senderId: 'user2',
        type: MessageType.text,
        timestamp: DateTime.now().subtract(Duration(minutes: 25)),
      ),
      ChatMessage(
        id: 'msg3',
        content: '냥냥이 님이 들어왔습니다',
        senderId: '',
        type: MessageType.text,
        timestamp: DateTime.now().subtract(Duration(minutes: 20)),
      ),
      ChatMessage(
        id: 'msg4',
        content: '안녕하세요~',
        senderId: 'user2',
        type: MessageType.text,
        timestamp: DateTime.now().subtract(Duration(minutes: 15)),
      ),
    ];

    _messageIdCounter = _dummyMessages.length;

    // 상태 업데이트
    state = state.copyWith(
      chatRoom: dummyChatRoom,
      users: dummyUsers,
      messages: _dummyMessages,
      isLoading: false,
    );

    // 새 메시지 시뮬레이션 (테스트용)
    _simulateIncomingMessages();
  }

  void _simulateIncomingMessages() {
    // 30초마다 김혜빈이 메시지를 보내는 시뮬레이션
    Future.delayed(Duration(seconds: 30), () {
      if (useDummyData) {
        _addDummyMessage('프로젝트 일정 확인했어요! 👍', 'user1');

        Future.delayed(Duration(seconds: 45), () {
          if (useDummyData) {
            _addDummyMessage('다들 화이팅해요~', 'user1');
          }
        });
      }
    });
  }

  void _addDummyMessage(String content, String senderId) {
    final newMessage = ChatMessage(
      id: 'msg${++_messageIdCounter}',
      content: content,
      senderId: senderId,
      type: MessageType.text,
      timestamp: DateTime.now(),
    );

    _dummyMessages.add(newMessage);

    state = state.copyWith(messages: List.from(_dummyMessages));
  }

  Future<void> _loadChatRoom() async {
    try {
      final chatRoomDoc =
          await _firestore
              .collection('chatRooms')
              .where('projectId', isEqualTo: projectId)
              .where('chatType', isEqualTo: ChatType.team.value)
              .limit(1)
              .get();

      if (chatRoomDoc.docs.isNotEmpty) {
        final chatRoom = ChatRoom.fromJson(chatRoomDoc.docs.first.data());
        state = state.copyWith(chatRoom: chatRoom);
      } else {
        await _createChatRoom();
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> _createChatRoom() async {
    try {
      final projectDoc =
          await _firestore.collection('projects').doc(projectId).get();

      if (!projectDoc.exists) return;

      final projectData = projectDoc.data()!;
      final memberIds = List<String>.from(projectData['memberIds'] ?? []);

      final chatRoomRef = _firestore.collection('chatRooms').doc();
      final chatRoom = ChatRoom(
        id: chatRoomRef.id,
        projectId: projectId,
        memberIds: memberIds,
        chatType: ChatType.team,
        createdAt: DateTime.now(),
      );

      await chatRoomRef.set(chatRoom.toJson());
      state = state.copyWith(chatRoom: chatRoom);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> _loadUsers() async {
    try {
      if (state.chatRoom == null) return;

      final Map<String, UserData> users = {};

      for (String userId in state.chatRoom!.memberIds) {
        final userDoc = await _firestore.collection('users').doc(userId).get();

        if (userDoc.exists) {
          users[userId] = UserData.fromJson(userDoc.data()!);
        }
      }

      state = state.copyWith(users: users);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  void _listenToMessages() {
    if (state.chatRoom == null) return;

    _firestore
        .collection('chatRooms')
        .doc(state.chatRoom!.id)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .listen((snapshot) {
          final messages =
              snapshot.docs
                  .map(
                    (doc) =>
                        ChatMessage.fromJson({...doc.data(), 'id': doc.id}),
                  )
                  .toList();

          state = state.copyWith(messages: messages, isLoading: false);
        });
  }

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    if (useDummyData) {
      _sendDummyMessage(content);
    } else {
      await _sendFirebaseMessage(content);
    }
  }

  void _sendDummyMessage(String content) {
    final newMessage = ChatMessage(
      id: 'msg${++_messageIdCounter}',
      content: content.trim(),
      senderId: 'user2', // 현재 사용자 ID
      type: MessageType.text,
      timestamp: DateTime.now(),
    );

    _dummyMessages.add(newMessage);

    state = state.copyWith(messages: List.from(_dummyMessages));
  }

  Future<void> _sendFirebaseMessage(String content) async {
    if (state.chatRoom == null) return;

    final currentUser = _auth.currentUser;
    if (currentUser == null) return;

    try {
      final messageRef =
          _firestore
              .collection('chatRooms')
              .doc(state.chatRoom!.id)
              .collection('messages')
              .doc();

      final message = ChatMessage(
        id: messageRef.id,
        content: content.trim(),
        senderId: currentUser.uid,
        type: MessageType.text,
        timestamp: DateTime.now(),
      );

      await messageRef.set(message.toJson());

      await _firestore.collection('chatRooms').doc(state.chatRoom!.id).update({
        'lastMessage': message.toJson(),
      });
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  String getCurrentUserId() {
    if (useDummyData) {
      return 'user2'; // 더미 데이터에서 현재 사용자 ID
    }
    return _auth.currentUser?.uid ?? '';
  }

  UserData? getUserData(String userId) {
    return state.users[userId];
  }

  bool isMyMessage(String senderId) {
    return senderId == getCurrentUserId();
  }

  // 데이터 모드 전환 (테스트용)
  void toggleDataMode() {
    // 실제 앱에서는 사용하지 않음, 개발/테스트용
  }
}

// Provider 설정 - 기본적으로 더미 데이터 모드 사용
final chatViewModelProvider =
    StateNotifierProvider.family<ChatViewModel, ChatState, String>(
      (ref, projectId) => ChatViewModel(projectId, useDummyData: true),
    );

// Firebase 모드용 Provider (필요시 사용)
final chatViewModelFirebaseProvider =
    StateNotifierProvider.family<ChatViewModel, ChatState, String>(
      (ref, projectId) => ChatViewModel(projectId, useDummyData: false),
    );
