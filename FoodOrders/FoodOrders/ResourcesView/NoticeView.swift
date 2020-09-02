//
//  NoticeView.swift
//  FoodOrders
//
//  Created by Jesús  Fortuna on 21/06/2020.
//  Copyright © 2020 Jesús  Fortuna. All rights reserved.
//

import SwiftUI

struct NoticeView: View {
    @Binding var alert : Bool

    var body: some View {
        GeometryReader{
            _ in
            VStack (alignment: .leading, spacing: 10) {
                HStack{
                    Text("Ops!")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                
                Text("Ya tienes articulos de otra tienda en tu bolsa.")
                    .font(.callout)
                
                Button(action: {
                    self.alert.toggle()
                }){
                    Text("Eliminar articulos")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: screen.width - 120)
                }
                .background(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                .cornerRadius(10)
                
                Button(action: {
                    self.alert.toggle()
                }){
                    Text("Cancelar")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: screen.width - 120)
                }
                .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                .cornerRadius(10)
            }
            .padding(.horizontal, 35)
            .padding(.vertical, 25)
            .frame(width: screen.width - 70)
            .background(Color.white)
            .cornerRadius(10)
            
        }
        .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
    }
}

struct NoticeView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeView(alert: .constant(false))
    }
}
