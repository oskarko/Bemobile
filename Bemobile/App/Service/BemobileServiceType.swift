//
//  BemobileServiceType.swift
//  Bemobile
//
//  Created by Oscar Rodriguez Garrucho on 27/1/23.
//

import Foundation

enum BemobileServiceType {
    case info
    case rate
    
    var urlString: String {
        switch self {
        case .info: return "https://android-ios-service.herokuapp.com/transactions"
        case .rate: return "https://android-ios-service.herokuapp.com/rates"
        }
    }
}
