//
//  OnboardingView.swift
//  Restart
//
//  Created by bimo.ez on 2022/08/20.
//

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage(AppStorageIdentifier.onboarding.rawValue) private var isActiveOnboarding: Bool = true
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Onboarding")
                .font(.largeTitle)
            
            Button(action: {
                isActiveOnboarding = false
            }) {
                Text("Start")
            }
        } //: VStack
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
