import Foundation
import SwiftyJSON
@testable import KituraNet

public class ResponseRecorder {
    /// The headers to send back as part of the HTTP response.
  public var headers: HeadersContainer

  /// The status code to send in the HTTP response.
  public var statusCode: HTTPStatusCode?
  
  var data:Data

  public init(){
    statusCode = .notImplemented
    headers = HeadersContainer()
    data = Data()
  }

  public func body() -> String {
    return String(data: self.data, encoding: .utf8)!
  }

  public func jsonBody() -> JSON {
    return JSON(data: self.data)
  }
}

extension ResponseRecorder:ServerResponse {
  /// Reset this response object back to it's initial state
  public func reset() {
    
  }

  /// Complete sending the HTTP response
  ///
  /// - Throws: Socket.error if an error occurred while writing to a socket
  public func end() throws {
    
  }

  /// Add a string to the body of the HTTP response and complete sending the HTTP response
  ///
  /// - Parameter text: The String to add to the body of the HTTP response.
  ///
  /// - Throws: Socket.error if an error occurred while writing to the socket
  public func end(text: String) throws {
    
  }

  
  /// Add bytes to the body of the HTTP response.
  ///
  /// - Parameter data: The Data struct that contains the bytes to be added.
  ///
  /// - Throws: Socket.error if an error occurred while writing to the socket
  public func write(from data: Data) throws {
    self.data.append(data)
  }

  /// Add a string to the body of the HTTP response.
  ///
  /// - Parameter string: The String data to be added.
  ///
  /// - Throws: Socket.error if an error occurred while writing to the socket
  public func write(from string: String) throws {
    
  }
}
