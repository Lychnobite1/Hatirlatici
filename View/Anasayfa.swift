//
//  ContentView.swift
//  Hatırlatıcı
//
//  Created by MURAT BAŞER on 23.10.2023.
//

import SwiftUI
import UserNotifications
struct Anasayfa: View {
    @State private var saatArray = [String]()
    @State private var dakikaArray = [String]()
    @State private var currentTime = Date()
    @State private var ekleView = false
    @ObservedObject var ViewModel = HatirlaticiViewModel()
    
    init(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound,.badge,.alert]) { (bool, error) in
            if bool {
                print("izin alındı.")
            }
            else {
                print("izin alınamadı.")
            }
        }
    }
    
    func silButon(at offsets:IndexSet) {
        let veri = ViewModel.verilerListesi[offsets.first!]
        ViewModel.verilerListesi.remove(at: offsets.first!)
        ViewModel.veriSil(veri: veri)
    }

    
    var body: some View {
        NavigationStack{
            VStack {
                HStack{
                    Text("Hatırlatıcı Listesi")
                        .font(.system(size: 26))
                        .fontWeight(.bold)
                    Spacer()
                }.padding(.horizontal)
                List{
                    ForEach(ViewModel.verilerListesi,id: \.id){i in
                        HatirlaticiCellView(hatirlatici: i)
                    }
                    .onDelete(perform: silButon)
                }.listStyle(.inset)
            }
            .onAppear{
                ViewModel.verileriGetir()
                ViewModel.saatVeDakikaGetir()
                ViewModel.bildirimGetir()
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        self.ekleView = true
                    }label: {
                        NavigationLink(destination: EkleView(),isActive: $ekleView){
                            HStack{
                                Image(systemName: "plus.circle")
                                Text("Hatırlatıcı Ekle")
                            }
                        }
                    }
                }
            }
            
            
        }
        
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Anasayfa()
    }
}
