# Filmatica

This is a practice iOS app for implementing various best practices while developing.

## Screens

### First screen
- List of movies ✅

### Second screen
- Movie detail ✅

## Requirements

- RxSwift (Driver & Signal) for binding ✅
- MVVMC ✅
- Driver & Signal ✅
- Programmatic layout ✅
- Rx network calls ✅
- Dense SOLID applied ✅
- Unit testing (very important) ✅
- Implemented Best practices, design patterns when necessary ✅
- Considered Future-Proofing the code ✅
- Focused on Code Readability - for other people to easily understand the code ✅
- SwiftLint ✅

--------------------------------------------------------------

# Updated in Build #2

- Updated my View Models to support Black Box Testing.
  - Now the ViewModel's internals are mostly encapsulated (private). only public interfaces are public to the outside word.
  
  - So the ViewModel is mostly consisted of (Encapsulated properties & Public interfaces).
  - This means that the business logic is not visible to the views or any other model/view that uses the view model.
  - Also updated the Views to use the public interfaces of the view models.

- Now the ViewModels conform to Protocols
  This approach adheres to the interface segregation principle (part of the SOLID principles) and enhances the testability and flexibility of your code.
  For example:
  ```
  protocol HomeViewModelProtocol {
      var movieListDriver: Driver<[Movie]> { get }
      var loading: Signal<Bool> { get }
      var errorDriver: Driver<NetworkError> { get }
      func navigateButtonPressed(movie: Movie)
      func fetchMovies()
  }
  ```

- Updated to the Tests:
   - I have removed the real database tests, now it consists of only mock data tests.
   - Updated the ViewModel tests to be more compatible with the new changes according to Black Box.
   - More suitable Unit tests are performed, (Initialization, proper method testing).

  For example, the HomeViewModel tests would consist of testing:
  
  <img width="326" alt="Screenshot 2024-07-14 at 1 25 30 PM" src="https://github.com/user-attachments/assets/ff85d276-6fbc-4226-a32f-64b0df7046b8">

  This is only testing the functionality of the public interfaces as (Input/Output).


- I have also some modifications in the File & Folder structure, Such as moving some code into seperate files, refactoring othres, etc.
- The main changes are:
  - 📁 ViewModel Files
  - 📁 ViewModels Testings
  - 📁 New ViewModel Protocols
  - Focused on improving the overall code based on best practices

- You can see a more detailed changes in the commit history



