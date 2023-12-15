//
//  ViewController.swift
//  TaskKatsun3
//
//  Created by 渡邊 翔矢 on 2023/12/14.
//

import SwiftUI

struct Item: Decodable {
    let title: String
    let createdAt: String
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case title
        case createdAt = "created_at"
        case user
    }
}

struct User: Decodable {
    let name: String
    let profileImageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileImageURL = "profile_image_url"
    }
}

struct ViewController: View {
    @State var isShowSafari = false
    @State private var items: [Item] = []
    
    
    var body: some View {
        List(items, id: \.title) { item in
            Button {
                isShowSafari.toggle()
            } label: {
                HStack {
                    AsyncImage(url: item.user.profileImageURL) { image in
                        image.resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                    }
                    VStack(alignment: .leading) {
                        Text(item.title)
                        Text("Created at: \(item.createdAt)")
                        Text("User: \(item.user.name)")
                    }
                }
            }
            .sheet(isPresented: $isShowSafari, content: {
                SafariView(url: item.user.profileImageURL)
                    .ignoresSafeArea(edges: [.bottom])
            })
        }
        .onAppear {
            fetchData()
        }
    }
    
    
    func fetchData() {
        Task {
            do{
                let url = URL(string: "https://qiita.com/api/v2/items?page=1&per_page=10")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let decodedItems = try JSONDecoder().decode([Item].self, from: data)
                self.items = decodedItems
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }
}

struct ItemDetailView: View {
    let item: Item
    
    var body: some View {
        VStack {
            Text(item.title)
            Text("Created at: \(item.createdAt)")
            Text("User: \(item.user.name)")
        }
        .padding()
    }
}

struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewController()
    }
}
