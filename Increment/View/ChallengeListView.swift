//
//  ChallengeListView.swift
//  Increment
//
//  Created by Kul Boonanake on 17/5/23.
//

import SwiftUI

struct ChallegeListView: View {
    @StateObject private var viewModel = ChallengeListViewModel()
    @State private var isActive = false
    var body: some View {
        ScrollView {
            VStack{
                LazyVGrid(columns: [.init(.flexible()), .init(.flexible())]) {
                    ForEach(viewModel.itemViewModels, id: \.self) { viewModel in
                        ChallegeItemView(viewModel: viewModel)
                    }
                }
                Spacer()
            }
        

        }.navigationTitle(viewModel.title)
    }
}

struct ChallegeItemView: View {
    private let viewModel: ChallengeItemViewModel
    init(viewModel: ChallengeItemViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(viewModel.title)
                    .font(.system(size: 24, weight: .bold))
                Text(viewModel.statusText)
                Text(viewModel.dailyIncreaseText)
            }.padding()
            Spacer()
        }
        .background(
            Rectangle()
                .fill(Color.primaryButton)
                .cornerRadius(5)
        ).padding()
    }
    
}
