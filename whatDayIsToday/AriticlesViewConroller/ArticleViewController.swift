//
//  ViewController.swift
//  whatDayIsToday
//
//  Created by USER on 2022/05/09.
//

import UIKit

class ArticleViewController: UIViewController {
    // MARK: - properties
    private let cellId = "cellId"
    private let articlesTableView = UITableView()
    var getArticles: (() -> [String]) = { [] }

    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        settingUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let parentVC = parent as! TabPageViewController
        articlesTableView.translatesAutoresizingMaskIntoConstraints = false
        [articlesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: parentVC.viewHeight),
         articlesTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
         articlesTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
         articlesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].forEach { $0.isActive = true }
    }
    private func settingUI() {
        articlesTableView.delegate = self
        articlesTableView.dataSource = self
        articlesTableView.rowHeight = UITableView.automaticDimension
        articlesTableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        view.addSubview(articlesTableView)
    }
}
extension ArticleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let articles = getArticles()
        return articles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)as! ArticleTableViewCell
        let articles = getArticles()
        cell.article = articles[indexPath.row]
        return cell
    }
}
