//
//  RectangleWithData.swift
//  FoodOrders
//
//  Created by Jesús  Fortuna on 30/05/2020.
//  Copyright © 2020 Jesús  Fortuna. All rights reserved.
//

import SwiftUI


struct RectangleWithData: View {
    var data : store
    var body: some View {
        ZStack{
            
            
            
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .foregroundColor(Color(.white))
                .frame(width : 300, height: 110)
                .shadow(radius: 8)
            VStack (alignment: .center) {
                
                Text(data.name)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .shadow(radius: 3)
                
                Text(data.direction)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundColor(Color.black.opacity(0.6))
                
                HStack (spacing: 20){
                    VStack{
                        Image(systemName: "timer")
                            .font(.system(size: 18))
                            .foregroundColor(.green)
                            .shadow(radius: 3)
                        
                        Text("\(data.timepreparation) min")
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .shadow(radius: 3)
                        
                    }
                    VStack{
                        Image(systemName: "star.fill")
                            .font(.system(size: 18))
                            .foregroundColor(.yellow)
                            .shadow(radius: 3)
                        
                        Text(data.stars)
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .shadow(radius: 3)
                        
                    }
                }
                .padding(.top, 5)
                
            }
            
        }.offset(y: -50)
    }
}
