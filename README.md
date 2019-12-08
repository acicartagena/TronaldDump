#  TronaldDump

## Build & Run
- Xcode 11 & Swift 5
- Open TronaldDump.xcworkspace

## App
- gets the tags on load from the API
- when a tag gets selected, the details screen gets shown
- tapping on a detail, goes to the source
- tries to load more details, using the next link from the previous response

## Architecture
### MVVM-C as the architecture
- ViewModel contains the business logic, requests data from the Api and converts the model to properties for the view to use  
- ViewModels communicate to the ViewController using the delegate pattern. The ViewModel has a weak reference to a ViewModelDelegate which the ViewController implements.  
- FlowCoordinator is used to go from different screens and pass data and dependencies.
- Flow is passed to the ViewModel. This is an abstraction of the FlowCoordinator, which can be used to mock in unit tests. ViewModel calls to flow to change screens.
- ViewModel communicates with the API via Actions. Actions is an abstraction to Services. This can be used to mock in unit tests as well.

### Service
- Service is responsible for either getting the value from the API, if it fails it will try to get the value from the local storage
- It is also responsible for converting the data from the API request or Local storage to the App Models. 
- If the request to the API is successful, it would be stored locally. 
- The API request is the source of truth. The local storage is only used if there is no internet.

### API
- Responses are data transfer objects used to decode the API Response.  This decouples API shape changes to Model changes.
- The goal of decoupling is that the API group can ideally be moved to a different famework

### Offline or Local storage
- CoreData is used to store tags and details that the user has previously visited. 
- CoreData models are prefixed with Data. This also decouples changes to the local storage (for ex. going to Realm) throughout the app. 

## 3rd party libraries
- Uses Cocoapods as a dependency manager
- Bright Futures for handling of asynchronous calls. This can be replaced by using delegates or the completion handlers / blocks.
- SnapKit is used as a DSL for ease in doing autolayout, this can be replaced by doing AutoLayout contraints natively.

## Improvements
- Some improvements are listed as comments
- UI Testing
- Include more information on the details
