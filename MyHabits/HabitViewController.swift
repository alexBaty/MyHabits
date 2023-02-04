//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Alexander Batyshev on 28.01.2023.
//

import UIKit

class HabitViewController: UIViewController, UIColorPickerViewControllerDelegate {

    var popToRootDelegate: PopToRoot?

    var habitIndex: Int?
    var habit = Habit(name: "", date: Date(), color: .systemRed)
    var tempName = ""
    var tempColor: UIColor = .systemRed
    var tempDate = Date()

    let habitNameLabel: UILabel = {
        var habitNameLabel = UILabel()
        habitNameLabel.text = "НАЗВАНИЕ"
        habitNameLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        habitNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return habitNameLabel
    }()

    lazy var habitNameText: UITextField = {
        var habitNameText = UITextField()
        habitNameText.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        habitNameText.clearButtonMode = .whileEditing
        habitNameText.addTarget(self, action: #selector(setName), for: .editingChanged)
        habitNameText.translatesAutoresizingMaskIntoConstraints = false
        return habitNameText
    }()

    let colorLabel: UILabel = {
        var colorLabel = UILabel()
        colorLabel.text = "ЦВЕТ"
        colorLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        return colorLabel
    }()

    lazy var colorButton: UIButton = {
        var colorButton = UIButton()
        colorButton.setImage(UIImage(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32)), for: .normal)
        colorButton.addTarget(self, action: #selector(setColor), for: .touchUpInside)
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        return colorButton
    }()

    let dateLabel: UILabel = {
        var dateLabel = UILabel()
        dateLabel.text = "ВРЕМЯ"
        dateLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()

    let dateSubLabel: UILabel = {
        var dateSubLabel = UILabel()
        dateSubLabel.text = "Каждый день в "
        dateSubLabel.font = UIFont.systemFont(ofSize: 17, weight:  .regular)
        dateSubLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateSubLabel
    }()

    let time: UILabel = {
        var time = UILabel()
        time.textColor = UIColor(red: 161/255, green:  22/255, blue: 204/255, alpha: 1)
        time.font = UIFont.systemFont(ofSize: 17, weight:  .regular)
        time.translatesAutoresizingMaskIntoConstraints = false
        return time
    }()

    lazy var datePiker: UIDatePicker = {
        var datePiker = UIDatePicker()
        datePiker.addTarget(self, action: #selector(setDate), for: .valueChanged)
        datePiker.preferredDatePickerStyle = .wheels
        datePiker.datePickerMode = .time
        datePiker.translatesAutoresizingMaskIntoConstraints = false
        return datePiker
    }()

    lazy var deleteButton: UIButton = {
        var deleteButton = UIButton(type: .system)
        deleteButton.setTitle("Удалить привычку", for: .normal)
        deleteButton.backgroundColor = .systemGray5
        deleteButton.setTitleColor(.systemRed, for: .normal)
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        deleteButton.isHidden = true
        deleteButton.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        return deleteButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = habitIndex == nil ? "Создать" : "Править"
        navigationController?.navigationBar.tintColor = UIColor(red: 161/255, green:  22/255, blue: 204/255, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(save))

        if habitIndex != nil {
            tempName = store.habits[habitIndex!].name
            tempColor = store.habits[habitIndex!].color
            tempDate = store.habits[habitIndex!].date
            habit = store.habits[habitIndex!]
            deleteButton.isHidden = false
        }

        habitNameText.text = habit.name
        colorButton.tintColor = habit.color
        time.text = habit.timeString
        addSubviews()
        createHabitViewConstraints()
    }

    func addSubviews() {
        view.addSubview(habitNameLabel)
        view.addSubview(habitNameText)
        view.addSubview(colorLabel)
        view.addSubview(colorButton)
        view.addSubview(dateLabel)
        view.addSubview(dateSubLabel)
        view.addSubview(time)
        view.addSubview(datePiker)
        view.addSubview(deleteButton)
    }

    func createHabitViewConstraints() {

        NSLayoutConstraint.activate([
            habitNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            habitNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            habitNameText.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: 8),
            habitNameText.leadingAnchor.constraint(equalTo: habitNameLabel.leadingAnchor),
            habitNameText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            colorLabel.topAnchor.constraint(equalTo: habitNameText.bottomAnchor, constant: 32),
            colorLabel.leadingAnchor.constraint(equalTo: habitNameLabel.leadingAnchor),
            colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 16),
            colorButton.leadingAnchor.constraint(equalTo: habitNameLabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 32),
            dateLabel.leadingAnchor.constraint(equalTo: habitNameLabel.leadingAnchor),
            dateSubLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            dateSubLabel.leadingAnchor.constraint(equalTo: habitNameLabel.leadingAnchor),
            time.leadingAnchor.constraint(equalTo: dateSubLabel.trailingAnchor),
            time.bottomAnchor.constraint(equalTo: dateSubLabel.bottomAnchor),
            datePiker.topAnchor.constraint(equalTo: dateSubLabel.bottomAnchor, constant: 32),
            datePiker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }

    @objc private func setName(_ textField: UITextField) {
        habit.name = textField.text ?? ""
    }

    @objc func setColor() {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        picker.modalPresentationStyle = .fullScreen
        picker.modalTransitionStyle = .crossDissolve
        self.present(picker, animated: true)
    }

    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        habit.color = color
        colorButton.tintColor = habit.color
    }

    @objc func setDate(_ datePiker: UIDatePicker){
        habit.date = datePiker.date
        tempDate = datePiker.date
        time.text = habit.timeString
    }

    @objc private func save() {
        if habit.name != "" {
            if habitIndex == nil {
                store.habits.append(habit)
            } else {
                store.save()
            }
        }
        dismiss(animated: true)
    }

    @objc private func cancel() {
        habit.name = tempName
        habit.color = tempColor
        habit.date = tempDate
        dismiss(animated: true)
    }

    @objc private func deleteHabit() {

        let alert = UIAlertController(title: "Удалить привычку",  message: "Хотите удалить привычку \"\(habit.name)\"?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive) { [self]_ in
            store.habits.remove(at: habitIndex ?? 0)
            popToRootDelegate?.popToRoot()
            dismiss(animated: true)
        })
        present(alert, animated: true)
    }
}
