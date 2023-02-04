//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Alexander Batyshev on 28.01.2023.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {

    static let cellID = "ProgressCollectionViewCell"

    let progressLabel: UILabel = {
        var progressLabel = UILabel()
        progressLabel.textColor = .systemGray
        progressLabel.font = UIFont.systemFont(ofSize: 13, weight:  .regular)
        progressLabel.text = "Всё получится!"
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        return progressLabel
    }()

    let percent: UILabel = {
        var percent = UILabel()
        percent.textColor = .systemGray
        percent.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        percent.translatesAutoresizingMaskIntoConstraints = false
        return percent
    }()

    let progressBar: UIProgressView = {
        var progressBar = UIProgressView()
        progressBar.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        progressBar.progressTintColor = UIColor(red: 161/255, green:  22/255, blue: 204/255, alpha: 1)
        progressBar.layer.cornerRadius = 4
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()

    override init(frame: CGRect) {
        super .init(frame: .zero)
        contentView.backgroundColor = .white
        addSubviews()
        createProgressCollectionViewCellConstraints()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}

    func addSubviews(){
        contentView.layer.cornerRadius = 9
        contentView.addSubview(progressLabel)
        contentView.addSubview(percent)
        contentView.addSubview(progressBar)
    }

    func createProgressCollectionViewCellConstraints() {

        NSLayoutConstraint.activate([
            progressLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            progressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            percent.topAnchor.constraint(equalTo: progressLabel.topAnchor),
            percent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            progressBar.heightAnchor.constraint(equalToConstant: 8),
            progressBar.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 16),
            progressBar.leadingAnchor.constraint(equalTo: progressLabel.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: percent.trailingAnchor),
            progressBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    func setData() {
        percent.text = String(format: "%.0f%%", store.todayProgress * 100)
        progressBar.progress = store.todayProgress
    }
    
}
