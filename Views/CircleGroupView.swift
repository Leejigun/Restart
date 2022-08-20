//
//  CircleGroupView.swift
//  Restart
//
//  Created by bimo.ez on 2022/08/20.
//

import SwiftUI

struct CircleGroupView: View {
    
    @State var shapeColor: Color
    @State var shapeOpacity: Double
    @State private var isAnimation: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(shapeColor.opacity(shapeOpacity), lineWidth: 40)
                .frame(width: 260, height: 260, alignment: .center)
            
            Circle()
                .stroke(shapeColor.opacity(shapeOpacity), lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
        } //: ZStack
        .blur(radius: isAnimation ? 0 : 10)
        .opacity(isAnimation ? 1 : 0)
        .scaleEffect(isAnimation ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: isAnimation)
        .onAppear {
            isAnimation = true
        }
    }
}

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
        }
    }
}
