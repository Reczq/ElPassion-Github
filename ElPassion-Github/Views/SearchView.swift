//
//  SearchView.swift
//  ElPassion-Github
//
//  Created by Dominik Reczek on 10/12/16.
//  Copyright © 2016 Dominik Reczek. All rights reserved.
//

import UIKit
import SnapKit

class SearchView: UIView {

    let resultTableView: UITableView

    override init(frame: CGRect) {
        resultTableView = UITableView(frame: CGRect.zero, style: .grouped)

        super.init(frame: frame)

        self.setupTableview()
        updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupTableview() {
        backgroundColor = #colorLiteral(red: 0.1879811585, green: 0.1879865527, blue: 0.1879836619, alpha: 1)
        resultTableView.backgroundColor = UIColor.clear
        resultTableView.separatorStyle = .none
        resultTableView.rowHeight = 90.0

        addSubview(resultTableView)
    }

    override func updateConstraints() {
        resultTableView.snp.updateConstraints { (maker) in
            maker.edges.equalTo(self)
        }

        super.updateConstraints()
    }
}
