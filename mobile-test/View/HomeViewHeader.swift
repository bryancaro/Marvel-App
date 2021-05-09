//
//  Header.swift
//  mobile-test
//
//  Created by Bryan Caro on 5/7/21.
//

import UIKit

let screen = UIScreen.main.bounds

class HomeViewHeader: UIView {    
    // MARK: - Subviews
    private lazy var dateTime: UILabel = {
        let label            = UILabel()
        label.textColor      = .gray
        label.font           = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment  = .left
        
        let today            = Date()
        let formatter        = DateFormatter()
        formatter.dateFormat = "d MMM y"
        
        label.text           = "\(formatter.string(from: today)) ⛅"
        
        return label
    }()
    
    private var title: UILabel = {
        let label            = UILabel()
        label.textColor      = .black
        label.font           = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment  = .left
        
        label.text           = "Good"
        
        return label
    }()
    
    private let logo: UIImageView = {
        let image                 = UIImageView()
        image.image               = #imageLiteral(resourceName: "splash")
        image.contentMode         = .scaleAspectFit
        return image
    }()
    
    private lazy var containerTop: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        let stack = UIStackView(arrangedSubviews: [dateTime, title])
        stack.distribution = .fillProportionally
        stack.spacing      = 0
        stack.axis         = .vertical
        
        view.addSubview(stack)
        stack.centerY(inView: view)
        stack.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(logo)
        logo.centerY(inView: view)
        logo.anchor(right: view.rightAnchor, paddingRight: 16)
        logo.setDimensions(height: 80, width: 80)
        
        return view
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configText()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Helper Functions
    func configureUI() {
        addSubview(containerTop)
        containerTop.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingRight: 0, width: screen.width, height: 100)
        containerTop.centerX(inView: self)
    }
    
    func configText() {
        title.text = "Good \(check() ?? "Day")"
    }
}
