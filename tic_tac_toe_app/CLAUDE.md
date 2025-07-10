# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter-based Tic-Tac-Toe (3目並べ) application that implements a classic game with a clean, modern UI. The entire game logic is contained within a single file architecture.

## Key Architecture Points

- **Single-file structure**: All game logic is contained in `lib/main.dart`
- **StatefulWidget pattern**: Game state is managed using Flutter's StatefulWidget with `_TicTacToeGameState`
- **Game state management**: Uses a simple `List<String>` to represent the 9-cell board
- **UI composition**: Uses Container, GridView, and Material Design components with custom styling
- **Japanese localization**: UI text is in Japanese (3目並べ, 引き分け, etc.)

## Common Development Commands

```bash
# Install dependencies
flutter pub get

# Run the app in development mode
flutter run

# Run tests
flutter test

# Analyze code for issues
flutter analyze

# Build for production
flutter build apk          # Android
flutter build ios          # iOS
flutter build web          # Web
```

## Testing

- Test files are located in `test/`
- Current test file (`test/widget_test.dart`) contains outdated boilerplate code that references `MyApp` instead of `TicTacToeApp`
- To run a specific test: `flutter test test/widget_test.dart`

## Game Logic Architecture

The game state is managed through:
- `board`: List of 9 strings representing the game grid
- `isXTurn`: Boolean tracking whose turn it is  
- `winner`: String storing the winner ('X', 'O', or '引き分け' for draw)
- `gameOver`: Boolean flag to prevent moves after game ends

Win detection is handled by checking all possible win patterns (horizontal, vertical, diagonal) in the `_checkWinner()` method.

## Code Style

- Uses `flutter_lints` package for code analysis
- Follows Flutter/Dart conventions with camelCase naming
- Japanese comments and strings for UI text
- Material Design theming with blue color scheme