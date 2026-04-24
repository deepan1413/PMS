
#  PMS - Project  Management System (Flutter)

## 🚀 Overview

This is a **mini Project Management System (PMS)** built using Flutter. The app allows users to manage their tasks efficiently by creating, updating, and tracking their progress.

The main goal of this project is to demonstrate clean architecture, proper state management, and real-world app development practices using Firebase.

---

## ✨ Features

* 🔐 User Authentication (Firebase Auth)
* ➕ Create Tasks
* 📋 View Tasks (Active & Completed)
* ✏️ Update Tasks (status & details)
* ❌ Delete Tasks
* 🔄 Real-time Data Sync using Firestore
* 📊 Task Filtering (Active / Completed)
* ⚡ Smooth and minimal UI

---

## 🏗️ Architecture

The project follows a **clean and scalable architecture** with separation of concerns:

lib/
 ├── features/
 │    ├── auth/
 │    │    ├── data/
 │    │    │    └── firebase_auth_repo.dart
 │    │    ├── domain/
 │    │    │    ├── entities/
 │    │    │    │    └── app_user.dart
 │    │    │    └── repo/
 │    │    │         └── app_user_repo.dart
 │    │    ├── presentation/
 │    │         ├── pages/
 │    │         ├── components/
 │    │         └── cubit/
 │    │              ├── auth_cubit.dart
 │    │              └── auth_state.dart
 │
 │    ├── tasks/   
 │    │    ├── data/
 │    │    │    └── firebase_task_repo.dart
 │    │    ├── domain/
 │    │    │    ├── entities/
 │    │    │    │    └── task.dart
 │    │    │    └── repo/
 │    │    │         └── task_repo.dart
 │    │    ├── presentation/
 │    │         ├── pages/
 │    │         │    ├── active_tasks_page.dart
 │    │         │    ├── completed_tasks_page.dart
 │    │         │    └── add_edit_task_page.dart
 │    │         ├── widgets/
 │    │         └── bloc/
 │    │              ├── task_bloc.dart
 │    │              ├── task_event.dart
 │    │              └── task_state.dart
 │
 │    ├── profile/
 │    │    └── presentation/
 │
 ├── core/
 │    ├── themes/
 │    │    └── theme.dart
 │    ├── utils/
 │    │    └── my_logs.dart
 │
 ├── main.dart
 ├── my_app.dart
 ├── firebase_options.dart

### Layers:

* **UI Layer** → Screens & Widgets
* **Business Logic Layer** → BLoC (handles events and states)
* **Data Layer** → Firebase (Firestore + Auth)

---

## 🔄 State Management (BLoC)

This project uses **BLoC (Business Logic Component)** for managing state.

### Flow:

1. UI triggers an **Event** (e.g., AddTaskEvent)
2. BLoC processes the event
3. BLoC emits a **State** (Loading / Success / Error)
4. UI rebuilds based on the state

This ensures:

* Clean code
* Better scalability
* Easy debugging

---

## 🔥 Firebase Integration

### Authentication

* Firebase Auth is used for user login/signup
* Each user has their own task data

### Firestore Database Structure

```
users/{userId}/tasks/{taskId}
```

### Task Fields:

* title
* description
* isCompleted
* createdAt
* uid

---

## ⚙️ Logic & Implementation

* Tasks are stored in **Firestore**
* Each user can only access their own tasks
* Tasks are filtered based on:

  * Active → `isCompleted = false`
  * Completed → `isCompleted = true`
* Data is fetched using async calls with proper error handling
* UI updates are controlled through BLoC states

---

## 🛠️ Tools & Technologies Used

* **Flutter** → UI Development
* **Dart** → Programming Language
* **Firebase Auth** → Authentication
* **Cloud Firestore** → Database
* **BLoC** → State Management
* **Flutter DevTools** → Performance Monitoring

---

## 🧪 Debugging

A custom logging utility (`MyLog`) is used for debugging:

* Info logs
* Error logs
* Success logs
* Warning logs

This helps in tracking API responses and state changes clearly.

---

## 📦 APK / Demo

> Add your APK or demo link here

---

## 📌 Future Improvements

* Task reminders & notifications
* Collaborative task assignment
* Dark mode support
* Offline support with caching

---

## 👨‍💻 Author

**Deepan**

---

## 📄 Conclusion

This project demonstrates the use of clean architecture, efficient state management, and Firebase integration to build a scalable and user-friendly mobile application.
