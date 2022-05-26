//
//  HomeVCPresenter.swift
//  whatDayIsToday
//
//  Created by USER on 2022/05/12.
//

import Foundation

class ArticlePresenter {
    static var shared = ArticlePresenter()
    
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
            // filterで絞り込んだ時配列番号が元の配列番号は保持しているのか？
            // サブタイトルの配列番号を取得して格納する。このサブタイトルの配列番号を元に区分する。サブタイトルは両端を"="で囲っている。
            resultArray.enumerated().forEach { index, result in
                if result.hasPrefix("=") {
                    indexs.append(index)
                }
            }
            // サブタイトルが連続で続いている記事の場合にサブタイトルも記事の一覧に表示してしまうため、目的のサブタイトルの次に連続でタイトルが含まれる記事の場合、
            // タイトルを記事に含ませないための条件　タイトルの配列番号が45でその次のタイトル46がもし含まれている場合、そのタイトルの記事は47から開始される。
            let startInd = indexs.contains((indexs[0] + 1)) ? (indexs[0] + 2) : (indexs[0] + 1)
            let endInd = indexs.contains((indexs[1] - 1)) ? (indexs[1] - 2) : (indexs[1] - 1)
            let extractArray = resultArray[startInd...endInd]
            article = Array(extractArray)
            semaphore.signal()
        }
        semaphore.wait()
        return article
    }
}
