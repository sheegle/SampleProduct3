//
//  AddView.swift
//  TaskKastun2
//
//  Created by 渡邊 翔矢 on 2023/11/26.
//

import Foundation
import SwiftUI

struct AddView: View {
    
    @State var inputText:String = ""
    
        var body: some View {
            
            NavigationStack{
                TextField("ここにメモを書いて下さい。", text: $inputText)
                        .font(.title)
                        .background(Color.primary)
                        .padding(.horizontal)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                   
                
                        }
                        .navigationTitle("Add Word")
                
            }
    }



#Preview {
    AddView()
}
