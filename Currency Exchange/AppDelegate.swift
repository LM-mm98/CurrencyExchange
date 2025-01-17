//
//  AppDelegate.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/12/25.
//

import UIKit
import SwiftUI
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let sourceCurrencies = CurrencyData.currencies
        let currencyViewModel = CurrencyViewModel(sourceCurrencies: sourceCurrencies)
        let currencyListView = CurrencyListView(viewModel: currencyViewModel, service: CurrencyService())
        
        configureKeyboardManager()
        setupWindow(with: currencyListView)
        
        return true
    }
    
    private func configureKeyboardManager() {
        let keyboardManager = IQKeyboardManager.shared
        keyboardManager.isEnabled = true
        keyboardManager.resignOnTouchOutside = true
    }
    
    private func setupWindow(with rootView: some View) {
        let hostingController = UIHostingController(rootView: rootView)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = hostingController
        window?.makeKeyAndVisible()
    }
}

