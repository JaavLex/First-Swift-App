//
//  ContentView.swift
//  FirstSwiftApp WatchKit Extension
//
//  Created by Alexandre Javet on 09.06.22.
//

import SwiftUI
import UIKit

let url = "https://meme-api.herokuapp.com/gimme/1"

struct Memeslist:Codable{
    let postLink: String
    let subreddit: String
    let title: String
    let url: String
    let nsfw: Bool
    let spoiler: Bool
    let author: String
    let ups: Int
    let preview: Array<String>
}

struct Meme:Codable{
    let count: Int
    let memes: Array<Memeslist>
}

struct ContentView: View {
    @State var testText:String = ""
    @State var memeUrl:String = ""
    
    func decodeAPI(from url: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                print("Oops smth went wrong")
                return
            }
            
            var result: Meme?
            do {
                result = try JSONDecoder().decode(Meme.self, from: data)
            }
            catch {
                print("Failed converting data \(error.localizedDescription)")
            }
            
            guard let json = result else {
                return
            }
            
            memeUrl = json.memes[0].url
        })
            
        task.resume()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: memeUrl))
            Button {
                decodeAPI(from: url)
            } label: {
                Text("Meme me !")
                    .padding(1)
            }
            .contentShape(Rectangle())
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
