//
//  GlobalStateViewModel.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/3/12.
//

import Foundation
class GlobalStateViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var isFromSinglePost: Bool = false
}
