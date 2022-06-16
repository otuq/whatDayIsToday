//
//  APIRequestURLSession.swift
//  whatDayIsToday
//
//  Created by USER on 2022/05/09.
//
// ステータスコードについてシステムが処理結果の状態を外部に知らせるための数字符号を使ったエラーコード、100番台は「情報」200番台は「成功」300番台は「転送」、400番台は「クライアント側のエラー」500番台は「サーバー側のエラー」
// https://e-words.jp/w/%E3%82%B9%E3%83%86%E3%83%BC%E3%82%BF%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%89.html

import Foundation
import PKHUD

class APIRequestURLSession {
    // MARK: -properties
    // ベースとなるurl
    private var baseurl = URLComponents(string: "https://ja.wikipedia.org/w/api.php")!
    static var shared = APIRequestURLSession()
    // パラメータ
    private var queryItems = [
        URLQueryItem(name: "format", value: "json"),
        URLQueryItem(name: "action", value: "query"),
        URLQueryItem(name: "prop", value: "extracts"),
        URLQueryItem(name: "explaintext", value: "")
    ]

    func apiRequest (item: URLQueryItem, complition: @escaping(Result) -> Void) {
        queryItems.append(item)
        baseurl.queryItems = queryItems

        var request = URLRequest(url: baseurl.url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return
                print("リクエストに失敗しました。")
            }
            // エラーコードが300番以下なら処理続行
            if response.statusCode <= 300 {
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Result.self, from: data)
                    print("decodeに成功しました。")
                    // コールバック
                    complition(result)
                } catch let error as NSError {
                    HUD.hide()
                    print("decodeに失敗しました。\(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
