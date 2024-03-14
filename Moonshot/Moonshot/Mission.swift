//
//  CrewRole.swift
//  Moonshot
//
//  Created by Cayla Murdoch on 3/13/24.
//

import Foundation


struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}
