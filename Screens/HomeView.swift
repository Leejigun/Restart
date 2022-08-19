//
//  HomeView.swift
//  Restart
//
//  Created by bimo.ez on 2022/08/20.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage(AppStorageIdentifier.onboarding.rawValue) private var isActiveOnboarding: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Home")
                .font(.largeTitle)
            
            Button(action: {
                isActiveOnboarding = true
            }) {
                Text("Restart")
            }
        } //: VStack
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
