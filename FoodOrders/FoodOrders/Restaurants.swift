//
//  Restaurants.swift
//  FoodOrders
//
//  Created by Jesús  Fortuna on 26/05/2020.
//  Copyright © 2020 Jesús  Fortuna. All rights reserved.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct Restaurants: View {
    
    @ObservedObject var restaurants = getRestaurantsData()
    var body: some View {
        VStack{
                        if self.restaurants.datas.count != 0{
                            ScrollView(.vertical, showsIndicators: false){
                                VStack(spacing: 15){
                                    Spacer()
//                                    ForEach(self.restaurants.datas){ i in
//                                        CellView(data: i)
//                                    }
            
                                }
                            }
                        }
                        else {
                            Loader()
                        }
            
            

            
            
//            VStack {
//
//                HStack {
//                    Text("Populares")
//                        .font(.system(size: 20, weight: .regular, design: .default))
//                        .shadow(radius: 6)
//
//                    Spacer()
//                }
//                .padding(.leading,20)
//
//                if self.restaurants.datas.count != 0 {
//                    ScrollView(.horizontal, showsIndicators: false){
//                        HStack (spacing: 20) {
//                            ForEach (self.restaurants.datas) {
//                                i in
//
//                                VStack {
//                                    ZStack {
//
//                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
//                                            .foregroundColor(Color("shadow1"))
//                                            .blur(radius: 4)
//                                            .offset(x: -3, y: -5)
//                                            .frame(width : 185, height: 313)
//
//                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
//                                            .foregroundColor(Color("shadow2"))
//                                            .blur(radius: 4)
//                                            .offset(x: 3, y: 5)
//                                            .frame(width : 185, height: 313)
//                                            .blur(radius: 5)
//
//                                        AnimatedImage(url: URL(string: i.pic))
//                                            .resizable()
//                                            .frame(width : 185, height: 313)
//                                            .cornerRadius(8)
//
//                                    }
//
//                                    Text(i.name)
//                                        .font(.system(size: 16, weight: .semibold, design: .default))
//                                        .shadow(radius: 6)
//                                }
//                            }
//                        }
//                        .padding(.leading, 20)
//
//                    }
//                }
//                else{
//                    Loader()
//                }
//
//            }
            
        }
    }
}

//struct CellView : View{
//    var data : store
//
//    @State var show = false
//    var body : some View{
//        VStack{
//            VStack{
//                AnimatedImage(url: URL(string: data.pic))
//                    .resizable()
//                    .frame(height: 270)
//
//                Text("\(data.name)")
//
//                Button(action: {
//                    self.show.toggle()
//                }){
//                    Image(systemName: "arrow.right")
//                        .font(.body)
//                        .foregroundColor(.black)
//                        .padding(14)
//                }
//                .background(Color.yellow)
//                .clipShape(Circle())
//            }
//            .background(Color.white)
//            .cornerRadius(20)
//            .sheet(isPresented: self.$show){
//                OrderView(data: self.data)
//            }
//
//        }
//    }
//}

struct Restaurants_Previews: PreviewProvider {
    static var previews: some View {
        Restaurants()
    }
}


class getRestaurantsData : ObservableObject{
    @Published var datas = [restaurant]()
    
    init (){
        let db = Firestore.firestore()
        
        db.collection("restaurants").addSnapshotListener{
            (snap,err) in
            
            if (err != nil){
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documentChanges{
                let id = i.document.documentID
                let name = i.document.get("name") as! String
                let category = i.document.get("category") as! String
                let stars = i.document.get("stars") as? String
                let timepreparation = i.document.get("timepreparation") as? String
                let pic = i.document.get("pic") as? String
                let direction = i.document.get("direction") as? String
                let googledirection = i.document.get("googledirection") as? String
                
                
                self.datas.append(restaurant(id: id, name: name, category: category, stars: stars ?? "", timepreparation: timepreparation ?? "", pic : pic ?? "",direction: direction ?? "", googledirection:  googledirection ?? "" ))
                
            }
        }
    }
}

struct restaurant : Identifiable{
    var id : String
    var name : String
    var category : String
    var stars : String
    var timepreparation: String
    var pic: String
    var direction : String
    var googledirection : String
}



























//
//
//
//struct OrderView : View{
//    
//    var data : store
//    @State var cash = false
//    @State var quick = false
//    @State var quantity = 1
//    @Environment(\.presentationMode) var presentation
//    
//    var body : some View{
//        VStack(alignment: .leading, spacing: 15){
//            AnimatedImage(url: URL(string: data.pic) ?? URL( string : "https://picsum.photos/200/300"))
//                .resizable()
//                .frame(height: UIScreen.main.bounds.height / 2 - 100)
//            
//            VStack {
//                Text(data.name)
//                    .fontWeight(.heavy)
//                    .font(.title)
//                
//                Text(data.timepreparation)
//                
//                Toggle(isOn : $cash){
//                    Text("Pagar en la entrega")
//                }
//                
//                Toggle(isOn : $quick){
//                    Text("Entrega rapida")
//                }
//                
//                Stepper(onIncrement: {
//                    self.quantity += 1
//                },
//                        onDecrement: {
//                            if self.quantity != 1 {
//                                self.quantity -= 1
//                            }
//                            
//                }, label: {
//                    Text("Cantidad \(self.quantity)")
//                })
//                
//                Button(action: {
//                    let db = Firestore.firestore()
//                    db.collection("cart").document()
//                        .setData(
//                            [
//                                "item" : self.data.name,
//                                "quantity" : self.quantity,
//                                "quickdelivery" : self.quick
//                            ]
//                            )
//                        {
//                            (err) in
//                            
//                            if err != nil{
//                                print ((err?.localizedDescription)!)
//                                return
//                            }
//                            
//                            self.presentation.wrappedValue.dismiss()
//                            
//                    }
//                    
//                    
//                }, label: {
//                    Text("Agregar al carro")
//                        .padding(.vertical)
//                    
//                })
//                    .background(Color.orange)
//                    .foregroundColor(.white)
//                    .cornerRadius(20)
//                
//            }.padding()
//            
//        }
//    }
//    
//}


struct CartViewFirst : View{
    
    @ObservedObject var cartdata = getCartDatas()
    var body : some View{
        VStack{
            
            Text(self.cartdata.datas.count != 0 ? "Tus articulos en el carro" : "No hay articulos en el carro")
                .padding()
            
            
            if self.cartdata.datas.count != 0{
                List(self.cartdata.datas){
                    i in
                    
                    HStack(spacing: 15){
                        AnimatedImage(url: URL(string: i.pic))
                            .resizable()
                            .frame(width: 55, height: 55)
                        
                        
                        VStack (alignment: .leading){
                            Text(i.name)
                            Text("\(i.quantity)")
                        }
                        
                    }
                    
                }
            }
        }.frame(width: UIScreen.main.bounds.width
            - 110, height:  UIScreen.main.bounds.height - 350  )
    }
}

class getCartDatas : ObservableObject{
    @Published var datas = [cart]()
    
    init (){
        let db = Firestore.firestore()
        
        db.collection("cart").getDocuments{
            (snap,err) in
            
            if err != nil{
                print ((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documents{
                let id = i.documentID
                let name = i.get("item") as! String
                let quantity = i.get("quantity") as! NSNumber
                let pic = i.get("pic") as? String
                
                self.datas.append(cart(id: id, name: name, quantity: quantity, pic: pic ?? ""))
            }
            
            
        }
        
    }
    
}

struct cart : Identifiable{
    var id : String
    var name : String
    var quantity : NSNumber
    var pic : String
    
    
}
