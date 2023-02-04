//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Alexander Batyshev on 28.01.2023.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {

    static let cellID = "HabitCollectionViewCell"

    var cellIndex = 0

    let habitName: UILabel = {
        var habitName = UILabel()
        habitName.textColor = UIColor(red: 41/255, green: 109/255, blue: 1, alpha: 1)
        habitName.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        habitName.numberOfLines = 2
        habitName.translatesAutoresizingMaskIntoConstraints = false
        return habitName
    }()

    let date: UILabel = {
        var date = UILabel()
        date.textColor = .systemGray2
        date.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()

    let counter: UILabel = {
        var counter = UILabel()
        counter.textColor = .systemGray2
        counter.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        counter.translatesAutoresizingMaskIntoConstraints = false
        return counter
    }()

    let checkButton: UIButton = {
        var checkButton = UIButton()
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        return checkButton
    }()

    let checkImage: Dictionary <Bool, UIImage> = [
        false: UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32))!,
        true : UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32))!
    ]

    override init(frame: CGRect) {
        super .init(frame: .zero)
        contentView.backgroundColor = .white
        addSubviews()
        createHabitCollectionViewCellConstraints()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}

    func addSubviews(){
        contentView.layer.cornerRadius = 9
        contentView.addSubview(habitName)
        contentView.addSubview(date)
        contentView.addSubview(counter)
        contentView.addSubview(checkButton)
    }

    func createHabitCollectionViewCellConstraints() {

        NSLayoutConstraint.activate([
            habitName.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            habitName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            habitName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -64),
            date.topAnchor.constraint(equalTo: habitName.bottomAnchor, constant: 8),
            date.leadingAnchor.constraint(equalTo: habitName.leadingAnchor),
            checkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            counter.leadingAnchor.constraint(equalTo: habitName.leadingAnchor),
            counter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    func setData(_ index: Int) {
        cellIndex = index
        let habit = store.habits[index]
        habitName.text = habit.name
        date.text = habit.dateString
        counter.text = String(habit.trackDates.count)
        checkButton.tintColor = habit.color
        checkButton.setImage(checkImage[habit.isAlreadyTakenToday], for: .normal)
        if habit.isAlreadyTakenToday == false {checkButton.addTarget(self, action: #selector(checkHabit), for: .touchUpInside)}
    }

    @objc func checkHabit() {
        if store.habits[cellIndex].isAlreadyTakenToday == false {
            store.track(store.habits[cellIndex])
            (superview as? UICollectionView)?.reloadItems(at: [IndexPath(row: 0, section: 0), IndexPath(row: cellIndex, section: 1)])
        }
    }
}
