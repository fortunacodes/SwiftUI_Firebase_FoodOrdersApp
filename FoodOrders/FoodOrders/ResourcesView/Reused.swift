//
//  Reused.swift
//  FoodOrders
//
//  Created by Jesús  Fortuna on 29/05/2020.
//  Copyright © 2020 Jesús  Fortuna. All rights reserved.
//

import SwiftUI

struct Reused: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Reused_Previews: PreviewProvider {
    static var previews: some View {
        Reused()
    }
}


struct NeumorphismRectangle: View {
    var width : CGFloat
    var height : CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .foregroundColor(Color("shadow1"))
                .blur(radius: 4) // Permite dar una sombra mas realissta
                .offset(x: -3, y: -5) // Para que la sombra sea del lado izquierdo puesto que es blanca
                .frame(width: width, height: height)
            
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .foregroundColor(Color("shadow2"))
                .blur(radius: 4)
                .offset(x: 3, y: 5)
                .frame(width: width, height: height)
                .blur(radius: 5)
            
        }
    }
}

struct NeumorphismRectangleWithGradients: View {
    var width : CGFloat
    var height : CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9921568627, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.9137254902, green: 0.937254902, blue: 0.9411764706, alpha: 1))]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
        )
            .frame(width: width, height: height)
            .cornerRadius(8)
            .shadow(color: Color("shadow1"), radius: 5, x: -5, y: -5)
            .shadow(color: Color("shadow2"), radius: 5, x: 5, y: 5)
    }
}



struct QuantityButtons: View {
    var text : String
    var body: some View {
        ZStack{
            NeumorphismRectangle(width: 60, height: 40)
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).opacity(0.1),Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )                       
            
            Text(text)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .shadow(radius: 3)
            
        }
        .frame(width: 60, height: 40, alignment: .center)
            
        .cornerRadius(8)
        .shadow(radius: 2)

    
    }
}

struct QuantityButtons_Previews: PreviewProvider {
static var previews: some View {
    QuantityButtons(text: "-")
}
}
