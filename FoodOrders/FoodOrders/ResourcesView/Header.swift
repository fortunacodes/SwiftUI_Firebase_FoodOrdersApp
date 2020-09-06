//
//  Header.swift
//  FoodOrders
//
//  Created by Jesús  Fortuna on 30/05/2020.
//  Copyright © 2020 Jesús  Fortuna. All rights reserved.
//

import SwiftUI




struct Header: View {
    @Binding var showCart : Bool
    @Binding var showProfile : Bool
    var body: some View {
        ZStack {
            HStack (alignment: .bottom){
                
                
                ZStack {
                    // Boton izquierda (Account)
                    NeumorphismRectangle(width: 47,height: 42)
                    NeumorphismRectangleWithGradients(width: 47,height: 42)
                    
                    Image("Curly")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                    
                }
                .onTapGesture {
                    self.showProfile.toggle()
                }
                
                
                Spacer()

                ZStack(alignment: .bottom) {
                    
                    NeumorphismRectangle(width: 47,height: 120)
                    
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [ Color(#colorLiteral(red: 0.9921568627, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.9137254902, green: 0.937254902, blue: 0.9411764706, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                    )
                        .frame(width: 47, height: 120)
                        .cornerRadius(8)
                        .shadow(color: Color("shadow1"), radius: 5, x: -5, y: -5)
                        .shadow(color: Color("shadow2"), radius: 5, x: 5, y: 5)
                    
                    Image(systemName: "cart")
                    .resizable()
                        .frame(width: 18, height: 16)
                        .foregroundColor(Color(#colorLiteral(red: 0.6862745098, green: 0.06666666667, blue: 0.06666666667, alpha: 1)))
                        .padding()
                        .shadow(radius: 6)
                    
                }
                .onTapGesture {
                    self.showCart.toggle()
                }
                
            }
            .padding(.horizontal, 20)            
        }
        
    }
}


struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(showCart: .constant(false), showProfile: .constant(false))
    }
}
