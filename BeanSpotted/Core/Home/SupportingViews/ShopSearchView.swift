//
//  ShopSearchView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 1/18/26.
//

import SwiftUI
import CoreLocation
import MapKit

struct ShopSearchView: View {
    
    @StateObject private var locationManager = LocationManager()
    @State private var mapItems: [MKMapItem] = []
    @State private var position: MapCameraPosition = .automatic

    var body: some View {
        VStack(spacing: 0) {
            Map(position: $position) {
                ForEach(mapItems, id: \.self) { item in
                    if let name = item.name {
                        Marker(name, coordinate: item.placemark.coordinate)
                    }
                }
            }
            .frame(height: 300)
            .onMapCameraChange(frequency: .onEnd) { context in
                Task {
                    await searchCoffee(in: context.region)
                }
            }

            List(mapItems, id: \.self) { item in
                VStack(alignment: .leading) {
                    Text(item.name ?? "Unknown")
                        .font(.headline)
                    Text(item.placemark.title ?? "")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .onTapGesture {
                    position = .region(MKCoordinateRegion(
                        center: item.placemark.coordinate,
                        latitudinalMeters: 1000,
                        longitudinalMeters: 1000
                    ))
                }
            }
        }
        .task {
            locationManager.requestLocation()
        }
//        .onChange(of: locationManager.location) { _, loc in
//            guard let loc else { return }
//            Task {
//                mapItems = await searchCoffee(near: loc.coordinate)
//                print("Location:", loc.coordinate.latitude, loc.coordinate.longitude)
//                position = .region(MKCoordinateRegion(
//                    center: loc.coordinate,
//                    latitudinalMeters: 5000,
//                    longitudinalMeters: 5000
//                ))
//            }
//        }
    }
    
    // MKLocalSearch inputs include a natural language query and a region (important for “near me” results)
    @MainActor
    private func searchCoffee(in region: MKCoordinateRegion) async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "coffee"
        request.region = region

        do {
            let response = try await MKLocalSearch(request: request).start()
            mapItems = response.mapItems
        } catch {
            mapItems = []
            print("Search error:", error)
        }
    }
}


#Preview {
    ShopSearchView()
}
