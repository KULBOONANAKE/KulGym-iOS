//
//  SettingView.swift
//  Increment
//
//  Created by Kul Boonanake on 18/5/23.
//

import SwiftUI

struct SettingView: View {
    @StateObject private var viewModel = SettingViewModel()
    var body: some View {
        List(viewModel.itemViewModels.indices, id: \.self) { index in
            Button {
                viewModel.tappedItem(at: index)
            } label: {
                HStack {
                    Image(systemName: viewModel.item(at: index).iconName)
                    Text(viewModel.itemViewModels[index].title)
                }
            }
        }
        .background(
            NavigationLink(
                destination: LoginSignupView(
                    mode: .signup,
                    isPushed: $viewModel.loginSignupPushed
                ),
                isActive: $viewModel.loginSignupPushed){}
            
        )
        .navigationTitle(viewModel.title)
        .onAppear {
            viewModel.onAppear()
        }
    }
}
