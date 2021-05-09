//
//  CarouselCell.swift
//  mobile-test
//
//  Created by Bryan Caro on 5/8/21.
//

import Foundation
import UIKit

class CarouselCell: UICollectionViewCell {
    // MARK: - Properties
    static let cellId = "CarouselCell"
    
    // MARK: - SubViews
    private lazy var containerImage: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.addShadow()
        
        view.addSubview(imageView)
        
        return view
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "splash")
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.setDimensions(height: 300, width: 300)
        image.layer.cornerRadius = 20
        return image
    }()
    
    private var textLabel: UILabel = {
        let label           = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        label.textColor = .gray
        label.numberOfLines = 2
        
        return label
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    // MARK: - Helper Functions
    func configureUI() {
        backgroundColor = .clear
        
        addSubview(containerImage)
        containerImage.anchor(width: 300, height: 300)
        
        addSubview(textLabel)
        textLabel.anchor(top: imageView.bottomAnchor, left: imageView.leftAnchor, right: imageView.rightAnchor, paddingTop: 5, paddingLeft: 16, paddingRight: 16, height: 50)
    }
}

// MARK: - Public
extension CarouselCell {
    public func configure(image: UIImage?, text: String) {
        imageView.image = image
        textLabel.text = text
    }
}
