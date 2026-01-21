//
//  User.swift
//  Swifty-Companion
//
//  Created by jules bernard on 16.01.26.
//

import Foundation

struct User: Codable {
    let id: Int
    let login: String
    let email: String
    let location: String?
    let firstname: String
    let displayname: String
    let image: UserImage
    let cursusUsers: [CursusUser]?
    let projectsUsers: [ProjectUser]?

    enum CodingKeys: String, CodingKey {
        case id
        case location
        case login
        case email
        case displayname
        case image
        case firstname = "first_name"
        case cursusUsers = "cursus_users"
        case projectsUsers = "projects_users"
    }
}

struct UserImage: Codable {
    let link: String
}

struct CursusUser: Codable {
    let level: Double
    let skills: [Skill]
    let cursus: Cursus
}

struct Cursus: Codable {
    let name: String
    let slug: String
}

struct Skill: Codable {
    let id: Int
    let name: String
    let level: Double
}

struct ProjectUser: Codable {
    let finalMark: Int?
    let status: String
    let project: Project
    let validated: Bool?

    enum CodingKeys: String, CodingKey {
        case finalMark = "final_mark"
        case status
        case project
        case validated = "validated?"
    }
}

struct Project: Codable {
    let name: String
}

extension User {
    
    var mainCursus: CursusUser? {
            cursusUsers?.first { $0.cursus.slug == "42cursus" }
        }

    var level: Double? {
        mainCursus?.level
    }

    var skills: [Skill] {
        mainCursus?.skills ?? []
    }
}

