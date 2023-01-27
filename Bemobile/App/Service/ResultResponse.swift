//
//  ResultResponse.swift
//  Bemobile
//
//  Created by Oscar Rodriguez Garrucho on 27/1/23.
//

import Foundation

enum ResultResponse<T> {
    case success(T)
    case failure(APIErrorResponse)
}
