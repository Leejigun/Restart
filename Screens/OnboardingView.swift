//
//  OnboardingView.swift
//  Restart
//
//  Created by bimo.ez on 2022/08/20.
//

import SwiftUI

struct OnboardingView: View {
    
    // MARK: - Properties
    @AppStorage(AppStorageIdentifier.onboarding.rawValue) private var isActiveOnboarding: Bool = true
    
    @State var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State var buttonOffset: Double = 0
    
    /// if true, start animation
    @State var isAnimation: Bool = false
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 20) {
                
                Spacer()
                
                // MARK: - Header
                VStack(spacing: 0) {
                    Text("Share.")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Text("""
                    It's not how much we give but
                    how much love we put into giving.
                    """)
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(10)
                } //: Header
                .opacity(isAnimation ? 1 : 0)
                .offset(y: isAnimation ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimation)
                
                // MARK: - Center
                ZStack {
                    
                    CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimation ? 1 : 0)
                        .animation(.easeOut(duration: 1), value: isAnimation)
                } //: Center
                
                
                Spacer()
                
                // MARK: - Footer
                ZStack {
                    ZStack {
                        Capsule()
                            .fill(Color.white.opacity(0.2))
                        Capsule()
                            .fill(Color.white.opacity(0.2))
                            .padding(8)
                    } //: background
                    
                    Text("Get Start")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: max(80, buttonOffset + 80), height: 80, alignment: .center)
                        
                        Spacer()
                    }
                    
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80{
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(.easeOut(duration: 0.4)) {
                                        if buttonOffset > buttonWidth / 2 {
                                            buttonOffset = buttonWidth - 80
                                            isActiveOnboarding = false
                                        } else {
                                            buttonOffset = 0
                                        }
                                    }
                                }
                        )//: DragGesture
                        
                        Spacer()
                    } //: Circle Button
                    
                } //: Fotter
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding(8)
                .opacity(isAnimation ? 1 : 0)
                .offset(y: isAnimation ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimation)
                
                
            } //: VStack
        } //: ZStack
        .onAppear {
            isAnimation = true
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnboardingView()
        }
    }
}
