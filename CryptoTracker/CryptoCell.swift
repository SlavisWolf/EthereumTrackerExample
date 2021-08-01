//
//  CryptoCell.swift
//  CryptoTracker
//
//  Created by Zapp Antonio on 1/8/21.
//

import UIKit

struct CryptoTableViewCellViewModel {
    let title: String
    let value: String
}

class CryptoCell: UITableViewCell {
    
    static let identifier = "CryptoCell_ID"
    
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    var valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(valueLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        valueLabel.sizeToFit()
        label.sizeToFit()
        
        label.frame = CGRect(x: 15, y: 10, width: label.frame.size.width, height: label.frame.size.height)
        valueLabel.frame = CGRect(x: contentView.frame.size.width - label.frame.size.width - 15, y: 10, width: label.frame.size.width, height: label.frame.size.height)
    }
    
    func configure(_ viewModel: CryptoTableViewCellViewModel) {
        label.text = viewModel.title
        valueLabel.text = viewModel.value
    }

}
