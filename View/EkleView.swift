//
//  EkleView.swift
//  Hatırlatıcı
//
//  Created by MURAT BAŞER on 23.10.2023.
//

import SwiftUI

struct EkleView: View {
    @State private var baslik = ""
    @State private var yapilacak = ""
    @State private var currentTime = Date()
    @State private var renk : Color?
    @State private var isHidden = false
    @ObservedObject var ViewModel = HatirlaticiViewModel()
    @State private var saat = ""
    @State private var dakika = ""
    @Environment(\.presentationMode) var pm
    var body: some View {
        NavigationStack{
            ZStack{
                Form{
                    Section(header: Text("Tema").fontWeight(.bold)){
                        ScrollView(.horizontal,showsIndicators: false){
                            LazyHGrid(rows: [GridItem(.flexible())]){
                                Image(systemName: "circle.slash")
                                    .resizable()
                                    .foregroundColor(.black)
                                    .frame(width: 28,height: 28)
                                    .onTapGesture {
                                        self.isHidden = false
                                    }
                                ForEach(colors,id: \.id){i in
                                    Circle()
                                        .fill(i.color)
                                        .frame(width: 28,height: 28)
                                        .onTapGesture {
                                            self.isHidden = true
                                            self.renk = i.color
                                        }
                                    
                                }.padding(.horizontal,14)
                            }
                        }.padding(.horizontal)
                    }
                    .padding(.vertical,7)
                    
                    Section(header: Text("Hatırlatıcı Bilgileri").fontWeight(.bold)){
                        TextField("Başlık", text: $baslik).foregroundColor(.black)
                        TextField("Yapılacak",text: $yapilacak).foregroundColor(.black)
                        
                    }
                    .padding(.vertical,8)
                    Section(header: Text("Saat").fontWeight(.bold)){
                        DatePicker("Saat", selection:$currentTime,displayedComponents: [.hourAndMinute])
                            .foregroundColor(.black)
                    }
                    .padding(.vertical,7)
                    
                    Button{
                        if baslik != "" && yapilacak != "" {
                            bildirimGonder()
                            ViewModel.veriKaydet(saat: saat, dakika: dakika, baslik: baslik, yapilacak: yapilacak)
                            pm.wrappedValue.dismiss()
                        }
                    }label: {
                        Text("Kaydet")
                            .foregroundColor(.blue)
                    }
                }
                
                    
                .scrollContentBackground(self.isHidden ? .hidden : .visible)
                
                .foregroundColor(self.isHidden ? .white : .black)
                .edgesIgnoringSafeArea(.all)
                .offset(y:120)
            }
            
            .background(self.isHidden ?  renk : .gray.opacity(0.1))
            .edgesIgnoringSafeArea(.all)

        }
    }
    func bildirimGonder(){
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour,.minute], from: currentTime)
        let hour = comp.hour
        let minute = comp.minute
        
        let formatterHour = String(format: "%02d", hour!)
        print("Hour : \(formatterHour)")
        self.saat = formatterHour
        
        let formatterMinute = String(format: "%02d", minute!)
        print("Minute : \(formatterMinute)")
        self.dakika = formatterMinute
        
    }
         
}

struct EkleView_Previews: PreviewProvider {
    static var previews: some View {
        EkleView()
    }
}
