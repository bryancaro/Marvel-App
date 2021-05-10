//
//  HomeController.swift
//  mobile-test
//
//  Created by Bryan Caro on 5/7/21.
//

import UIKit
import Foundation
import TinyConstraints
import RevealingSplashView
import Combine

class HomeViewController: UIViewController {
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
    private var carouselView             : CarouselCollectionView?
    private let header                   = HomeViewHeader()
    private var charactersCollectionView = CharactersCollectionView()
    
    //  MARK: - PROPERTIES && CONSTANTS
    lazy var contentViewSize = CGSize(width: view.frame.width, height: view.frame.height + 400)
    private let backgroundColors: [UIColor] = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)]
    private var carouselData   = [CarouselCollectionView.CarouselData]()
//    private var charactersData = [Character]()
    
    //  MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        configureUI()
        shouldPresentLoadingView2(true, message: "Loading..")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        carouselView?.configureView(with: carouselData)
        charactersCollectionView.configureView()
    }
    
    //  MARK: - HELPER FUNCTIONS
    func configureUI() {
        configureScrollView()
        configureHeader()
        configureTableView()
    }
    
    func configureScrollView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
    }
    
    func configureHeader() {
        containerView.addSubview(header)
        header.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, width: screen.width, height: 100)
        
        guard let carouselView = carouselView else { return }
        containerView.addSubview(carouselView)
        carouselView.anchor(top: header.bottomAnchor, right: containerView.rightAnchor, paddingTop: 20, paddingRight: 0, width: 400, height: 400)
    }
    
    func configureTableView() {
        containerView.addSubview(charactersCollectionView)
        charactersCollectionView.delegate = self
        charactersCollectionView.anchor(top: carouselView?.bottomAnchor, width: containerView.frame.width, height: 250)
    }
    
    func fetchData() {
        fetchCarouselData()
    }
    
    func fetchCarouselData() {
        carouselView = CarouselCollectionView(pages: 3, delegate: self)
        carouselData.append(.init(image: UIImage(named: "IM"), text: "'I am the Iron Man'"))
        carouselData.append(.init(image: UIImage(named: "TH"), text: "'I am the monster parents tell their children about at night'"))
        carouselData.append(.init(image: UIImage(named: "BB"), text: "'That’s my secret i’m always angry'"))
    }
}

// MARK: - CarouselViewDelegate
extension HomeViewController: CarouselViewDelegate {
    func currentPageDidChange(to page: Int) {
        UIView.animate(withDuration: 0.7) {
            self.view.backgroundColor = self.backgroundColors[page]
        }
    }
}

extension HomeViewController: CharacterDetailsDelegate {
    func characterSelected(with character: Character) {
        impact(style: .soft)
        print(character)
        let rootViewController = CharacterViewController()
        rootViewController.character = character
        let nav = UINavigationController(rootViewController: rootViewController)
        if #available(iOS 13.0, *) {
            nav.isModalInPresentation = true
        }
        nav.modalPresentationStyle = .automatic
        self.present(nav, animated: true, completion: nil)
    }
    
    func success() {
        shouldPresentLoadingView2(false, message: "Loading..")
    }
    
    func showError(message: String) {
        presentMessageView(title: "Alert", message: message)
    }
}
