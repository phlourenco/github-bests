//
//  UITableView.swift
//  github-bestsTests
//
//  Created by Paulo Lourenço on 05/08/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import UIKit

extension UITableView {
    
    func scrollToLastRow(inSection section: Int, animated: Bool) {
        self.scrollToRow(at: IndexPath(row: self.numberOfRows(inSection: section)-1, section: section), at: .bottom, animated: animated)
    }
    
}
