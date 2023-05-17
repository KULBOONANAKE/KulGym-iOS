//
//  ContentView.swift
//  Increment
//
//  Created by Kul Boonanake on 17/5/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    Spacer().frame(height: proxy.size.height * 0.08)
                    Text("KulGym")
                        .font(.system(size:64, weight: .medium))
                        .foregroundColor(.white)
                    Spacer()
                    NavigationLink(destination:
                                    CreateView(), isActive: $isActive
                    ){
                        Button(action: {
                            isActive = true
                        }) {
                            HStack(spacing: 15) {
                                Spacer()
                                Image(systemName: "plus.circle")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(.white)
                                Text("Create a challenge")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }
                        .padding(15)
                        .buttonStyle(PrimaryButtonStyle())
                    }
                    
                }.frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .background(Image("frog-stand")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(Color.black.opacity(0.1))
                    .frame(width: proxy.size.width)
                    .edgesIgnoringSafeArea(.all)
                )
            }
        }.accentColor(.primary)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
