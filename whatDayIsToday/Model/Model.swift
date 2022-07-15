//
//  Model.swift
//  whatDayIsToday
//
//  Created by USER on 2022/05/09.
//

import Foundation

struct Result: Decodable {
    let query: Query
}
struct Query: Decodable {
    let pages: [String: Pages]
}
struct Pages: Decodable {
    let pageid: Int
    let title: String
    let extract: String
}
