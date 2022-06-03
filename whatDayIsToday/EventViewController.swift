//
//  ViewController.swift
//  whatDayIsToday
//
//  Created by USER on 2022/05/09.
//

import UIKit

class EventViewController: UIViewController {
    enum ButtonName: Int {
        case buttonA, buttonB, buttonC, buttonD, buttonE, buttonF
    }
    // MARK: properties
    private var articles: [String]?
    private let cellId = "cellId"
    // MARK: Outlets,Actions
    @IBOutlet var eventTableView: UITableView!

    // MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        settingUI()
    }
    private func initialize() {
        //        articles = ArticlePresentation.shared.articleExtract(start: 0, end: 1)
    }
    private func settingUI() {
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.rowHeight = UITableView.automaticDimension
        eventTableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
}
extension EventViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles?.count ?? 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)as! EventTableViewCell
        cell.article = articles?[indexPath.row]
        return cell
    }
}
