//
//  ComicCell.swift
//  mobile-test
//
//  Created by Bryan Caro on 5/9/21.
//

import Foundation
import UIKit
import SDWebImage

class ComicCell: UICollectionViewCell {
    
    // MARK: - SubViews
    private lazy var containerImage: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 0
        view.addShadow()
        
        view.addSubview(imageView)
        imageView.anchor(top: view.topAnchor, paddingTop: 0)
        
        return view
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "splash")
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        image.setDimensions(height: 180, width: 120)
        image.layer.cornerRadius = 0
        return image
    }()
    
    private var subTitle: UILabel = {
        let label           = UILabel()
        label.numberOfLines = 10
        label.textAlignment = .left
        label.font          = .systemFont(ofSize: 10)
        label.textColor     = .black
        
        return label
    }()
    
    // MARK: - Properties
    static let cellId = "DetailCell"
    
    var comic: Detail? {
        didSet {
            subTitle.text = comic?.title
            
            let path = comic?.thumbnail["path"] ?? ""
            let exte = comic?.thumbnail["extension"] ?? ""
            let url = URL(string: "\(path).\(exte)")
            imageView.sd_setImage(with: url!)
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
        containerImage.anchor(top: topAnchor, paddingTop: 0, width: 120, height: 180)
        
        addSubview(subTitle)
        subTitle.anchor(top: containerImage.bottomAnchor, left: containerImage.leftAnchor, right: containerImage.rightAnchor, paddingTop: 3, paddingLeft: 0, paddingRight: 0)
    }
}
