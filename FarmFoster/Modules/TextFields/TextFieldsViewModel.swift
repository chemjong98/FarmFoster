//
//  TextFieldsViewModel.swift
//  FarmFoster
//
//  Created by Roshan Chemjong on 29/04/2024.
//

import Foundation

enum TextFieldsType: String, CaseIterable {
    case normalText
    case defaultDropdown
    case searchableDropdown
    case priceTextField
    
    var value: String {
        return self.rawValue
    }
}


class TextFieldsViewModel: ObservableObject {
    
    @Published var textFieldsType: TextFieldsType?
    @Published var normalInputText: String = ""
    @Published var dropDownInputText: String = ""
    @Published var searchDropdownInputText: String = ""
    @Published var searchText = "" {
        didSet {
            searchFilter()
        }
    }
    @Published var searchedList : [String] = []
    var defaultDropDownOption: [String] = ["option1", "option2", "option3", "option4", "option5", "option6", "option7"]
    
    init() {
        searchFilter()
    }
    
    func searchFilter() {
        if searchText.isEmpty {
            searchedList = defaultDropDownOption
        } else {
            searchedList = defaultDropDownOption.filter { value in
                value.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
