//
//  ContainerController.swift
//  mobile-test
//
//  Created by Bryan Caro on 5/7/21.
//

import UIKit
import RevealingSplashView

class ContainerController: UIViewController {
    //  MARK: - PROPERTIES
    private let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "splash")!,iconInitialSize: CGSize(width: 70, height: 70), backgroundColor: UIColor.red)
    private let homeController = HomeViewController()
    
    
    //  MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        splashView()
    }
    
    //  MARK: - HELPER FUNCTIONS
    func splashView() {
        revealingSplashView.animationType = SplashAnimationType.heartBeat
        self.revealingSplashView.heartAttack = true
        view.addSubview(revealingSplashView)
        
        revealingSplashView.startAnimation {
            self.configure()
        }
    }
    
    func configure() {
        addChild(homeController)
        homeController.didMove(toParent: self)
        view.addSubview(homeController.view)
    }
}
