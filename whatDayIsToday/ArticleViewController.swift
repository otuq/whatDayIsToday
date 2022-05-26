//
//  ViewController.swift
//  whatDayIsToday
//
//  Created by USER on 2022/05/09.
//

import UIKit

class ArticleViewController: UIViewController {
    enum ButtonName: Int {
        case buttonA, buttonB, buttonC, buttonD, buttonE, buttonF
    }
    // MARK: properties
    private var articles: [String]?
    private let cellId = "cellId"
    // MARK: Outlets,Actions
    @IBOutlet var articleTableView: UITableView!
    
    // MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        settingUI()
    }
    private func initialize() {
        articles = ArticlePresenter.shared.articleInfoGathering()
    }
    private func settingUI() {
        articleTableView.delegate = self
        articleTableView.dataSource = self
        articleTableView.rowHeight = UITableView.automaticDimension
        articleTableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
}
extension ArticleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)as! ArticleTableViewCell
        cell.article = articles?[indexPath.row]
        return cell
    }
}
