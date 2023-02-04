//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Alexander Batyshev on 28.01.2023.
//

import UIKit

class HabitsViewController: UIViewController {

    let label: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.text = "Сегодня"
        return label
    }()

    private lazy var habitsCollectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .systemGray5
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.cellID)
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.cellID)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHabit))
        view.addSubview(label)
        view.addSubview(habitsCollectionView)
        createHabitsViewConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        habitsCollectionView.reloadData()
    }

    func createHabitsViewConstraints() {

        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 40),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            habitsCollectionView.topAnchor.constraint(equalTo: label.bottomAnchor),
            habitsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc func addHabit() {
        let habitViewController = UINavigationController(rootViewController: HabitViewController())
        habitViewController.modalPresentationStyle = .fullScreen
        habitViewController.modalTransitionStyle = .flipHorizontal
        navigationController?.present(habitViewController, animated: true, completion: nil)
    }
}

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 0 ? 1 : store.habits.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: habitsCollectionView.bounds.width - 32,
               height: indexPath.section == 0 ? 16 * 4 + 8 : 130)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = habitsCollectionView.dequeueReusableCell(withReuseIdentifier: ProgressCollectionViewCell.cellID, for: indexPath) as! ProgressCollectionViewCell
            cell.setData()
            return cell
        } else {
            let cell = habitsCollectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.cellID, for: indexPath) as! HabitCollectionViewCell
            cell.setData(indexPath.row)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section > 0 {
            let detailsViewController = HabitDetailsViewController()
            detailsViewController.habitIndex = indexPath.row
            navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}
