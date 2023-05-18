//
//  TabContainerView.swift
//  Increment
//
//  Created by Kul Boonanake on 17/5/23.
//

import SwiftUI

struct TabContainerView: View {
    @StateObject private var tabContainerViewModel = TabContainerViewModel()
    var body: some View {
        TabView(selection: $tabContainerViewModel.selectedTap) {
            ForEach(tabContainerViewModel.tabItemViewModels, id: \.self) { viewModel in
                tabView(for: viewModel.type)
                    .tabItem {
                        Image(systemName: viewModel.imageName)
                        Text(viewModel.title)
                    }.tag(viewModel.type)
            }
        }.accentColor(.primary)
    }
    
    @ViewBuilder
    func tabView(for tabItemType: TabItemViewModel.TabItemType) -> some View {
        switch tabItemType {
        case .challengeList:
            NavigationView {
                ChallegeListView()
            }
        case .settings:
            NavigationView {
                SettingView()
            }
        }
    }
}

final class TabContainerViewModel: ObservableObject {
    @Published var selectedTap: TabItemViewModel.TabItemType = .challengeList
    
    let tabItemViewModels = [
        
        TabItemViewModel(imageName: "list.bullet", title: "Challenge", type: .challengeList),
        .init(imageName: "gear", title: "Setting", type: .settings)
        
    ]
    
}

struct TabItemViewModel: Hashable {
    let imageName: String
    let title: String
    let type: TabItemType
    
    enum TabItemType {
        case challengeList
        case settings
    }
}
