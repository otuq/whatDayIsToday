//
//  ViewController.swift
//  informationGatherringApp
//
//  Created by USER on 2021/05/24.
//

import UIKit

class HomeViewController: UIViewController {
    enum ButtonName: Int {
        case buttonA, buttonB, buttonC, buttonD, buttonE, buttonF
    }

    // MARK: properties
    var article: [String]?

    // MARK: Outlets

    // MARK: Actions

    // MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        articleInfoGathering()
    }

    private func articleInfoGathering() {
        let parms = ["titles": "軍事指揮官の一覧"]
        APIRequest.shared.apiRequest(parms: parms) { result in
            guard let pageId = result.query.pages.keys.first,
                  let resultArticle = result.query.pages[pageId]?.extract else { return }

            var resultArray = resultArticle.components(separatedBy: "\n")
            resultArray = resultArray.filter { $0.isEmpty }
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
            let articleArray = resultArray[startInd...endInd].map { $0 }
            self.article = articleArray
            //            print(self.article)
        }
    }

    private func transitionVC() {
        let storyboard = UIStoryboard(name: "Information", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "InformationViewController")
        present(vc, animated: true)
    }
}
