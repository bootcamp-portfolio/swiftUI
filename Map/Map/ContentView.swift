//
//  ContentView.swift
//  Map
//
//  Created by electrozone on 3/31/26.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), // Seoul City Hall
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )
    @StateObject private var locationManager = LocationManager()

    enum MapStyleOption: String, CaseIterable, Identifiable {
        case standard = "표준"
        case satellite = "위성"
        case hybrid = "혼합"
        var id: String { rawValue }

        @available(iOS 17.0, *)
        var mapStyle: MapStyle {
            switch self {
            case .standard: return .standard
            case .satellite: return .imagery
            case .hybrid: return .hybrid
            }
        }
    }

    @State private var selectedStyle: MapStyleOption = .standard
    @State private var showsUserLocation: Bool = true

    // Example marker in the center of Seoul
    private let markerCoordinate = CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780)

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                Picker("지도 타입", selection: $selectedStyle) {
                    ForEach(MapStyleOption.allCases) { style in
                        Text(style.rawValue).tag(style)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                mapView
                    .ignoresSafeArea(edges: .bottom)

                HStack {
                    Button {
                        withAnimation(.easeInOut) {
                            switch locationManager.authorizationStatus {
                            case .notDetermined:
                                locationManager.requestWhenInUseAuthorization()
                            default:
                                break
                            }
                            position = .userLocation(fallback: .region(
                                MKCoordinateRegion(
                                    center: markerCoordinate,
                                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                )
                            ))
                        }
                    } label: {
                        Label("내 위치", systemImage: "location.fill")
                    }

                    Spacer()

                    Button {
                        withAnimation(.easeInOut) {
                            position = .region(
                                MKCoordinateRegion(
                                    center: markerCoordinate,
                                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                )
                            )
                        }
                    } label: {
                        Label("서울로", systemImage: "mappin.and.ellipse")
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationTitle("Map")
            .toolbarTitleDisplayMode(.inline)
        }
    }

    @ViewBuilder
    private var mapView: some View {
        if #available(iOS 17.0, *) {
            Map(position: $position) {
                // 예시 마커
                Marker("서울", systemImage: "mappin.circle.fill", coordinate: markerCoordinate)
            }
            .mapStyle(selectedStyle.mapStyle)
            .mapControls {
                MapCompass()
                MapPitchToggle()
                MapScaleView()
            }
            .overlay(alignment: .topTrailing) {
                Toggle(isOn: $showsUserLocation) {
                    Image(systemName: showsUserLocation ? "location.fill" : "location")
                }
                .toggleStyle(.button)
                .buttonStyle(.bordered)
                .padding(8)
            }
            .onChange(of: showsUserLocation) { _, newValue in
                // No-op; Map shows user location automatically when camera is set to userLocation.
                if newValue {
                    withAnimation(.easeInOut) {
                        position = .userLocation(fallback: position)
                    }
                }
            }
            .onChange(of: locationManager.lastLocation) { _, newLocation in
                guard showsUserLocation, let newLocation else { return }
                withAnimation(.easeInOut) {
                    position = .camera(
                        MapCamera(
                            centerCoordinate: newLocation.coordinate,
                            distance: 1000,
                            heading: 0,
                            pitch: 0
                        )
                    )
                }
            }
        } else {
            // Fallback for iOS 16 using Map with region binding
            let markers = [
                MapMarkerItem(coordinate: markerCoordinate, title: "서울")
            ]

            Map(
                coordinateRegion: .constant(
                    MKCoordinateRegion(
                        center: markerCoordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    )
                ),
                annotationItems: markers
            ) { item in
                MapMarker(coordinate: item.coordinate)
            }
            .onAppear {
                if locationManager.authorizationStatus == .notDetermined {
                    locationManager.requestWhenInUseAuthorization()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

