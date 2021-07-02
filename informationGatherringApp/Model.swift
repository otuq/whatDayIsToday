//
//  Model.swift
//  informationGatherringApp
//
//  Created by USER on 2021/05/24.
//

import Foundation

//enum CodingKeys: String, CodingKey {
//    //APIで取得したデータをcodingkeyが異なるとパースができない。取得したいcontent情報のkeyが"*"アスタリスクになっているのでデータを読み込めるようにcodingKeyを定義する
//    //受け取ったデータのkeyが"*" これをasteriskというキャメルケースで読み込めるようにする。
//    case article = "*"
////    case pageId = "4940"
//}
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

//struct Extracts: Decodable {
//    let article: String
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        //decodeするcaseを全て型とcondingKeyを指定してecodeの設定しないとエラーが起こるみたい
//        article = try container.decode(String.self, forKey: .article)
//    }
//}
