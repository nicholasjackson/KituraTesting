import Foundation
@testable import KituraNet

public class Request : ServerRequest {
  /// Read all of the data in the body of the request
  ///
  /// - Parameter data: A Data struct to hold the data read in.
  ///
  /// - Throws: Socket.error if an error occurred while reading from the socket
  /// - Returns: The number of bytes read
  public func readAllData(into data: inout Data) throws -> Int {
    return 0
  }

  /// Read a string from the body of the request.
  ///
  /// - Throws: Socket.error if an error occurred while reading from the socket
  /// - Returns: An Optional string
  public func readString() throws -> String? {
    return ""
  }

  /// Read data from the body of the request
  ///
  /// - Parameter data: A Data struct to hold the data read in.
  ///
  /// - Throws: Socket.error if an error occurred while reading from the socket
  /// - Returns: The number of bytes read
  public func read(into data: inout Data) throws -> Int {
    return 0
  }

  /// The HTTP Method specified in the request
  public var method: String

  /// Minor version of HTTP of the request
  public var httpVersionMinor: UInt16?

  /// Major version of HTTP of the request
  public var httpVersionMajor: UInt16?

  /// The IP address of the client
  public var remoteAddress: String

  /// The URL from the request
  public var urlURL: URL

  /// The URL from the request as URLComponents
  /// URLComponents has a memory leak on linux as of swift 3.0.1. Use 'urlURL' instead
  @available(*, deprecated, message: "URLComponents has a memory leak on linux as of swift 3.0.1. use 'urlURL' instead")
  public var urlComponents: URLComponents

  /// The URL from the request in UTF-8 form
  /// This contains just the path and query parameters starting with '/'
  /// Use 'urlURL' for the full URL
  public var url: Data

  /// The URL from the request in string form
  /// This contains just the path and query parameters starting with '/'
  /// Use 'urlURL' for the full URL
  @available(*, deprecated, message: "This contains just the path and query parameters starting with '/'. use 'urlURL' instead")
  public var urlString: String

  /// The set of headers received with the incoming request
  public var headers: HeadersContainer

  public init(path: String, method: String) {
    self.method = "GET"
    self.httpVersionMinor = 1
    self.httpVersionMajor = 1
    self.remoteAddress = "127.0.0.1"
    self.urlURL = URL(string: "http://localhost/")!
    self.urlComponents = URLComponents()
    self.url = Data()
    self.urlString = ""
    self.headers = HeadersContainer()
  }
}
