# E-Commerce App

A Flutter shopping app that connects to a REST API. Users register and log in, browse products by category, and manage orders and their profile.

## Features
- Register, login and a forgot-password screen
- Product and category listing, product details, search
- Favorites
- Cart and checkout that places an order through the API
- Orders list with separate active, completed and cancelled pages, order details, and cancel/complete actions
- View and update profile (name and phone)
- Access token kept in secure storage and sent as a Bearer token

## Tech stack
Flutter, Dart, flutter_bloc (Cubit), Dio, Dartz (`Either` for error handling), get_it, flutter_secure_storage, flutter_screenutil, flutter_svg, flutter_rating_bar, intl

## Project structure
Code is grouped by feature under `lib/features` (auth, home, items, card, order, my favorites, profile, search, start), with shared helpers, widgets and styles in `lib/core`.

## Run it
```
flutter pub get
flutter run
```
