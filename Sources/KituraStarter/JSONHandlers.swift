//
//  JSONHandler.swift
//  Kitura-Starter
//
//  Created by Nic Jackson on 21/03/2017.
//
//

import Foundation
import Kitura
import SwiftyJSON
import LoggerAPI

public class JSONHandlers {
    /**
     * Handler for getting an application/json response.
     */
    public func getJSON(
      request: RouterRequest, 
      response: RouterResponse, 
      next: @escaping () -> Void) throws {

        Log.debug("GET - /json route handler...")

        response.headers["Content-Type"] = "application/json; charset=utf-8"
        
        var jsonResponse = JSON([:])
        jsonResponse["framework"].stringValue = "Kitura"

        try response.status(.OK).send(json: jsonResponse).end()
    }
}
