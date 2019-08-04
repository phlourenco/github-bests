//
//  BaseDisplayLogic.swift
//  github-bests
//
//  Created by Paulo Lourenço on 03/08/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import UIKit

protocol BaseDisplayLogic {
    func showError(title: String?, message: String?, tryAgainAction: (()->Void)?)
    func showScreenLoading()
    func hideScreenLoading()
}

extension BaseDisplayLogic where Self: UIViewController {
    
    func showError(title: String?, message: String?, tryAgainAction: (()->Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let tryAgainAction = tryAgainAction {
            alertController.addAction(UIAlertAction(title: "Tentar novamente", style: .default, handler: { alert in
                tryAgainAction()
            }))
        }
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showScreenLoading() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        backgroundView.restorationIdentifier = "backgroundView"
        view.addSubview(backgroundView)
        backgroundView.frame = view.frame
        
        let middleView = UIView()
        middleView.backgroundColor = #colorLiteral(red: 0.9143998472, green: 0.9143998472, blue: 0.9143998472, alpha: 1)
        backgroundView.addSubview(middleView)
        middleView.translatesAutoresizingMaskIntoConstraints = false
        
        middleView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        middleView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        middleView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        middleView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        middleView.cornerRadius = 5
        
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.startAnimating()
        middleView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.leadingAnchor.constraint(equalTo: middleView.leadingAnchor).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: middleView.trailingAnchor).isActive = true
        activityIndicator.topAnchor.constraint(equalTo: middleView.topAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: middleView.bottomAnchor).isActive = true
    }
    
    func hideScreenLoading() {
        DispatchQueue.main.async {
            self.view.subviews.first(where: { $0.restorationIdentifier == "backgroundView" })?.removeFromSuperview()
        }
    }
    
}
