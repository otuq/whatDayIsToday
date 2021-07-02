//
//  InformationViewController.swift
//  informationGatherringApp
//
//  Created by USER on 2021/05/24.
//

import UIKit

class InformationViewController: UIViewController {
    
    //MARK: -properties
//    var models = [Result]()
    
    //MARK: -Outlets
    
    @IBOutlet weak var informationTableView: UITableView!
    
    //MARK: -LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        settingViews()
    }
    
    private func setUpViews() {
        informationTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cellId")
        informationTableView.delegate = self
        informationTableView.dataSource = self
    }
    
    private func settingViews() {
        
    }
}

extension InformationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)as! TableViewCell
//        cell.model = models[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
