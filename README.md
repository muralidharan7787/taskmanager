# 📝 Task Manager App

A simple and elegant Flutter app for managing your daily tasks, with local storage using SQLite and optional task fetching from an API.

## 📱 Features

- ✅ Add, delete, update tasks
- 📅 Pick due dates
- 🧠 Auto-load tasks from local SQLite database
- 🌐 Fetch tasks from API and store them locally
- 📦 Local database storage with `sqflite`
- 🛠 MVVM architecture using `provider`

## 🔧 Tech Stack

- Flutter
- Provider (state management)
- SQLite (`sqflite`)
- HTTP for REST API
- Local DB CRUD

## 🖥️ Screenshots

| Home Screen | Add Task | Swipe to Delete |
|-------------|----------|-----------------|
| ![image](https://github.com/user-attachments/assets/115b49d4-4c14-497b-924a-e31bb8146221) | ![image](https://github.com/user-attachments/assets/dda0e941-1312-4792-9697-c891c5fc8250) | ![image](https://github.com/user-attachments/assets/fc61f25a-fe27-41b0-8dbc-3a9cb006e527) |

## 🛠️ Setup Instructions

### Prerequisites

- Flutter SDK installed (preferably 3.10+)
- Android Studio / VS Code
- Emulator or connected device

### 🔄 Steps to Run

```bash
git clone https://github.com/your-username/flutter-task-manager.git
cd flutter-task-manager
flutter pub get
flutter run
