//
//  ChallengItemView.swift
//  Increment
//
//  Created by Kul Boonanake on 18/5/23.
//

import SwiftUI

struct ChallegeItemView: View {
    private let viewModel: ChallengeItemViewModel
    init(viewModel: ChallengeItemViewModel) {
        self.viewModel = viewModel
    }
    
    var titleRow: some View {
        HStack {
            Text(viewModel.title)
                .font(.system(size: 24, weight: .bold))
            Spacer()
            Image(systemName: "trash").onTapGesture {
                viewModel.tappedDelete()
            }
        }
    }
    
    var dailyIncreaseRow: some View {
        HStack {
            Text(viewModel.dailyIncreaseText)
                .font(.system(size: 24, weight: .bold))
            Spacer()
        }
    }
    
    var todayView: some View {
        VStack {
            Divider()
            Text("Today")
                .font(.title3)
                .fontWeight(.medium)
            Text("1 pullup")
                .font(.system(size: 24, weight: .bold))
            Button("Mark Done") {
                
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .font(Font.caption.weight(.semibold))
            .background(Color.primaryButton)
            .cornerRadius(8)
        }
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 25) {
                titleRow
                ProgressCircleView(
                    viewModel: viewModel.progressCircleViewModel
                )
                dailyIncreaseRow
                todayView
            }.padding(.vertical, 10)
            Spacer()
        }
        .background(
            Rectangle()
                .fill(Color.primaryButton)
                .cornerRadius(5)
        )
    }
    
}
