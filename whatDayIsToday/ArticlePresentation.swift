//
//  HomeVCPresenter.swift
//  whatDayIsToday
//
//  Created by USER on 2022/05/12.
//

import Foundation
import PKHUD

class ArticlePresentation {
    // MARK: -Properties
    private var articles: [String]?
    // MARK: -LifeCycle Methods
    init() {
        self.articles = articlesInfoGathering()
        DispatchQueue.main.async {
            HUD.hide()
        }
    }
    private func articlesInfoGathering() -> [String]? {
        // 非同期処理であるapi情報の取得してを直列にするためDispatchSemaphoreを使ってapi取得完了まで待機状態する。
        let semaphore = DispatchSemaphore(value: 0)
        var article: [String]?
        let currentDateString = UserDefaults.standard.string(forKey: "selectDate")
        let item = URLQueryItem(name: "titles", value: currentDateString ?? "うどん")
        APIRequestURLSession.shared.apiRequest(item: item) { result in
            guard let pageId = result.query.pages.keys.first,
                  let resultArticle = result.query.pages[pageId]?.extract else { return }
            var resultArray = resultArticle.components(separatedBy: "\n")
            resultArray = resultArray.map { $0.trimmingCharacters(in: .whitespaces) }
            resultArray = resultArray.filter { !($0.isEmpty) && !($0.hasPrefix("===")) }
            resultArray = resultArray.map {
                var result = $0
                if let range = $0.range(of: "*") {
                    result.removeSubrange(range)
                }
                return result
            }
            article = resultArray
            semaphore.signal()
        }
        semaphore.wait()
        return article
    }
    func articleExtract(start: Int, end: Int) -> [String]? {
        guard let articles = articles else { return nil }
        // サブタイトルが含まれている配列番号を収集
        var indexs = [Int]()
        // サブタイトルの配列番号を取得して格納する。 サブタイトルは両端を"=="で囲っている。サブサブタイトルは"==="で囲われているが使わないので除外する。
        articles.enumerated().forEach { index, result in
            if result.hasPrefix("==") {
                indexs.append(index)
            }
        }
        // サブタイトルの次がサブタイトルの場合があるため次の番号がindexsに含まれているか
        let startInd = indexs.contains((indexs[start] + 1)) ? (indexs[start] + 2) : (indexs[start] + 1)
        let endInd = indexs.contains((indexs[end] - 1)) ? (indexs[end] - 2) : (indexs[end] - 1)
        let extractArray = articles[startInd...endInd]
        return Array(extractArray)
    }
}
