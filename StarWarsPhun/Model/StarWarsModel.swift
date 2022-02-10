//
//  StarWarsModel.swift
//  StarWarsPhun
//
//  Created by Benjamin Simpson on 2/8/22.
//

import Foundation
import UIKit

struct StarWarsData: Codable {
    let title: String?
    let description: String?
    let timeStamp: String?
    let image: String?
    let phone: String?
    let date: String?
    let locationline1: String?
    let locationline2: String?
}

struct StarWarsDetails {
    let title: String
    let description: String
    let date: String
    let location: String
    var image: UIImage
}
