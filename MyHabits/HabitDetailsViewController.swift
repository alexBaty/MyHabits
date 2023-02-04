//
//  DetailsViewController.swift
//  MyHabits
//
//  Created by Alexander Batyshev on 28.01.2023.
//

import UIKit

class HabitDetailsViewController: UIViewController, UITableViewDataSource {

    var habitIndex = 0
    var countOfRows = store.dates.count - 1

    lazy var habitsList: UITableView = {
        var habitsList = UITableView()
        habitsList.backgroundColor = .systemGray4
        habitsList.dataSource = self
        habitsList.register(UITableViewCell.self, forCellReuseIdentifier: ProgressCollectionViewCell.cellID)
        habitsList.translatesAutoresizingMaskIntoConstraints = false
        return habitsList
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        navigationItem.title = store.habits[habitIndex].name
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .done, target: self, action: #selector(editHabit))
        view.addSubview(habitsList)
        createDetailsViewConstraints()
    }

    func createDetailsViewConstraints() {

        NSLayoutConstraint.activate([
            habitsList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitsList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitsList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitsList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc func editHabit() {
        let habitVC = HabitViewController()
        habitVC.habitIndex = habitIndex
        habitVC.popToRootDelegate = self
        let navigationVC = UINavigationController(rootViewController: habitVC)
        navigationVC.modalPresentationStyle = .fullScreen
        navigationVC.modalTransitionStyle = .flipHorizontal
        navigationController?.present(navigationVC, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProgressCollectionViewCell.cellID, for: indexPath)
        var content = cell.defaultContentConfiguration()
        let indexRevers = countOfRows - 1 - indexPath.row
        content.text = store.trackDateString(forIndex: indexRevers) ?? "no date for index \(indexPath.row)"
        cell.contentConfiguration = content
        cell.backgroundColor = .white
        cell.selectionStyle = .none

        if store.habit(store.habits[habitIndex], isTrackedIn: store.dates[indexRevers]) {
            cell.accessoryType  = .checkmark
            cell.tintColor = .purple
        }
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "АКТИВНОСТЬ"
    }
}

extension HabitDetailsViewController: PopToRoot {
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}
