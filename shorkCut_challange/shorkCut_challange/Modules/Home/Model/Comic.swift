//
//  Comic.swift
//  shorkCut_challange
//
//  Created by Mina on 10/8/21.
//

import Foundation

struct Comic: Codable {
    // Only mapping useful properties from the API object
    var num: Double?
    var day: String?
    var month: String?
    var year: String?
    var title: String?
    var alt: String?
    var img: String?
    
    // Stored Properties
    var imageData: Data?
}
