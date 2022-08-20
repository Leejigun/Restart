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
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: Double = 0
    
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var title: String = "Share."
    
    /// if true, start animation
    @State var isAnimation: Bool = false
    
    private let hapticFeedback = UINotificationFeedbackGenerator()
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 20) {
                
                // MARK: - Header
                VStack(spacing: 0) {
                    Text(title)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(title)
                    
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
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimation ? 1 : 0)
                        .animation(.easeOut(duration: 1), value: isAnimation)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width) / 20))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if abs(gesture.translation.width) <= 150 {
                                        imageOffset = gesture.translation
                                    }
                                    
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 0
                                        title = "Give."
                                    }
                                }
                                .onEnded { _ in
                                    imageOffset = .zero
                                    
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1
                                        title = "Share."
                                    }
                                }
                        )//: Gesture
                        .animation(.easeOut(duration: 1), value: imageOffset)
                } //: Center
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(isAnimation ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimation)
                        .opacity(indicatorOpacity)
                    , alignment: .bottom
                )
                
                
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
                                            AudioPlayer.shared.playSound(sound: .chimeup)
                                            hapticFeedback.notificationOccurred(.success)
                                            buttonOffset = buttonWidth - 80
                                            isActiveOnboarding = false
                                        } else {
                                            hapticFeedback.notificationOccurred(.warning)
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
        .preferredColorScheme(.dark) // fixed dark mode
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnboardingView()
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
    }
}
