//
//  CharactersView.swift
//  mobile-test
//
//  Created by Bryan Caro on 5/8/21.
//

import Foundation
import UIKit
import SDWebImage

protocol CharacterDetailsDelegate: class {
    func characterSelected(with character: Character)
    func success()
    func showError(message: String)
}

class CharactersCollectionView: UIView {
    // MARK: - Subviews
    private lazy var charactersCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled                = true
        collection.dataSource                     = self
        collection.delegate = self
        collection.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.cellId)
        collection.backgroundColor                = .clear
        collection.allowsSelection                = true
        
        return collection
    }()
    
    private var subTitle       : UILabel = {
        let label            = UILabel()
        label.textColor      = .black
        label.font           = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment  = .left
        
        label.text           = "Marvel Characters"
        
        return label
    }()
    // MARK: - Properties
    weak var delegate : CharacterDetailsDelegate?
    private var characters    = [Character]()
    
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
        
        addSubview(charactersCollectionView)
        charactersCollectionView.anchor(top: subTitle.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 220)
    }
}



// MARK: - UICollectionViewDataSource
extension CharactersCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.cellId, for: indexPath) as? CharacterCell else { return UICollectionViewCell() }
        cell.character = characters[indexPath.row]
        cell.index     = indexPath.row + 1
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.characterSelected(with: characters[indexPath.row])
    }
}

// MARK: - Public
extension CharactersCollectionView {
    public func configureView() {
        let carouselLayout                          = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection              = .horizontal
        carouselLayout.itemSize                     = .init(width: 150, height: 150)
        carouselLayout.sectionInset                 = .init(top: 0, left: 10, bottom: 0, right: 10)
        carouselLayout.minimumLineSpacing           = 20
        charactersCollectionView.collectionViewLayout = carouselLayout
        
        ChargeAPI.retrieveCharacters { results, error in
            if error != nil {
                print(error?.localizedDescription)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.delegate?.success()
                    self.delegate?.showError(message: error?.localizedDescription ?? "Something happened")
                }
            } else {
                self.characters = results?.data.results ?? [Character]()
                UIView.animate(withDuration: 0.3) {
                    DispatchQueue.main.async{
                        self.charactersCollectionView.reloadData()
                        self.delegate?.success()
                    }
                }
            }
        }
    }
}
