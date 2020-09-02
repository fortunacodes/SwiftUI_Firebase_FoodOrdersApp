//
//  ProductsView.swift
//  FoodOrders
//
//  Created by Jesús  Fortuna on 30/05/2020.
//  Copyright © 2020 Jesús  Fortuna. All rights reserved.
//


import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct ProductoView: View {
    @Environment(\.presentationMode) var presentationMode
    var product : product
    @State var quantity = 1
    @State var equalsOne = true
    @ObservedObject var activeUser = getActiveUser()
    @ObservedObject var cart = getCartData()
    @State var price : Double = 0
    @State var alert = false
    var body: some View {
        
        ZStack {
            VStack {
                //            AnimatedImage(url: URL(string: data.pic))
                ScrollView {
                    
                    //                Image(product.pic)
                    AnimatedImage(url: URL(string: product.pic))
                        .resizable()
                        .aspectRatio(1.4, contentMode: .fill)
                        .cornerRadius(20)
                        .frame(width: screen.width, height: screen.height / 3)
                        .shadow(radius: 10)
                        .offset(y: -50)
                    
                    
                    VStack (alignment: .leading, spacing: 20) {
                        
                        VStack {
                            HStack {
                                Text(product.name)
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
                            
                        }
                        
                        Text(product.description)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .multilineTextAlignment(.leading)
                        
                        
                        Text("\(activeUser.activeUserID)")
                        
                        
                    }
                    .padding(.horizontal, 20)
                    
                    HStack{
                        
                        QuantityButtons(text: "-")
                            .blur(radius: equalsOne ? 2 : 0)
                            .onTapGesture {
                                if self.quantity > 1{
                                    self.quantity -= 1
                                    self.price -= self.product.price
                                    if self.quantity == 1{
                                        self.equalsOne = true
                                    }else{
                                        self.equalsOne = false
                                    }
                                    
                                }
                        }
                        
                        Text("\(quantity)")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .shadow(radius: 10)
                            .frame(width: 60)
                        
                        
                        QuantityButtons(text: "+")
                            .onTapGesture {
                                self.quantity += 1
                                self.price += self.product.price
                                print(self.product.price)
                                if self.quantity == 1{
                                    self.equalsOne = true
                                    
                                }else{
                                    self.equalsOne = false
                                }
                        }
                        
                    }.padding(.top, 30)
                }
                
                //Boton de agregar
                ZStack {
                    NeumorphismRectangle(width: screen.width/2 + 100, height: 100)
                    
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        .blur(radius: 1)
                        .frame(width: screen.width/2 + 100, height: 100)
                    
                    HStack (alignment: .center, spacing: 30){
                        
                        HStack {
                            Text("\(String(format:"%3.2f", self.price))")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .frame(width: 90)
                                .offset(x: -5)
                            
                            
                            Text("$")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .offset(x: -5)
                            
                        }
                        
                        ZStack{
                            NeumorphismRectangle(width: 120, height: 40)
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).opacity(0.1),Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                                .frame(width: 120, height: 40)
                            
                            HStack{
                                Text("AGREGAR")
                                Image(systemName: "cart.fill.badge.plus")
                            }
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .shadow(radius: 7)
                            .onTapGesture {
                                let db = Firestore.firestore()
                                
                                print("Que tiene? \(self.cart.codStore)")
                                
                                if self.product.codestore == self.cart.codStore || self.cart.codStore == ""{
                                    db.collection("cart")
                                        .document()
                                        .setData(
                                            [
                                            "item" : self.product.name,
                                             "codeStore" : self.product.codestore,
                                             "quantity" : self.quantity,
                                             "price" : self.price,
                                             "itemID" : self.product.id,
                                             "userID" : self.activeUser.activeUserID
                                            ]
                                            )
                                        {
                                            (err) in
                                            if err != nil{
                                                print((err?.localizedDescription)!)
                                                return
                                            }
                                    }
                                    
                                    self.presentationMode.wrappedValue.dismiss()
                                }else{
                                    self.alert = true
                                }
                                
                                

                            }
                            
                            
                        }
                    }
                    
                }
                .offset(y: -50)
                .onAppear{
                    self.price = self.product.price
                }
                
                
                
                
            }
            if alert{
                NoticeView(alert: self.$alert)
                
            }           

        }
        
        
    }
}

func getPrice(number: Double, quantity: Int) -> Float {
    print(number)
    print(quantity)
    return Float(number * Double(quantity))
}

struct ProductoView_Previews: PreviewProvider {
    static var previews: some View {
        ProductoView( product: product(id: "1", name: "Pizza", pic: "pizza", price: 3, codestore: "ad", description: "das", ingredients: ["",""]))
    }
}


struct ProductRow: View {
    var product : [product]
    var nameCategory : String
    var codeStore : String
    var body: some View {
        VStack {
            
            HStack {
                Text(nameCategory)
                    .font(.system(size: 18, weight: .semibold, design: .default))
                    .shadow(radius: 6)
                
                Spacer()
            }
            .padding(.leading,20)
            
            VStack {
                ScrollView(.vertical, showsIndicators: false){
                    VStack (spacing: 20) {
                        ForEach (self.product) {
                            i in
                            
                            if self.codeStore == i.codestore {
                                
                                ItemProduct(data: i)
                            }
                            
                        }
                    }
                }
            }
        }
    }
}

struct ItemProduct: View {
    var data : product
    @State var show = false
    
    var body: some View {
        HStack (alignment: .top, spacing: 20) {
            ZStack {
                
                NeumorphismRectangle(width: 80, height: 60)
                
                AnimatedImage(url: URL(string: data.pic))
                    .resizable()
                    .frame(width : 80, height: 60)
                    .cornerRadius(8)
                
            }
            
            VStack (alignment: .leading, spacing: 10) {
                Text(data.name)
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .shadow(radius: 6)
                
                Text("\(String(format:"%3.2f", data.price)) $")
                    .font(.system(size: 14, weight: .semibold, design: .default))
                    .shadow(radius: 6)
            }
            .padding(.top, 5)
            
            Spacer()
        }
        .padding(.leading, 20)
        .onTapGesture {
            self.show.toggle()
        }
        .sheet(isPresented: self.$show){
            ProductoView(product: self.data)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
