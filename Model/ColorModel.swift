//
//  ColorModel.swift
//  Hatırlatıcı
//
//  Created by MURAT BAŞER on 23.10.2023.
//

import Foundation
import SwiftUI



struct ColorModel : Identifiable{
    var id = UUID()
    var color : Color
    var colorname : String
}

let colors : [ColorModel] = [
    ColorModel(color: Color("Color1"), colorname: "kırmızı"),
    ColorModel(color: Color("Color2"), colorname: "mavi"),
    ColorModel(color: Color("Color3"), colorname: "mavi"),
    ColorModel(color: Color("Color4"), colorname: "mavi")
]
