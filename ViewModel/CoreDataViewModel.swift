//
//  CoreDataViewModel.swift
//  Hatırlatıcı
//
//  Created by MURAT BAŞER on 23.10.2023.
//

import Foundation
import CoreData
import UserNotifications

class HatirlaticiViewModel : ObservableObject {
    @Published var verilerListesi = [Hatirlatici]()
    @Published var saatArray = [String]()
    @Published var dakikaArray = [String]()
    let context = persistentContainer.viewContext
    
    func veriKaydet(saat:String,dakika:String,baslik:String,yapilacak:String){
        let veri = Hatirlatici(context: context)
        veri.id = UUID()
        veri.baslik = baslik
        veri.yapilacak = yapilacak
        veri.saat = saat
        veri.dakika = dakika
        saveContext()
        verileriGetir()
    }
    func saatVeDakikaGetir(){
        do {
            let liste = try context.fetch(Hatirlatici.fetchRequest())
            for i in liste {
                saatArray.append(i.saat!)
                dakikaArray.append(i.dakika!)
            }
        }
        catch{
            
        }
    }
    func verileriGetir(){
        do {
            let liste = try context.fetch(Hatirlatici.fetchRequest())
            verilerListesi = liste
        }
        catch{
            print("veriler getirilemedi")
        }
    }
    
    func veriSil(veri : Hatirlatici){
        context.delete(veri)
        saveContext()
        verileriGetir()
    }
    
    func bildirimGetir(){
        for (index,_) in self.saatArray.enumerated() {
            let saat = Int(self.saatArray[index])
            let dakika = Int(self.dakikaArray[index])
            var dateComp = DateComponents()
            dateComp.hour = saat
            dateComp.minute = dakika
            let cd = Date()
            let calendar = Calendar.current
            let a = calendar.nextDate(after: cd, matching: dateComp, matchingPolicy: Calendar.MatchingPolicy.nextTime)!
            let timeDifference = a.timeIntervalSince(cd)
            let content = UNMutableNotificationContent()
            content.title = "Zaman geldi"
            content.body = "\(saat ?? 0):\(dakika ?? 0) saatinde yapacaklarınız var"
            content.sound = .default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeDifference, repeats: false)
            let request = UNNotificationRequest(identifier: "request_\(saat ?? 0)_\(dakika ?? 0)", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request,withCompletionHandler: nil)
        }
    }
   
    
    
}
