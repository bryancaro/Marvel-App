//
//  CharacterHeader.swift
//  mobile-test
//
//  Created by Bryan Caro on 5/9/21.
//

import Foundation
import UIKit

protocol CharacterHeaderDelegate: class {
    func dismiss()
}

class CharacterHeader: UIView {
    // MARK: - Properties
    var character: Character? {
        didSet {
            subTitle.text = character?.name
            
            let path = character?.thumbnail["path"] ?? ""
            let exte = character?.thumbnail["extension"] ?? ""
            let url  = URL(string: "\(path).\(exte)")
            wallpaper.sd_setImage(with: url!)
            profileLogo.sd_setImage(with: url!)
            
            title.text    = character?.name
            subTitle.text = character?.description
        }
    }
    
    weak var delegate : CharacterHeaderDelegate?
    
    // MARK: - Subviews
    private lazy var wallpaper: UIImageView = {
        let image                 = UIImageView()
        image.image               = #imageLiteral(resourceName: "IM")
        image.contentMode         = .scaleToFill
        image.layer.cornerRadius  = 20
        return image
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var containerImage: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 50
        view.addShadow()
        
        view.addSubview(profileLogo)
        
        return view
    }()
    
    private let profileLogo: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "splash")
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.setDimensions(height: 100, width: 100)
        image.layer.cornerRadius = 50
        return image
    }()
    
    private lazy var title: UILabel = {
        let label            = UILabel()
        label.textColor      = .black
        label.font           = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment  = .left
        
        label.text           = "Good Moorning"
        
        return label
    }()
    
    private lazy var subTitle: UILabel = {
        let label            = UILabel()
        label.textColor      = .black
        label.font           = UIFont.systemFont(ofSize: 10)
        label.textAlignment  = .left
        label.numberOfLines  = 10
        
        label.text           = "Good Moorning"
        
        return label
    }()
    
    private lazy var containerTop: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        view.addSubview(containerImage)
        containerImage.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 10, paddingLeft: 16, width: 100, height: 100)
        
        let stack = UIStackView(arrangedSubviews: [title, subTitle])
        stack.distribution = .fill
        stack.spacing      = 0
        stack.axis         = .vertical
        
        view.addSubview(stack)
        stack.centerY(inView: containerImage)
        stack.anchor(top: view.topAnchor, left: containerImage.rightAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 30, paddingRight: 16)
        
        return view
        }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Helper Functions
    func configureUI() {
        addSubview(wallpaper)
        wallpaper.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 180)
        wallpaper.addShadow()
        
        addSubview(backButton)
        backButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 30, paddingLeft: -20, width: 100, height: 50)
        
        addSubview(containerTop)
        containerTop.anchor(top: wallpaper.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingRight: 0, width: screen.width, height: 150)
        containerTop.centerX(inView: self)
    }
    
    // MARK: - Selectors
    @objc func handleBackTapped() {
        delegate?.dismiss()
    }
}
