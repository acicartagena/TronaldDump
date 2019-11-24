#  TronaldDump

## Build & Run
- Xcode 10, Swift 5

## App
- gets the tags on load from the API
- when a tag gets selected, the details screen gets shown
- tapping on a detail, goes to the source
- tries to load more details, using the next link from the previous response

## Architecture
- MVVM-C as the architecture.
- ViewModel contains the business logic, does the network calls to the api and converts the model to properties for the view to use  
- ViewModels communicate to the ViewController via the ViewController being the ViewModelDelegate. The ViewModel now has a weak reference to the ViewController. 
- Coordinator is used to go from different screens and pass data.
- TagDetails & TagName are the 2 models used in the app. TagListResponse & TagDetailsResponse are data transfer objects used to decode the API. The reason for this is to decouple the API shape from what is used in the app. When the API gets changed, as long as there's a way to go from the API response to the models, then there's no need to change things across the app.
- Flows and Actions are used as abstractions to FlowCoordinator and Services. This is done to allow for mocking in testing by using Spys and Stubs, for these dependencies. 

## 3rd party libraries
- Bright Futures for better handling of asynchronous calls. This can be replaced by using delegates or the completion handlers / blocks.
- SnapKit is used as a DSL for ease in doing autolayout, this can be replaced by doing AutoLayout contraints natively.

## Improvements
- Some improvements are listed as comments
- UITesting
- Include more information on the details
