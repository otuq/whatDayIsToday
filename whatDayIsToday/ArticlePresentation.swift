//
//  HomeVCPresenter.swift
//  whatDayIsToday
//
//  Created by USER on 2022/05/12.
//

import Foundation
import PKHUD

class ArticlePresentation {
    static var shared = ArticlePresentation()

    func articleInfoGathering() -> [String]? {
        // 非同期処理であるapi情報の取得してを直列にするためDispatchSemaphoreを使ってapi取得完了まで待機状態する。
        // これがまだよくわからないのがAlamofireでやった場合うまくいかなかった。URLSessionだと下記のような方法でうまくいった。
        // AlamofireはAlamofireで動機通信する方法があるみたい
        let semaphore = DispatchSemaphore(value: 0)
        var article: [String]?
        let currentDateString = UserDefaults.standard.string(forKey: "selectDate")
        let item = URLQueryItem(name: "titles", value: currentDateString ?? "うどん")
        APIRequestURLSession.shared.apiRequest(item: item) { result in
            guard let pageId = result.query.pages.keys.first,
                  let resultArticle = result.query.pages[pageId]?.extract else { return }
            print(resultArticle)
            var resultArray = resultArticle.components(separatedBy: "\n")
            resultArray = resultArray.map { $0.trimmingCharacters(in: .whitespaces) }
            resultArray = resultArray.filter { !($0.isEmpty) }
            resultArray = resultArray.map {
                var result = $0
                if let range = $0.range(of: "*") {
                    result.removeSubrange(range)
                }
                return result
            }
            // サブタイトルが含まれている配列番号を収集
            var indexs = [Int]()
            // サブタイトルの配列番号を取得して格納する。 サブタイトルは両端を"="で囲っている。
            resultArray.enumerated().forEach { index, result in
                if result.hasPrefix("=") {
                    indexs.append(index)
                }
            }
            // サブタイトルの次がサブタイトルの場合があるため次の番号がindexsに含まれているか
            let startInd = indexs.contains((indexs[0] + 1)) ? (indexs[0] + 2) : (indexs[0] + 1)
            let endInd = indexs.contains((indexs[1] - 1)) ? (indexs[1] - 2) : (indexs[1] - 1)
            let extractArray = resultArray[startInd...endInd]
            article = Array(extractArray)
            semaphore.signal()
        }
        semaphore.wait()
        HUD.hide()
        return article
    }
}
