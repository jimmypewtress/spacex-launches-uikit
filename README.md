# spacex-launches-uikit

A simple app that calls an API to get a list of SpaceX launches, displays details of them in a list and navigates to a detail view when the user taps on one.

A mocked out login screen is present to demonstrate a root navigation flow and implement features such as text validation and conditional UI states.

## Architecture

The app follows a clean archicture design, using the classic rings diagram as a starting point:

![Clean Architecture Image](https://blog.cleancoder.com/uncle-bob/images/2012-08-13-the-clean-architecture/CleanArchitecture.jpg)

Starting from the outside,

- View Controllers and Storyboards make up the UI Layer
- The View Controllers are as dumb as possible and driven by View Models which supply the data to display and handle and user interaction
- Application tasks such as making API calls are handled by Use Cases
- Data models of the various launch features make up the Entities layer

As per the Clean Architecture paradigm, the objects closer to the centre of the circle have no knowledge of the objects further out.  The app uses the Combine framework to implement a funtional reactive pattern for the outer objects to subscribe to published values on the inner ones.

The project achieves 100% unit test coverage for each of the view models and use cases which gives a high degree of confidence that things are working properly.

Navigation and the pulling together of all the various dependencies is handled by Coordinator objects.

I orginally inteded this project to be a learning project for both Combine and SwiftUI, but after some research I'm not convinced this Clean/MVVM type approach is suitable for SwiftUI.  Combine works well with this approach for the bindings between objects, but it does a bit "shoehorned" in and it's evident it's designed more to work with SwiftUI.

I have another repo where I'm rebuilding the exact same app in SwiftUI [here](https://github.com/jimmypewtress/spacex-launches-swiftui).

