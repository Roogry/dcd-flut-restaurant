<h1 align="center">
  Restoeev
</h1>
<p align="center">
  Restaurant App (Submission Flutter Fundamental Dicoding)
</p>
<p align="center">
  <a href="https://flutter.dev/"><img alt="Platform" src="https://img.shields.io/badge/platform-Flutter-blue.svg"></a>
  <a href="https://dart.dev/"><img alt="Dart" src="https://img.shields.io/badge/dart-3.0.3-blue.svg"></a>
  <a href="https://github.com/Roogry/dcd-flut-restaurant/"><img alt="Star" src="https://img.shields.io/github/stars/Roogry/dcd-flut-restaurant"></a>
</p>

<p align="center">
  <img src="demo/cover-restoeev.jpg"/>
</p>

## Introduction

Restoeev is a Restaurant Application for the people who lookin recommendation for the Restaurant, Foods, Drinks, anything about that.

In this project, is to accomplish Submission Dicoding in [Flutter Fundamental Course](https://www.dicoding.com/academies/195), I created this restaurant app with Provider State Management. To see what features I made, you can see [here](#features).

For this submission 1, focus on creating UI and consume data from json. There is list of restaurants, search restaurants, and detail restaurant.
For this submission 2, moving forward to REST API using [http](https://pub.dev/packages/http) .
For this submission 3, focus on build bookmark feature, using Sqflite, and implement notification with alarm manager.


## Demo

|Home Screen|Detail Restaurant|Search Restaurant|
|--|--|--|--|
|![](demo/home.png)|![](demo/detail.png)|![](demo/search.png)|

|Add Review|Bookmark|Setting|
|--|--|--|
|![](demo/review.png)|![](demo/bookmark.png)|![](demo/setting.png)|

## Features

- Show a list of restaurants
- Search restaurants
- Show restaurant details
- Add restaurant review
- Add restaurant to bookmark
- Show bookmark restaurants


## Technology

- Provider for State Management
- http packages to fetch data from API
- SQLite
- Shared Preferences

## Installation

1. Clone this repository
2. Run `flutter pub get`
3. Run `flutter run`