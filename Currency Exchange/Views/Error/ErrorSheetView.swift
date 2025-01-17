//
//  ErrorSheetView.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/17/25.
//

import SwiftUI

extension View {
    func errorSheet(isPresented: Binding<Bool>, errorMessage: IdentifiableError?, dismissAction: @escaping () -> Void) -> some View {
        sheet(isPresented: isPresented) {
            VStack {
                Text(Constants.ErrorSheet.title)
                    .font(.title2)
                    .bold()
                Text(errorMessage?.message ?? Constants.ErrorSheet.unknownErrorMessage)
                    .multilineTextAlignment(.center)
                    .padding()
                Button(action: dismissAction) {
                    Text(Constants.ErrorSheet.dismissButtonTitle)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
            .presentationDetents([.fraction(0.4), .medium])
        }
    }
}
