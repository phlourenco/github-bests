//
//  LoadingView.swift
//  github-bests
//
//  Created by Paulo Lourenço on 02/08/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    // MARK: - View lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    // MARK: - Private methods
    
    private func setup() {
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
    
}
