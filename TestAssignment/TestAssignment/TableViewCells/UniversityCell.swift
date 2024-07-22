//
//  UniversityListCell.swift
//  TestAssignment
//
//  Created by Pradeepkumar on 2021-10-03.
//

import Foundation
import UIKit

class UniversityCell: UITableViewCell {
    
    // Add your custom UI elements here
    var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "graduationcap.circle.fill")
        imageView.tintColor = .darkGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return imageView
    }()
    
    let lblTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lblCountry: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let lableStack = UIStackView()
        lableStack.axis = .vertical
        lableStack.distribution = .fillEqually
        lableStack.spacing = 8
                
        lblTitle.font = UIFont.systemFont(ofSize: 10)
        lblTitle.textColor = UIColor.gray
        
        lblCountry.font = UIFont.systemFont(ofSize: 8)
        lblCountry.textColor = UIColor.lightGray
        
        lableStack.addArrangedSubview(lblTitle)
        lableStack.addArrangedSubview(lblCountry)
        
        let mainStack = UIStackView()
        mainStack.axis = .horizontal
        mainStack.distribution = .fillProportionally
        mainStack.spacing = 8
        
        mainStack.addArrangedSubview(myImageView)
        mainStack.addArrangedSubview(lableStack)
        
        contentView.addSubview(mainStack)
        mainStack.toEdges(8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
