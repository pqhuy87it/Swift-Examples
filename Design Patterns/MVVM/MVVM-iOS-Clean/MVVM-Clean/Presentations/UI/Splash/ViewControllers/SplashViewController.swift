//
//  SplashViewController.swift
//  MVVM-Clean
//
//  Created by Alessandro Marcon on 04/08/2020.
//  Copyright © 2020 Alessandro Marcon. All rights reserved.
//

import UIKit
import Combine

class SplashViewController: UIViewController {
    
    @IBOutlet var welcomeMessage: UILabel!
    
    var subscriptions: Set<AnyCancellable> = .init()
    var splashViewModel: SplashScreenViewModelDelegate?
    var router: SplashRouterInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        localizeUI()
        bind()
        
        // Add 0.5 second in case we would like to show some graphic content for few seconds.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.splashViewModel?.checkUserState()
        }
    }
    
    /// Prepare all label with current localization.
    private func localizeUI() {
        let localizedWelcomeLabel = NSLocalizedString("splash_message", comment: "")
        welcomeMessage.text = localizedWelcomeLabel
    }
    
    /// <#Description#>
    private func bind() {
        if let viewModel = splashViewModel {
            viewModel.status.sink { state in
                switch viewModel.status.value {
                case .none:
                    print("Nothing to do")
                case .loggedIn:
                    print("Goes to home view")
                    self.goestToHomeViewController()
                case .notLoggedIn:
                    print("Goes to login view")
                    self.goestToLoginViewController()
                }
            }.store(in: &subscriptions)
        }
    }
    
    
    /// Get HomeViewCotroller and set as main window
    private func goestToHomeViewController() {
        router?.navigateToHomeView()
    }
    
    /// Get LoginViewController and set as main window
    private func goestToLoginViewController() {
        router?.navigateToLoginView()
    }
    
}
