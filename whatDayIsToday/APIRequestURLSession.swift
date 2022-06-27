//
//  APIRequestURLSession.swift
//  whatDayIsToday
//
//  Created by USER on 2022/05/09.
//

import Foundation
import PKHUD

class APIRequestURLSession {
    // MARK: - properties
    private var baseurl = URLComponents(string: "https://ja.wikipedia.org/w/api.php")!
    static var shared = APIRequestURLSession()
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
