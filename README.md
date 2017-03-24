# Handler testing example for Kitura
This example implements two new testing objects which are influenced by Go's net/httptest package.  
Sources/HTTPTest contains two classes:  
* Request.swift - a stubbed instance of ServerRequest   
* ResponseRecorder.swift - a stubbed instance of ServerResponse  

The intention behind these packages is to enable testing of handlers without the requirement to run through the Router.  It gives fast and simple Unit level testing allowing dependencies to be easilly replaced.

## Strucuture of Handlers to provide issolation  

```swift
public class JSONHandlers {
  /**
  * If your handler needs dependencies then use constuctor
  * injection to manage this
  */
  public init(database:MySQL, logger:Log) {
    self.database = database
    self.logger = logger
  }
    /**
     * Handler for getting an application/json response.
     */
    public func getJSON(
      request: RouterRequest, 
      response: RouterResponse, 
      next: @escaping () -> Void) throws {

      // work for function

      }
}
```

Dependencies can be issolated within the handlers by using constructor injection, by depending on abstraction using protocols, dependencies can be easily stubbed or mocked in the testing phase.

## Test setup
Kitura's RouterRequest and RouterResponse have an underlying object which is based on the protocols ServerRequest and ServerResponse, these implement the basic data stuctures for the HTTP request and response.  The classes themselfs have no other dependencies and do not need further abstraction for effective testing.  If we take a look at the example below we are creating an instance of HTTPTest.Request and HTTPTest.ResponseRecorder and then using this to create an instance of RouterRequest and RouterResponse.  The Kitura classes do have protection level on the constructors for certain elements but this can be bypassed on for testing by using the `@testable import KituraNet` declaration which allows us to bypass this for testing with out the need to change the protection in the underlying class.

```swift
public override func setUp() {
  request = Request(path:"/", method:"GET")
  routerRequest = RouterRequest(request: request!)

  response = ResponseRecorder()
  routerResponse = RouterResponse(
    response: response!,
    router: Router(),
    request: routerRequest!)

  handlers = JSONHandlers()
}
```

Once we have this setup we can then write a unit test like the one below, this test uses the convenience methods on the ResponseRecorder which captures the response which would ordinarily be sent to the servers output into an internal buffer.  We can then access this either as a raw object or as JSON enabling us to assert that the response from the handler was as desired.

```swift
public func testReturnsJSONWhenValidRequest() throws {
  try handlers?.getJSON(request: routerRequest!, response: routerResponse!) {}
  let json = response!.jsonBody()

  XCTAssertEqual("Kitura", json["framework"], "Expected response body to contain Kitura")
}
```

This is an incredibly effective testing strategy as not only do these tests run very fast but it allows full code path checking of the handler.  For example if authentication fails and we would like to maje sure that the server will return a 401 status, the dependency responsible for authentication could be setup to return a fail state which would allow us to test that the handler flows through the correct path.

The other benefit of separating code in this way is that we can keep the router setup simple and readable by issolating the work into handler classes which are grouped by behaviour.

```swift
// JSON Get request
router.get("/json", handler: jsonHandlers.getJSON)
```
