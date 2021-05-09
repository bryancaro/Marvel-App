//
//  EventsCollectionView.swift
//  mobile-test
//
//  Created by Bryan Caro on 5/9/21.
//

import Foundation
import UIKit
import SDWebImage

protocol EventsCollectionViewDelegate: class {
    func showError(message: String)
}

class EventsCollectionView: UIView {
    // MARK: - Subviews
    private lazy var comicsCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled                = true
        collection.dataSource                     = self
        collection.delegate = self
        collection.register(EventCell.self, forCellWithReuseIdentifier: EventCell.cellId)
        collection.backgroundColor                = .clear
        collection.allowsSelection                = true
        if #available(iOS 14.0, *) {
            collection.allowsSelectionDuringEditing   = true
        } else {
            // Fallback on earlier versions
        }
        
        return collection
    }()
    
    private var subTitle       : UILabel = {
        let label            = UILabel()
        label.textColor      = .black
        label.font           = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment  = .left
        
        label.text           = "Feature Events"
        
        return label
    }()
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 0
        
        view.addSubview(imageView)
        imageView.centerX(to: view)
        imageView.centerY(inView: view)
        
        view.addSubview(message)
        message.anchor(top: imageView.bottomAnchor, paddingTop: 16)
        
        return view
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "nFound")
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        image.setDimensions(height: 150, width: 150)
        image.layer.cornerRadius = 0
        return image
    }()
    
    private var message       : UILabel = {
        let label            = UILabel()
        label.textColor      = .black
        label.font           = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment  = .center
        label.text           = "No found"
        
        return label
    }()
    // MARK: - Properties
    weak var delegate : EventsCollectionViewDelegate?
    private var details    = [Detail]()
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    func configureUI() {
        backgroundColor = .clear
        setupCollectionView()
    }
    
    func setupCollectionView() {
        addSubview(subTitle)
        subTitle.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 16, paddingRight: 0, height: 35)
        
        addSubview(comicsCollectionView)
        comicsCollectionView.anchor(top: subTitle.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 250)
        
        addSubview(container)
        container.anchor(width: 100, height: 150)
        container.centerY(to: self)
        container.centerX(to: self)
        container.alpha = 0
    }
}

// MARK: - UICollectionViewDataSource
extension EventsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return details.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.cellId, for: indexPath) as? EventCell else { return UICollectionViewCell() }
        cell.comic = details[indexPath.row]
        return cell
    }
}

// MARK: - Public
extension EventsCollectionView {
    public func configureView(id: Int, type: Type) {
        let carouselLayout                          = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection              = .horizontal
        carouselLayout.itemSize                     = .init(width: 150, height: 220)
        carouselLayout.sectionInset                 = .init(top: 0, left: 10, bottom: 0, right: 10)
        carouselLayout.minimumLineSpacing           = 20
        comicsCollectionView.collectionViewLayout  = carouselLayout
        
        ChargeAPI.retrieveCharacterDetails(id: id,type: type) { result, error in
            if error != nil {
                print(error?.localizedDescription)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.delegate?.showError(message: error?.localizedDescription ?? "Something happened")
                }
            } else {
                // Load data
                guard let details = result?.data.results else { return }
                self.details = details
                
                if details.isEmpty {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        UIView.animate(withDuration: 2) {
                            self.container.alpha = 1
                            self.comicsCollectionView.alpha = 0
                        }
                    }
                    
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        
                        self.container.alpha = 0
                    }
                }
                
                UIView.animate(withDuration: 0.3) {
                    DispatchQueue.main.async{
                        self.comicsCollectionView.reloadData()
                    }
                }
            }
        }
    }
}
