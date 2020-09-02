//
//  StoreView.swift
//  FoodOrders
//
//  Created by Jesús  Fortuna on 29/05/2020.
//  Copyright © 2020 Jesús  Fortuna. All rights reserved.
//
import SwiftUI
import SDWebImageSwiftUI

struct StoreView: View {    
       var data : store
       @Environment(\.presentationMode) var presentationMode
       @ObservedObject var product = getProductsStore()

       var body: some View {

           VStack{
                   
            AnimatedImage(url: URL(string: data.pic))
                       .resizable()
                       .aspectRatio(0.9, contentMode: .fill)
                       .cornerRadius(20)
                       .frame(width: screen.width, height: screen.height / 2 - 50)
                       .shadow(radius: 10)
            
            
                RectangleWithData(data: data)
            
                
                if self.product.datas.count != 0 {
                    ProductRow(product: product.datas, nameCategory: data.product_type, codeStore: data.id)
                }
            
                

               Spacer()
               
           }

           .background(Color("backgroundcolor"))
       }
}

//struct StoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoreView(data: getStoreData())
//    }
//}




struct StoreRows: View {
    var store : [store]
    var categoryTitle : String
    @State var showStore = false
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryTitle)
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .foregroundColor(.black)
                .shadow(radius: 10)
                .padding(.horizontal,20)
            
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack (spacing: 20) {
                    ForEach (self.store) {
                        i in
                        ItemStore(data: i)

                    }
                }
                .padding(.horizontal,20)
                
            }
            Spacer()
        }
    }
}



struct ItemStore: View {
    var data : store
    @State var show = false
    var body: some View {
        
        
            VStack {
                ZStack {
                    
                    NeumorphismRectangle(width: 185 ,height: 313)
                    
                    AnimatedImage(url: URL(string: self.data.pic))
                        .resizable()
                        .frame(width : 185, height: 313)
                        .cornerRadius(8)
                    
                }
                
                
                Text(self.data.name)
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundColor(Color.black)
                    .shadow(radius: 6)
            }
            .onTapGesture {
                self.show.toggle()
            }
            .sheet(isPresented: self.$show){
                StoreView(data: self.data)
                    .edgesIgnoringSafeArea(.all)
            }
            

        
     
    }
}


