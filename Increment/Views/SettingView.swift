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
            Text(viewModel.itemViewModels[index].title)
        }.onAppear {
            viewModel.onAppear()
        }
    }
}
