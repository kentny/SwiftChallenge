//
//  Photo.swift
//  VariousAPIList
//
//  Created by Kentaro Terasaki on 2024/05/08.
//

import Foundation

struct Photo: Codable {
    var albumId: Int64
    var id: Int64
    var title: String
    var url: URL
    var thumbnailUrl: URL
}
