# Simple Note Taking App

This is a simple note-taking application built with Flutter. It uses Riverpod for state management, Hive for local storage, and Dio for API calls. The project follows a clean MVVM architecture, separating the code into data, domain, and presentation layers.

---

## Features

- **Note Listing:**  
  Displays a list of notes stored in Hive.
- **Note Details:**  
  View full content of a note with options to edit or delete it.
- **Create/Edit Notes:**  
  A straightforward form for creating or updating notes.
- **API Integration:**  
  Fetch sample notes from a remote API using Dio.
- **Visual Data Inspection:**  
  Uses Hive UI to visualize stored data.
- **Async State Handling:**  
  Shows loading indicators and error messages during API calls.

---

## Technologies

- **Flutter:** Framework for building the UI.
- **Riverpod:** Manages state and dependency injection.
- **Hive:** Provides local database storage.
- **Dio:** Handles HTTP requests.
- **MVVM & Clean Architecture:** Organizes code into distinct layers (data, domain, presentation).

---
