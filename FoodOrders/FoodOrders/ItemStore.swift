//
//  ItemStore.swift
//  FoodOrders
//
//  Created by Jesús  Fortuna on 30/05/2020.
//  Copyright © 2020 Jesús  Fortuna. All rights reserved.
//

import SwiftUI

struct ItemStore: View {
    var store : store
    var body: some View {
            VStack(alignment: .leading, spacing: 16.0) {
                Image(store.pic)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .frame(width : 300, height: 170)
                .cornerRadius(10)
                .shadow(radius: 10)
                
                VStack(alignment: .leading, spacing: 5.0) {
                Text(store.name)
                    .foregroundColor(.black)
                    .font(.headline)
                
                Text(store.timepreparation)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.gray)
                .lineLimit(2)
                    .frame(height: 40)
                }
            }
        }
}

//struct ItemStore_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemStore()
//    }
//}
