//
//  Home.swift
//  FoodOrders
//
//  Created by Jesús  Fortuna on 26/05/2020.
//  Copyright © 2020 Jesús  Fortuna. All rights reserved.
//


import SwiftUI
import Firebase
import SDWebImageSwiftUI
import Combine
import FirebaseAuth

struct Home: View {
    
    @State var showStore = false
    @ObservedObject var store = getStoreData()
    @State var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? true
    @State var showCart = false
    @State var showProfile = false
    
    @ObservedObject var userData = getUserData()

    var body: some View {
        
        NavigationView{
            ZStack{
                
                if self.status{
                    
                    VStack {
                        Header(showCart: $showCart, showProfile: $showProfile)
                        
                        if self.store.datas.count != 0 {
                            StoreRows(store: store.datas, categoryTitle: "Cerca de ti")
                        }
                        
                    }
                    .offset(y: -50)
                    
                    Button(action: {
                        try! Auth.auth().signOut()
                        UserDefaults.standard.set(false, forKey: "status")
                        NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                    }){
                        Text("log out")
                    }
                    
                    VStack {
                        Spacer()
                        Button(action: {
    //                        self.alert.toggle()
                        }){
                            Text("Ver pedido")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: screen.width - 40)
                        }
                        .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                        .cornerRadius(10)
                    }
                    
                }
                else{
                    ZStack{
                        NavigationLink(destination: SignUp(show: self.$show), isActive: self.$show){
                            Text("asd")
                        }
                        .hidden()
                        
                        Login(show: self.$show)
                    }
                }
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear{
                NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main)
                {
                    (_) in
                    self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                }
                
                
            }
            .sheet(isPresented: self.$showCart){
                CartView(phone: self.userData.userDataAlone.mov1 , location: self.userData.userDataAlone.street )
                
            }
            
        }
        .statusBar(hidden: true)
    }
}




struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}



