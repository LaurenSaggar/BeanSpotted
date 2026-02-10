//
//  DetailViewWrapper.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 2/9/26.

import SwiftUI

struct DetailViewWrapper: View {
    
    @EnvironmentObject var reviewStore: ReviewStore
    
    let shopId: String
    @ObservedObject var shopViewModel: CoffeeShopViewModel
    @ObservedObject var savedShopViewModel: SavedShopViewModel

    var body: some View {
        DetailView(shopId: shopId, shopViewModel: shopViewModel, savedShopViewModel: savedShopViewModel, reviewViewModel: reviewStore.reviewViewModel(for: shopId))
    }
}

//#Preview {
//    DetailViewWrapper()
//}
