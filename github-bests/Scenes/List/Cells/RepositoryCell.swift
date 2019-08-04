//
//  RepositoryCell.swift
//  github-bests
//
//  Created by Paulo Lourenço on 02/08/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import UIKit
import SDWebImage

class RepositoryCell: UITableViewCell {
    
    // MARK: - Properties
    
    private lazy var authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var repositoryNameLabel: UILabel = {
        return UILabel()
    }()
    
    private lazy var starsLabel: UILabel = {
        return UILabel()
    }()
    
    private lazy var authorNameLabel: UILabel = {
        return UILabel()
    }()
    
    // MARK: - View lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        authorImageView.image = nil
        repositoryNameLabel.text = ""
        starsLabel.text = ""
        authorNameLabel.text = ""
    }
    
    // MARK: - Public methods
    
    func configure(repository: Repository) {
        repositoryNameLabel.text = repository.name
        starsLabel.text = "\(repository.stargazersCount) stars"
        authorNameLabel.text = repository.owner.login
        if let avatarUrl = URL(string: repository.owner.avatarUrl) {
            authorImageView.sd_setImage(with: avatarUrl, completed: nil)
        }
    }
    
    // MARK: - Private methods
    
    private func setupCell() {
        let padding: CGFloat = 6
        
        authorImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(authorImageView)
        NSLayoutConstraint.activate([
            authorImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            authorImageView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            authorImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            authorImageView.widthAnchor.constraint(equalToConstant: 90)
            ])
        
        let stackView = UIStackView(arrangedSubviews: [repositoryNameLabel, starsLabel, authorNameLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .blue
        stackView.spacing = 2
        stackView.distribution = .equalSpacing
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6)
        ])
        
    }
    
}
