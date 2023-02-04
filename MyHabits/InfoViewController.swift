//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Alexander Batyshev on 28.01.2023.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDataSource {

    let labelInfo: UILabel = {
        var labelInfo = UILabel()
        labelInfo.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        labelInfo.text = "Привычка за 21 день"
        labelInfo.translatesAutoresizingMaskIntoConstraints = false
        return labelInfo
    }()

    lazy var tableInfo: UITableView = {
        var tableInfo = UITableView(frame: .zero, style: .grouped)
        tableInfo.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        tableInfo.tableHeaderView = labelInfo
        tableInfo.separatorStyle = .none
        tableInfo.dataSource = self
        tableInfo.translatesAutoresizingMaskIntoConstraints = false
        return tableInfo
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        view.addSubview(tableInfo)
        title = "Информация"
        createInfoViewConstraints()
    }

    func createInfoViewConstraints() {

        NSLayoutConstraint.activate([
            tableInfo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableInfo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableInfo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableInfo.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            labelInfo.topAnchor.constraint(equalTo: tableInfo.topAnchor, constant: 8),
            labelInfo.leadingAnchor.constraint(equalTo: tableInfo.leadingAnchor, constant: 18)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = infoText
        cell.isSelected = false
        cell.selectionStyle = .none
        cell.contentConfiguration = content
        return cell
    }
}
