//
//  Album.swift
//  VariousAPIList
//
//  Created by Kentaro Terasaki on 2024/05/08.
//

import Foundation

struct Album: Codable, Hashable {
    var userId: Int64
    var id: Int64
    var title: String
}
