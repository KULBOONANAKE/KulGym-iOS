//
//  LoginSignupView.swift
//  Increment
//
//  Created by Kul Boonanake on 18/5/23.
//

import SwiftUI

struct LoginSignupView: View {
    @ObservedObject var viewModel: LoginSignupViewModel
    
    var isSignInButtonDisabled: Bool {
        [viewModel.emailText, viewModel.passwordText].contains(where: \.isEmpty)
    }
    
    var emailTextField: some View {
        TextField("Email", text: $viewModel.emailText)
            .padding(10)
            .foregroundColor(.white)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.blue, lineWidth: 2)
            }
            .padding(.horizontal)
    }
    
    var passwordTextField: some View {
        SecureField("Password", text: $viewModel.passwordText)
            .padding(10)
            .foregroundColor(.white)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.red, lineWidth: 2)
            }
            .padding(.horizontal)
    }
    
    var actionButton: some View {
        Button(viewModel.buttonTitle) {
            // action
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
        .background(
            isSignInButtonDisabled ?
            LinearGradient(colors: [.gray], startPoint: .topLeading, endPoint: .bottomTrailing) :
                LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(20)
        .disabled(isSignInButtonDisabled)
        .padding(.horizontal)
    }
    
    var body: some View {
        VStack {
            Text(viewModel.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(viewModel.subTitle)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color(.systemGray2))
            Spacer().frame(height: 50)
            emailTextField
            passwordTextField
            actionButton
            Spacer()
        }
    }
}

struct Previews_LoginSignupView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginSignupView(viewModel: .init(mode: .login))
        }.environment(\.colorScheme, .dark)
    }
}
