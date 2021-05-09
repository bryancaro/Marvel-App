//
//  CharacterViewController.swift
//  mobile-test
//
//  Created by Bryan Caro on 5/8/21.
//

import UIKit
import Foundation
import SDWebImage

class CharacterViewController: UIViewController {
    // MARK: - SUBVIEWS
    lazy var scrollView        : UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame           = self.view.bounds
        view.contentSize     = contentViewSize
        return view
    }()
    
    lazy var containerView     : UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentViewSize
        return view
    }()
    
    private let header                = CharacterHeader()
    private var comicsCollectionsView = ComicsCollectionView()
    private var eventsCollectionsView = EventsCollectionView()
    private var seriesCollectionsView = SeriesCollectionView()
    
    // MARK: - PROPERTIES
    lazy var contentViewSize = CGSize(width: view.frame.width, height: view.frame.height + 400)

    var character: Character? {
        didSet {
            header.character = character
        }
    }
    
    //  MARK: - PROPERTIES && CONSTANTS
    
    //  MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacterData()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //  MARK: - HELPER FUNCTIONS
    func configureUI() {
        configureScrollView()
        configureNavigationBar()
        configHeader()
        configureComicsCollectionsView()
        configureEventsCollectionsView()
        configureSeriesCollectionsView()
    }
    
    func configureScrollView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
    }
    
    func configHeader() {
        containerView.addSubview(header)
        header.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 330)
        header.delegate = self
    }
    
    func configureComicsCollectionsView() {
        containerView.addSubview(comicsCollectionsView)
        comicsCollectionsView.delegate = self
        comicsCollectionsView.anchor(top: header.bottomAnchor, paddingTop: 0, width: containerView.frame.width, height: 300)
    }
    
    func configureEventsCollectionsView() {
        containerView.addSubview(eventsCollectionsView)
        eventsCollectionsView.delegate = self
        eventsCollectionsView.anchor(top: comicsCollectionsView.bottomAnchor, paddingTop: 0, width: containerView.frame.width, height: 250)
    }
    
    func configureSeriesCollectionsView() {
        containerView.addSubview(seriesCollectionsView)
        seriesCollectionsView.delegate = self
        seriesCollectionsView.anchor(top: eventsCollectionsView.bottomAnchor, paddingTop: 20, width: containerView.frame.width, height: 250)
    }
    
    func fetchCharacterData() {
        guard let id = character?.id else { return }
        comicsCollectionsView.configureView(id: id, type: .comics)
        eventsCollectionsView.configureView(id: id, type: .events)
        seriesCollectionsView.configureView(id: id, type: .series)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
}

extension CharacterViewController: CharacterHeaderDelegate {
    func dismiss() {
        impact(style: .soft)
        self.dismiss(animated: true, completion: nil)
    }
}

extension CharacterViewController: ComicsCollectionViewDelegate, EventsCollectionViewDelegate, SeriesCollectionViewDelegate {
    func showError(message: String) {
        presentMessageView(title: "Alert", message: message)
    }
}

/*
 private var subTitle       : UILabel = {
     let label            = UILabel()
     label.textColor      = .black
     label.font           = UIFont.boldSystemFont(ofSize: 25)
     label.textAlignment  = .left
     
     label.text           = "Marvel Characters"
     
     return label
 }()
 */
