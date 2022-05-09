//
//  SubViewController.swift
//  informationGatherringApp
//
//  Created by USER on 2022/02/02.
//

import UIKit

class SubViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ok")
        let item = URLQueryItem(name: "titles", value: "うどん")
        APIRequestURLSession.shard.apiRequest(item: item) { result in
            guard  let key = result.query.pages.first?.key,
                   let article = result.query.pages[key]?.extract  else { return }

            print(article)
        }
    }
}
