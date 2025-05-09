# STREAM VIDS

## DESCRIPTION OF TASK

**Stream Vids** is a full-stack video streaming and sharing platform inspired by YouTube. It enables users to register, upload videos, like, comment, chat in real time, and manage their video content from a mobile application. The backend uses **Node.js**, **Express.js**, **MongoDB**, and **Cloudinary**, while the frontend is built with **Flutter** and **GetX**.

### Project Overview

This project demonstrates a mobile-first, scalable, real-time video platform. The backend exposes RESTful APIs secured with JWT authentication. It also integrates **Cloudinary** for video and image storage. The frontend is a Flutter app that includes functionalities like video listing, profile management, chatting, and dark mode switching.

### Technologies Used

1. **Node.js & Express.js:** Backend API development.
2. **MongoDB & Mongoose:** NoSQL database for storing users, videos, comments, and messages.
3. **Cloudinary:** For storing and retrieving videos and thumbnails.
4. **JWT (JSON Web Token):** For secure authentication and route protection.
5. **Socket.io:** Real-time messaging and communication.
6. **Flutter (Frontend):** Mobile app for Android (and iOS-ready).
7. **GetX:** Flutter state management and routing.
8. **Dio:** API calls in Flutter.
9. **Multer:** Handles media uploads from the client.

### Features

1. **User Authentication:**
   - Users can register and log in.
   - JWT is used for route protection.
   - Profile editing and password security are supported.

2. **Video Management:**
   - Users can upload, update, and delete videos.
   - Each video can include a thumbnail and metadata.
   - Videos are stored on Cloudinary and linked via MongoDB.

3. **Interactive Features:**
   - Users can like, comment on, and view videos.
   - Comments are linked to videos and stored persistently.

4. **Real-time Chat:**
   - Live chat system using Socket.io.
   - Supports sending, editing, and deleting messages.

5. **Mobile App Features:**
   - Profile screen shows user info and uploaded videos.
   - Theme toggle (dark/light mode).
   - Video player, comment section, and real-time chat.
   - Upload and CRUD operations for videos.

### Working of the System

1. A user registers and logs in through the Flutter app.
2. On login, a JWT token is generated for authenticated API calls.
3. Users can upload videos with a thumbnail; both are stored on Cloudinary.
4. Users can interact with videos through likes and comments.
5. The chat module allows real-time communication between users.
6. Each user has a profile screen to manage their content.

### How to Use

#### Backend Setup

1. Clone the repository and install dependencies:
   ```bash
   cd backend
   npm install
   ```

2. Create a `.env` file:
   ```env
   PORT=5000
   MONGO_URI=your_mongo_uri
   JWT_SECRET=your_jwt_secret
   CLOUDINARY_CLOUD_NAME=your_cloud_name
   CLOUDINARY_API_KEY=your_api_key
   CLOUDINARY_API_SECRET=your_api_secret
   ```

3. Start the server:
   ```bash
   npm run dev
   ```

#### Frontend (Flutter) Setup

1. Navigate to the frontend directory:
   ```bash
   cd frontend
   flutter pub get
   ```

2. Run the app:
   ```bash
   flutter run
   ```

3. Make sure your emulator or physical device is connected and configured.

### Example API Response

```json
{
  "message": "Video uploaded successfully!",
  "success": true,
  "data": {
    "id": "662b7d2fcad89e0012ab456c",
    "title": "Flutter Tutorial",
    "url": "https://res.cloudinary.com/demo/video/upload/sample.mp4",
    "thumbnail": "https://res.cloudinary.com/demo/image/upload/sample_thumbnail.jpg",
    "uploadedBy": "JohnDoe",
    "likes": [],
    "comments": []
  }
}
```

### Conclusion

Stream Vids is a full-featured video-sharing and chatting application built with a modern tech stack. It provides a strong foundation for media management, authentication, and real-time interactions. Future improvements may include push notifications, analytics dashboards, and live streaming.

# OUTPUT

Upon running the API and Flutter app, the system will:
- Register and authenticate users via JWT.
- Allow users to upload and manage video content.
- Enable real-time messaging with chat editing and deletion.
- Display profile data, video list, and support dark mode in the mobile app.
- Persist and retrieve all data using MongoDB and Cloudinary.
