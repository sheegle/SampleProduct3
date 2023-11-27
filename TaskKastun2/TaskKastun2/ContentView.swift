//
//  ContentView.swift
//  TaskKastun2
//
//  Created by 渡邊 翔矢 on 2023/11/26.
//

import SwiftUI

struct TodoItem: Identifiable, Equatable {
    var id = UUID()
    var title: String
    var completed: Bool
}


struct ContentView: View {
    @State private var taskData = [TodoItem(title: "Task 1", completed: false),
                                   TodoItem(title: "Task 2", completed: false),]
    @State private var isShowAddView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(taskData) { item in
                    Button {
                        taskData[taskData.firstIndex(of: item)!].completed.toggle()
                    } label: {
                        HStack {
                            Image(systemName: item.completed ? "checkmark.circle.fill" :"circle" )
                            Text(item.title)
                        }
                    }
                    .foregroundColor(.primary)
                }
                .onDelete { indexSet in
                    taskData.removeAll { indexSet.contains(taskData.firstIndex(of: $0)!) }
                }
            }


            .navigationTitle("ToDoリスト")
            .toolbar {
                Button("+") {
                    isShowAddView = true
                }
            }
            .sheet(isPresented: $isShowAddView){
                AddView(taskData: $taskData)
            }
        }
    }
}

#Preview {
    ContentView()
}
