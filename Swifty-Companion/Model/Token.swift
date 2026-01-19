//
//  Token.swift
//  Swifty-Companion
//
//  Created by jules bernard on 19.01.26.
//

import Foundation


struct Token: Decodable {
    let access_token: String
    let token_type: String
    let expires_in: Int
    let scope: String
    let created_at: Int
}
