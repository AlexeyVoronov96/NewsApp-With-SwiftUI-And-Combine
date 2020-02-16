//
//  SearchBarView.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 16.02.2020.
//  Copyright © 2020 Алексей Воронов. All rights reserved.
//

import SwiftUI
import UIKit

struct SearchBarView: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeCoordinator() -> SearchBarView.Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBarView>) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = Constants.placeholder
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBarView>) {
    }
}

extension SearchBarView {
    
    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(true, animated: true)
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            guard let searchBarText = searchBar.text else { return }
            text = searchBarText
            searchBar.resignFirstResponder()
        }
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(false, animated: true)
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }
}

private extension SearchBarView {
    
    struct Constants {
        static let placeholder = "Search".localized()
    }
}

