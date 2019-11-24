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
- FlowCoordinator is used to go from different screens and pass data.
- Flow is passed to the ViewModel. This is an abstraction of the FlowCoordinator, which can be used to mock in unit tests. ViewModel calls to flow to change screens.
- ViewModel communicates with the API via Actions. Actions is an abstraction to Services. This can be used to mock in unit tests as well.
- Responses are data transfer objects used to decode the API Response. Services converts Responses to the Models that the ViewModels would use for the data.  This decouples API shape changes to Model changes.

## 3rd party libraries
- Uses Cocoapods as a dependency manager
- Bright Futures for handling of asynchronous calls. This can be replaced by using delegates or the completion handlers / blocks.
- SnapKit is used as a DSL for ease in doing autolayout, this can be replaced by doing AutoLayout contraints natively.

## Improvements
- Some improvements are listed as comments
- UI Testing
- Include more information on the details
