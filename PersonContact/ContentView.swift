//
//  ContentView.swift
//  PersonContact
//
//  Created by Saqib Siddique on 2022-08-19.
//

import SwiftUI

struct ContentView: View {
    @State private var searchtext = ""
    var body: some View {
        VStack{
            NavigationView {
                List(Person,id: \.id) { character in
                    
                    NavigationLink(destination:
                                    CharacterDetail(character: character)){
                        CharacterRow(character: character)
                    }
                }                
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        
                        Button {
                        } label: {
                            Image("searchicon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.orange)
                        }
                        .offset(x:-40)
                        Text("Contacts")
                            .font(.system(size: 30.0))
                            .font(.headline).bold()
                            .offset(x:-10)
                        Button {
                            print("Edit button was tapped")
                        } label: {
                            Image("addicon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.orange)
                            
                        }
                        .offset(x:30)
                    }
                }
                
            }
            .navigationViewStyle(StackNavigationViewStyle())
            
        }
    }
    
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    struct SearchBar: UIViewRepresentable {
        
        @Binding var text: String
        
        class Coordinator: NSObject, UISearchBarDelegate {
            
            @Binding var text: String
            
            init(text: Binding<String>) {
                _text = text
            }
            
            func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                text = searchText
            }
        }
        
        func makeCoordinator() -> Coordinator {
            return Coordinator(text: $text)
        }
        
        func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
            let searchBar = UISearchBar(frame: .zero)
            searchBar.delegate = context.coordinator
            return searchBar
        }
        
        func updateUIView(_ uiView: UISearchBar,
                          context: UIViewRepresentableContext<SearchBar>) {
            uiView.text = text
        }
    }
