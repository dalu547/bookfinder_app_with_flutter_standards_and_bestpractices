## backbase bookfinder

## Overview
This is a bookfinder app using openlibarayAPI.

## Table of Contents
- [Architecture](#architecture)
- [Folder Structure](#folder-structure)
- [Libraries Used](libraries-used)
- [Author](#author)

## Architecture

The Project is Based on MVVM and Clean-Architecture with consideration of SOLID principles.

![Architecture Diagram](screenshots/clean_architecture.png)

## Folder Structure

**Data:** The data layer serves as a bridge between the domain layer and the presentation layer, supplying data through implementations of data sources, repositories, and models.

**Domain:** The domain layer encapsulates the core business logic and rules, acting as an intermediary between the data layer and presentation layer to ensure separation of concerns and maintain a clean, business-centric architecture. 

**Presentation**: The presentation layer manages user interfaces and interactions, focusing on the visual representation of data and user experience. It relies on the domain layer for business logic and the data layer for data retrieval, fostering a clear separation of concerns in the application architecture.

## Libraries Used

- **Flutter**: Flutter is a UI toolkit that enables the creation of natively compiled applications for mobile, web, and desktop from a single codebase.
 
- **Retrofit and Dio** : for Networking.
- **Floor** : for Local Database.
- **Bloc** : for State Management.
- **GetIt** : Dependancy Injection.
- **Sizer** : for Responsive UI.


### Author

 **Dalayya Kalla**

- **Email**: [dalu547@gmail.com]()
- **LinkedIn**: https://www.linkedin.com/in/dalu547/
- **Medium**: https://medium.com/@dalu547
- **Github** : https://github.com/dalu547
  






