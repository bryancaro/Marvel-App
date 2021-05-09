//
//  CharacterCell.swift
//  mobile-test
//
//  Created by Bryan Caro on 5/8/21.
//

import Foundation
import UIKit
import SDWebImage

class CharacterCell: UICollectionViewCell {
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
        image.setDimensions(height: 130, width: 130)
        image.layer.cornerRadius = 20
        return image
    }()
    
    private var title: UILabel = {
        let label           = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 10)
        label.textColor = .gray
        
        return label
    }()
    
    private var subTitle: UILabel = {
        let label           = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        
        return label
    }()
    
    // MARK: - Properties
    static let cellId = "CharacterCell"
    
    var character: Character? {
        didSet {
            subTitle.text = character?.name
            
            let path = character?.thumbnail["path"] ?? ""
            let exte = character?.thumbnail["extension"] ?? ""
            let url = URL(string: "\(path).\(exte)")
            imageView.sd_setImage(with: url!)
        }
    }
    
    var index: Int? {
        didSet {
            title.text = "Charter \(index ?? 0)"
        }
    }
    
    // MARK: - Initializer
    
    //override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    // MARK: - Helper Functions
    func configureUI() {
        backgroundColor = .clear
        
        addSubview(containerImage)
        imageView.anchor(top: topAnchor, paddingTop: 0, width: 130, height: 130)
        
        addSubview(title)
        title.anchor(top: imageView.bottomAnchor, left: imageView.leftAnchor, right: imageView.rightAnchor, paddingTop: 5, paddingLeft: 3, paddingRight: 16)
        
        addSubview(subTitle)
        subTitle.anchor(top: title.bottomAnchor, left: imageView.leftAnchor, right: imageView.rightAnchor, paddingTop: 0, paddingLeft: 3, paddingRight: 16)
        
    }
}
