//
//  HatirlaticiCellView.swift
//  Hatırlatıcı
//
//  Created by MURAT BAŞER on 23.10.2023.
//

import SwiftUI

struct HatirlaticiCellView: View {
    var hatirlatici : Hatirlatici
    var body: some View {
        
        HStack{
            VStack(alignment: .leading, spacing: 3){
                Text(hatirlatici.baslik!)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                Text(hatirlatici.yapilacak!)
                    .font(.system(size: 18))
                    
                Text("\(hatirlatici.saat!):\(hatirlatici.dakika!)")
                    .foregroundColor(.black.opacity(0.7))
            }
            Spacer()
        }.padding(.horizontal)
         
        
    }
}
/*
struct HatirlaticiCellView_Previews: PreviewProvider {
    static var previews: some View {
        HatirlaticiCellView()
    }
}
*/
