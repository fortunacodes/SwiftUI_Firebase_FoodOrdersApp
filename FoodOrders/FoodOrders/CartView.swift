//
//  CartView.swift
//  FoodOrders
//
//  Created by Jesús  Fortuna on 10/06/2020.
//  Copyright © 2020 Jesús  Fortuna. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct CartView: View {
    @ObservedObject var cartData = getCartData()
    @ObservedObject var userData = getUserData()
    @ObservedObject var activeUser = getActiveUser()
    @ObservedObject var storeData = getStoreDataAlone()
    @ObservedObject var rider = getRiderAvailable()
    @State var showProfileDetails = false
    @State var showOrder = false
    
    @State var codeStore = ""
    
    
    @Environment(\.presentationMode) var presentationMode
    @State var phone = ""
    @State var location = ""
    @State var showProfileOpened = false
    
    
    var body: some View {
        
        
        
        VStack  {
            //Tus datos y Tu cesta
            ZStack {
                if !showOrder {
                    Text(showProfileDetails ? "Tus datos" : "Tu cesta")
                        .font(.subheadline)
                        .shadow(radius: 3)
                }
                else{
                    Text("Tu pedido")
                        .font(.subheadline)
                        .shadow(radius: 3)
                    
                }
                HStack{
                    Text("X")
                        .onTapGesture{
                            if self.showProfileDetails{
                                self.showProfileDetails.toggle()
                            }
                            else{
                                self.presentationMode.wrappedValue.dismiss()
                            }
                    }
                    Spacer()
                    
                }
            } 
            .padding(.horizontal, 20)
            .padding(.bottom, 20)

            ZStack (alignment: .top) {
                
                VStack (spacing: 20) {
                    
                    
                    
                    //Barra Mis Datos
                    VStack {
                        HStack {
                            Text("Mis datos")
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
                        
                        VStack {
                            
                            HStack{
//                                if  self.userData.userDataAlone.street == "" {
//                                    CartDataRows(ImageName: "mappin.and.ellipse", quantity: "", description: "Dejanos tu ubicación")
//
//                                }else{
                                    CartDataRows(ImageName: "mappin.and.ellipse", quantity: "",
                                                 description: self.phone == "" ? "Dejanos tu ubicación" : self.phone )
//                                }
                                Spacer()
                                Image(systemName: "pencil")

                            }
                            HStack{
//                                if self.userData.userDataAlone.mov1 == "" {
//                                CartDataRows(ImageName: "phone.fill", quantity: "", description: "Dejanos donde llamarte")
//                            }else{
//                                CartDataRows(ImageName: "phone.fill", quantity: "",
//                                             description: self.userData.userDataAlone.mov1)
//                            }
                                  CartDataRows(ImageName: "phone.fill", quantity: "",
                                               description: self.location == "" ? "Dejanos donde llamarte" : self.location)
                                Image(systemName: "pencil")

                            }
                        }

                    }
                    .onTapGesture {
                        self.showProfileOpened = true
                        self.showProfileDetails.toggle()
                        self.phone = self.userData.userDataAlone.mov1
                        self.location = self.userData.userDataAlone.street
                    }
                    //Barra Tiempo estimado
                    VStack {
                        HStack {
                            Text("Tiempo estimado")
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
                        
                        VStack {
                            CartDataRows(ImageName: "timer", quantity: "", description: "\(self.storeData.storeDataAlone?.timepreparation ?? "30") min")
                        }
                    }
                    
                    //Listado productos
                    VStack {
                        HStack {
                            Text("Pedido")
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
                        
                        //Here is the list of the car
                        VStack {
                            
                            if self.cartData.datas.count != 0{
                                VStack {
                                    List{
                                        
                                        ForEach (self.cartData.datas) {
                                            i in
                                            CartDataRows(ImageName: "", quantity: i.quantity.stringValue, description: i.name)
                                        }
                                        .onDelete{
                                            (index) in
                                            
                                            let db = Firestore.firestore()
                                            db.collection("cart").document(
                                                self.cartData.datas[index.last!].id
                                            ).delete{
                                                (err) in
                                                
                                                if err != nil{
                                                    print((err?.localizedDescription)!)
                                                    return
                                                }
                                                self.cartData.sum  = self.cartData.sum - Double(truncating: self.cartData.datas[index.last!].price)
                                                self.cartData.datas.remove(atOffsets: index)
                                                self.cartData.cartList.remove(atOffsets: index)
                                                
                                            }
                                        }
                                    }
                                }
                                .onAppear{
                                    self.codeStore = self.cartData.codStore
                                    
                                }
                                
                                // Boton de Pedir
                                ZStack {
                                    NeumorphismRectangle(width: screen.width/2 + 100, height: 100)
                                    
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                        .blur(radius: 1)
                                        .frame(width: screen.width/2 + 100, height: 100)
                                    
                                    HStack (alignment: .center, spacing: 30){
                                        
                                        HStack {
                                            Text("\(String(format:"%3.2f", cartData.sum))")
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
                                                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.1),Color(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                                .frame(width: 120, height: 40)
                                            
                                            HStack{
                                                Text("PEDIR")
                                                Image(systemName: "doc.text.fill")
                                            }
                                            .foregroundColor(.white)
                                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                                            .shadow(radius: 7)
                                            
                                        }
                                    }
                                }
                                .onTapGesture {
                                    let stringRepresentation = self.cartData.cartList.joined(separator:"-")
                                    
                                    let db = Firestore.firestore()
                                    

                                    
                                    
                                    db.collection("orders")
                                        .document()
                                        .setData(
                                            [
                                                "directionCostumer" : self.userData.userDataAlone.street + ", " + self.userData.userDataAlone.door,
                                                "directionStore" : self.storeData.storeDataAlone.direction,
                                                "phoneRider" : "",
                                                "phoneCostumer" : self.userData.userDataAlone.mov1,
                                                "phoneRest" : self.storeData.storeDataAlone.phone,
                                                "noteStore" : self.userData.userDataAlone.noteRest,
                                                "noteRider" : self.userData.userDataAlone.noteRider,
                                                "storeID" : self.storeData.storeDataAlone.codeStore,
                                                "userID"  : self.activeUser.activeUserID,
                                                "RiderID" : "",
                                                "orderNumber": "#"+String(Int.random(in: 0 ... 9999)),
                                                "orderList" : stringRepresentation,
                                                "amount" : self.cartData.sum,
                                                "finished" : false
                                            ]
                                            )
                                        {
                                            (err) in
                                            if err != nil{
                                                print((err?.localizedDescription)!)
                                                return
                                            }
                                            
                                    }
                                    
                                    
                                    
                                    deleteCartData(activeUserID: self.activeUser.activeUserID)
                                    self.cartData.cartList.removeAll()
                                    self.showOrder.toggle()
                                    
                                }
                                
                            }
                            else{
                                Image("onlineShopping")
                                    .resizable()
                                    .scaledToFit()
                                    .scaleEffect(0.8)
                                    
                                Text( "No hay articulos en el carro")
                                    .padding()
                                    .foregroundColor(Color.red)
                            }
                        }
                        
                    }
                    
                    
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                
                
                if showProfileDetails{
                    Color(.white)
                    
                    ScrollView {
                        VStack (spacing: 20) {
                            
                            ProfileDetails(
                                name: userData.userDataAlone.name,
                                street: self.$location,
                                door: userData.userDataAlone.door,
                                mov1: self.$phone,
                                mov2: userData.userDataAlone.mov2,
                                noteRest: userData.userDataAlone.noteRest,
                                noteRider: userData.userDataAlone.noteRider,
                                showProfileDetails: self.$showProfileDetails
                            )
                        }
                        .padding(.horizontal, 20)
                                                
                    }
                        
                    .animation(Animation.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0))
                    .transition(.move(edge: .bottom))
                    
                }
                
                
                if showOrder{
                    Color(.white)
                    OrderView()
                }
                
                
            }
            
            
            
        }
        .padding(.top, 20)
                
    }
    
}



struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView ()
    }
}

struct CartDataRows: View {
    var ImageName : String
    var quantity : String
    var description : String
    var body: some View {
        HStack{
            
            ZStack {
                if ImageName == ""
                {
                    HStack (alignment: .center) {
                        Text(quantity)
                            .font(.subheadline)
                            .frame(width: 40, alignment: .leading)
                        
                        
                        Text("X")
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .padding(.trailing, 20)
                        
                    }
                    
                    
                }
                else{
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.9),Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                        .frame(width: 49, height: 43)
                    Image(systemName: ImageName)
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.white)
                }
                
            }
            
            Text(description)
                .font(.system(size: 18, weight: .light, design: .rounded))
                .shadow(radius: 3)
            
            Spacer()
            
        }
    }
}

