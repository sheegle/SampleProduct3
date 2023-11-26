//
//  ContentView.swift
//  TaskKastun2
//
//  Created by 渡邊 翔矢 on 2023/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var taskData = [(title: "", completed: false)]
    @State var isShowAddView = false
    
    var body: some View {
        NavigationStack {
            List(0..<taskData.count, id: \.self) { index in
                Button {
                    taskData[index].completed.toggle()
                } label: {
                    HStack {
                        Image(systemName: taskData[index].completed ? "checkmark.circle.fill" :"circle" )
                        Text(taskData[index].title)
                    }
                }
                .foregroundColor(.primary)
                
                .navigationTitle("ToDoリスト")
                .toolbar {
                    Text("+")
                    isShowAddView = true
                }
                .sheet(isPresented: $isShowAddView){
                    AddView()
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
