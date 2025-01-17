//
//  SummaryView.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/14/25.
//

import SwiftUI

struct SummaryView: View {
    // MARK: - Properties
    let conversionRate: Double
    let sourceAmount: String
    let sourceCurrency: String
    let sourceFlag: String
    let destinationAmount: String
    let destinationCurrency: String
    let destinationFlag: String
    
    @State private var isSharing = false
    @State private var shareImage: UIImage?
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 16) {
            summaryDetailsView
                .padding()
            
            Spacer()
            
            buttonGroupView
                .padding()
        }
        .navigationTitle(Constants.SummaryView.navigationTitle)
        .sheet(isPresented: $isSharing) {
            if let image = shareImage {
                ActivityView(activityItems: [image])
            }
        }
    }
    
    // MARK: - Subviews
    private var summaryDetailsView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(Constants.SummaryView.conversionSummaryTitle)
                .font(.title)
                .bold()
            
            detailRowView(flag: sourceFlag, label: Constants.SummaryView.sourceAmountLabel, value: "\(sourceAmount) \(sourceCurrency)")
            detailRowView(flag: destinationFlag, label: Constants.SummaryView.convertedAmountLabel, value: "\(destinationAmount) \(destinationCurrency)")
            
            Text("\(Constants.SummaryView.exchangeRateLabel) \(sourceCurrency) = \(conversionRate.formatExchangeRate()) \(destinationCurrency)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
    
    private var buttonGroupView: some View {
        HStack {
            actionButton(title: Constants.SummaryView.saveAndShareButton, backgroundColor: .blue, action: saveAndShare)
            actionButton(title: Constants.SummaryView.goToHomeScreenButton, backgroundColor: .green, action: goToHomeScreen)
        }
    }
    
    private func detailRowView(flag: String, label: String, value: String) -> some View {
        HStack {
            Text(flag)
            Text("\(label)\(value)")
                .font(.headline)
        }
    }
    
    private func actionButton(title: String, backgroundColor: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
    
    // MARK: - Actions
    private func saveAndShare() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootView = windowScene.windows.first?.rootViewController?.view else {
            print(Constants.SummaryView.saveAndShareError)
            return
        }
        
        let renderer = UIGraphicsImageRenderer(size: rootView.bounds.size)
        shareImage = renderer.image { _ in
            rootView.drawHierarchy(in: rootView.bounds, afterScreenUpdates: true)
        }
        
        guard let image = shareImage else {
            print(Constants.SummaryView.captureError)
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        if let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(activityController, animated: true, completion: nil)
        }
    }
    
    private func goToHomeScreen() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootWindow = windowScene.windows.first {
            let currencyViewModel = CurrencyViewModel(sourceCurrencies: CurrencyData.currencies)
            
            rootWindow.rootViewController = UIHostingController(
                rootView: CurrencyListView(
                    viewModel: currencyViewModel,
                    service: CurrencyService()
                )
            )
            rootWindow.makeKeyAndVisible()
        }
    }
}


