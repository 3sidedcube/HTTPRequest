//
//  main.swift
//  StravaAPI
//
//  Created by Ben Shutt on 07/12/2020.
//

import Foundation
import Alamofire
import HTTPRequest

// Turn on logging
HTTPRequest.Configuration.shared.logging = true

do {
    // Setup Strava session
    try StravaSession.shared.configure()

    // Fetch `Athlete` model based on authorization token
    let athlete: Athlete = try StravaAPI.athlete.requestSync().model()

    Logger.log("\(athlete)", type: .info)
} catch {
    Logger.log("\(error)", type: .error)
}
