//
//  ValeriaView.swift
//  FoodOrders
//
//  Created by Jesús  Fortuna on 12/06/2020.
//  Copyright © 2020 Jesús  Fortuna. All rights reserved.
//

import SwiftUI

struct ValeriaView: View {
    @State var monkeyValeriaTouched = false
    var body: some View {
        VStack{
        
                
          
                HStack {

                    
                  
                    Image("banana")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 86, height: 86)
                        .shadow(radius: 10)
                    
                    Text("Banana")
                        .font(.system(.title))
                        .shadow(radius: 10)
                        .padding(.horizontal, 30)
                    
                    Image("piñita")
                                      .resizable()
                                      .scaledToFit()
                                      .frame(width: 86, height: 86)
                                          .shadow(radius: 10)
                                      
                    

                              

                }
                .onTapGesture {
                       self.monkeyValeriaTouched.toggle()
                           }
            
                
                
            Image("monkey")
                        .resizable()
                        .scaledToFit()
       
                
            if monkeyValeriaTouched == false{
                Spacer()

            }
            
            
        }
        .frame(width: screen.width, height: screen.height)
        .background(Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)))
        
    }
}

struct ValeriaView_Previews: PreviewProvider {
    static var previews: some View {
        ValeriaView()
    }
}
