## CodingChallenge-iOS
Coding challenge sample for prospective candidates.

### Goals 
- Allow for a savvy candidate to pick up functional and reactive patterns in a way we can assess
- Allow for a candidate to demonstrate they have the experience to use reactive patterns to our standards
- Shows understanding of throttling requests
- Shows understanding of canceling server requests
- Table view is dynamically loaded when scrolled
- Enough info is prefetched from server, but not too much
- Determine if they understand how to represent state with a functional approach

### Requirements
- Add GitHub repository search functionality to the search bar
- Search request sent after 3 seconds of non white space characters.
- Only perform search after three characters have been typed.
- Shows search results in the table view with each item showing the repository name.
- Header in UI shows total search results
- Search field can be used at anytime
- Results are queried and updated in UI asynchronously
- Error handling in the API for non 200's http responses, deserialization, and empty responses through observables.
- Display an alert for any error returned by the API.
- Unit tests fetch models from endpoints with a mocked data

### Where To Add Code
- `APIRequest.swift` has a `TODO` for creating an observable with RxSwift. That should be around 20-30 lines of code.
- `SearchTableViewController.swift` has a `TODO` for binding the RxSwift observable data to the UI. Bind the Search field as input to a query and bind the results to the UITableView for viewing. It should only take 10-15 lines of RxSwift code.

### Development Environment Requirements
- [Carthage](https://github.com/Carthage/Carthage)
-- `carthage update --platform iOS` in command line
- XCode 11.3
- Swift 5.0
