//
//  ViewController.swift
//  whatDayIsToday
//
//  Created by USER on 2022/05/09.
//

import UIKit

class BirthDayViewController: UIViewController {
    enum ButtonName: Int {
        case buttonA, buttonB, buttonC, buttonD, buttonE, buttonF
    }
    // MARK: properties
    private var articles: [String]?
    private let cellId = "cellId"
    // MARK: Outlets,Actions

    @IBOutlet var birthDayTableView: UITableView!
    // MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        settingUI()
    }
    private func initialize() {
        //        articles = ArticlePresentation.shared.articleExtract(start: 1, end: 2)
    }
    private func settingUI() {
        birthDayTableView.delegate = self
        birthDayTableView.dataSource = self
        birthDayTableView.rowHeight = UITableView.automaticDimension
        birthDayTableView.register(UINib(nibName: "BirthDayTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
}
extension BirthDayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles?.count ?? 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)as! BirthDayTableViewCell
        cell.article = articles?[indexPath.row]
        return cell
    }
}
