# unj_digital_test

Developed a Flutter application that fetches, displays, edits, and persists user data using a mock API.

# Building and Running the Flutter Application

## Prerequisites:
Before you begin, ensure you have the following installed:
- **Flutter SDK:** Follow the official Flutter installation instructions for your operating system.
- **Dart SDK:** Flutter requires the Dart SDK. It's included with the Flutter SDK, so you don't need to install it separately.
- **Android Studio/VS code or Xcode:** Depending on whether you're targeting Android or iOS, you'll need either Android Studio/VS code or Xcode installed.

## Getting Started:
1. Clone the repository:
	```
	git clone https://github.com/shivangsorout/unj_digital_test
	```
2. Navigate to the project directory:
	```
	cd <project_directory>
	```
3. Install dependencies:
	```
	flutter pub get
	```

## Running the Application:
### **Android**:
Ensure you have an Android device connected via USB or an Android emulator running.   

- Run the command in terminal:
 ```
 flutter run
 ```
### **iOS**:
Ensure you have a macOS machine with Xcode installed.   

- Run the command in terminal:
 ```
 flutter run
 ```

## Approach: Repository Pattern with Flutter BLoC
I used the Repository Design Pattern to separate the data layer (API, local storage) from the business logic layer (BLoC). This keeps the app modular, testable, and scalable.

### 1️⃣ Repository Pattern (Data Layer):
- The UserRepository acts as a bridge between data sources (ApiService, LocalStorage) and the BLoC.
- It decides where to fetch data from (cache or API) and ensures efficient data management.

### 2️⃣ Flutter BLoC (State Management Layer):
- Events (user_event.dart) → Define user actions (e.g., FetchUsersEvent, AddUserEvent).
- Bloc (user_bloc.dart) → Handles business logic by reacting to events and updating state.
- States (user_state.dart) → Represent different UI states (e.g., UsersLoadingState, UsersLoadedState, UserErrorState).

### Why This Approach?
- [x] Separation of Concerns → UI, logic, and data management are independent.
- [x] Offline & API Handling → Fetches data efficiently from cache/API.
- [x] Testability → Easy to test business logic separately from UI.
- [x] Scalability → Can extend features without breaking the architecture.

## Requirements fulfilled:
### Requirements:
 - [x] Screens & Navigation:
    - [x] HomeScreen
    - [x] User Details Screen
    - [x] Edit User Screen
    - [x] Add New User Screen 
 - [x] API Integration
 - [x] Architecture Guidelines:
    - [x] BLoC(flutter_bloc)
    - [x] Repository Design Pattern 
 - [x] Caching & Performance:
    - [x] Shared Preferences(shared_preferences)
    - [x] Shimmer effect
    - [x] Pagination
 - [x] Error Handling 

