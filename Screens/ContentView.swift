//
//  ContentView.swift
//  Restart
//
//  Created by bimo.ez on 2022/08/19.
//

import SwiftUI

enum AppStorageIdentifier: String {
    case onboarding = "onboarding"
}

struct ContentView: View {
    
    @AppStorage(AppStorageIdentifier.onboarding.rawValue) private var isActiveOnboarding: Bool = true
    
    var body: some View {
        if isActiveOnboarding {
            OnboardingView()
        } else {
            HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
