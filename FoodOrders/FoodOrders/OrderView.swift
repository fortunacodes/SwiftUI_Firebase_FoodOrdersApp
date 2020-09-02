//
//  OrderView.swift
//  FoodOrders
//
//  Created by Jesús  Fortuna on 14/06/2020.
//  Copyright © 2020 Jesús  Fortuna. All rights reserved.
//

import SwiftUI
import Lottie

struct OrderView: View {
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 20) {
                Text("Tu pedido está siendo preparado")
                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                
                //Animation
                HStack {
                    Spacer()
                    AnimationsViews()
                        .scaleEffect(0.6)
                        .scaledToFit()
                    Spacer()
                }
                .frame(width: screen.width - 50 ,height: 150)
                //Repartidor asignado
                VStack (alignment: .center){
                    HStack {
                        Text("El repartidor asignado es")
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .shadow(radius: 3)
                        
                        Spacer()
                    }
                    HStack {
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0.2)]), startPoint: .leading, endPoint: .trailing)
                            .frame(width: 100, height: 4)
                            .cornerRadius(8)
                            .offset(y: -5)
                        
                        Spacer()
                    }
                    Text("Jesús Fortuna")
                        .font(.system(size: 18, weight: .light, design: .rounded))
                        .padding(.top, 10)
                    Text("Matricula: Y21240MFL")
                        .font(.system(size: 18, weight: .light, design: .rounded))
                        .padding(.top, 10)
                    
                    Image("uiface")
                          .resizable()
                          .clipShape(Circle())
                        .frame(width: 146, height: 146, alignment: .center)
                          .shadow(radius: 10)
    //                      .overlay(Circle().stroke(Color.red, lineWidth: 5))
                }
                
                //Restaurant
                VStack (alignment: .leading){
                    
                    HStack {
                        Text("Restaurant")
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .shadow(radius: 3)
                        
                        Spacer()
                    }
                    HStack {
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0.2)]), startPoint: .leading, endPoint: .trailing)
                            .frame(width: 100, height: 4)
                            .cornerRadius(8)
                            .offset(y: -5)
                        
                        Spacer()
                    }
                    Text("Distancia a tú casa: 1.2 KM")
                        .font(.system(size: 18, weight: .light, design: .rounded))
                        .padding(.top, 10)
                    
                    Text("Monto a pagar: 36.00 $")
                        .font(.system(size: 18, weight: .light, design: .rounded))
                        .padding(.top, 10)
                }
                
                
            }
            .padding(.horizontal, 20)
        }
        
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OrderView()
            OrderView()
        }
    }
}

struct AnimationsViews : UIViewRepresentable {

    func makeUIView(context: UIViewRepresentableContext<AnimationsViews> ) -> AnimationView {
        let anyView = AnimationView()
        let animation = Animation.named("6519-cooking", subdirectory: "TestAnimations")
        anyView.animation = animation
        anyView.loopMode = .repeat(10.0)
        anyView.play()
        return anyView
    }
    
    func updateUIView(_ uiView: AnimationView, context: UIViewRepresentableContext<AnimationsViews>) {

    }
}
