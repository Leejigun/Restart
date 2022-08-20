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
            
            Spacer()
            
            // MARK: - Header
            ZStack {
                CircleGroupView(shapeColor: .gray, shapeOpacity: 0.1)
                
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                .padding()
            } //: Header
            
            // MARK: - Center
            Text("The time that leads to mastery is dependent on the intensity of our focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            // MARK: - Footer
            Button(action: {
                isActiveOnboarding = true
            }) {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .padding()
            
        } //: VStack
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
