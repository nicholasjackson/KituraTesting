import Foundation
import XCTest

@testable import KituraStarter
@testable import HTTPTest
@testable import Kitura
import KituraNet

public class JSONHandlersTests: XCTestCase {

  var handlers:JSONHandlers?
  var request:Request?
  var routerRequest:RouterRequest?
  var response:ResponseRecorder?
  var routerResponse:RouterResponse?
  
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
    
  public func testReturnsStatus200WhenValidRequest() throws {
    try handlers?.getJSON(request: routerRequest!, response: routerResponse!) {}

    XCTAssertEqual(.OK,response?.statusCode, "Expected response status OK")
  }
  
  public func testReturnsJSONWhenValidRequest() throws {
    try handlers?.getJSON(request: routerRequest!, response: routerResponse!) {}
    let json = response!.jsonBody()

    XCTAssertEqual("Kitura", json["framework"], "Expected response body to contain Kitura")
  }
}

#if os(Linux)
extension JSONHandlersTests {
  static var allTests: [(String, (JSONControllerTests) -> () throws -> Void)] {
    return [
      ("testReturnsStatus200WhenValidRequest", 
        testReturnsStatus200WhenValidRequest),
    ]
  }
}
#endif
