//
//  ErrorView.swift
//  FoodOrders
//
//  Created by Jesús  Fortuna on 21/06/2020.
//  Copyright © 2020 Jesús  Fortuna. All rights reserved.
//

import SwiftUI

struct ErrorView : View {
    
    @State var color = Color.black.opacity(0.7)
    @Binding var alert : Bool
    @Binding var error : String
    var body : some View{
        
        GeometryReader{
            _ in
            VStack{
                HStack{
                    Text(self.error == "RESET" ? "Mensaje" : "Error")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                    
                    Spacer()
                }
                .padding(.horizontal, 35)
                
                Text(self.error == "RESET" ? "La contraseña ha sido enviada correctamente" : self.error)
                    .foregroundColor(self.color)
                    .padding(.top)
                
                Button(action: {
                    self.alert.toggle()
                }){
                    Text(self.error == "RESET" ? "Aceptar" : "Cancelar")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: screen.width - 120)
                }
                .background(Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)))
                .cornerRadius(10)
                .padding(.top, 25)
                .padding(.horizontal, 25)
                
            }
            .padding(.vertical, 25)
            .frame(width: screen.width - 70)
            .background(Color.white)
            .cornerRadius(15)
            
        }
        .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
    }
}



struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(alert: .constant(false), error: .constant("asd"))
    }
}
