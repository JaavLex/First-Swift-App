//
//  ContentView.swift
//  FirstSwiftApp WatchKit Extension
//
//  Created by Alexandre Javet on 09.06.22.
//

import SwiftUI

struct Memeslist:Codable{
    let postLink: String
    let subreddit: String
    let title: String
    let url: String
    let nsfw: Bool
    let spoiler: Bool
    let author: String
    let ups: Bool
    let preview: Array<String>
}

struct Meme:Codable{
    let count: Int
    let memes: Array<Memeslist>
}

struct ContentView: View {
    @State var incr:Int = 0
    @State var testText:String = ""
    
    func decodeAPI(){
        guard let url = URL(string: "https://meme-api.herokuapp.com/gimme/1") else{return}

        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            let decoder = JSONDecoder()

            if let data = data{
                do{
                    let tasks = try decoder.decode([Meme].self, from: data)
                    tasks.forEach{ i in
                        print(i.memes[0].title)
                    }
                }catch{
                    print(error)
                }
            }
        }
        task.resume()

    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                self.incr+=1
                decodeAPI()
            } label: {
                Text("✨")
                    .padding(10)
            }
            .contentShape(Rectangle())
            Text("Number \(incr)")
                .padding(10)
            Text("\(testText)")
                .padding(10)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
