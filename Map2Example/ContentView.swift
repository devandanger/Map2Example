//
//  ContentView.swift
//  Map2Example
//
//  Created by Evan Anger on 3/3/24.
//

import MapKit
import SwiftUI

extension CLLocationCoordinate2D {
    static var start: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.006)
    }
    static var end: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 40.714, longitude: -74.0055)
    }
    static var nycTrip: [CLLocationCoordinate2D] {
        return [
            CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.006),
            CLLocationCoordinate2D(latitude: 40.714, longitude: -74.0055),

        ]
    }
}

extension CLLocationCoordinate2D {
    
    static var inifiniteLoop: CLLocationCoordinate2D = {
        CLLocationCoordinate2D(latitude: 37.331836, longitude: -122.029604)
    }()
    
    static var applePark: CLLocationCoordinate2D = {
        CLLocationCoordinate2D(latitude: 37.334780, longitude: -122.009073)
    }()
    
    static var nyc: CLLocationCoordinate2D = {
        CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.006)
    }()
    
}

struct TabButtonData {
    let title: String
    let count: Int
    let tag: Int
}

struct ButtonTab: View {
    @Binding var selection: Int
    let buttonData: [TabButtonData]
    var body: some View {
        HStack(spacing: 0) {
            ForEach(self.buttonData, id: \.title) { buttonData in
                Button(action: {
                    selection = buttonData.tag
                }, label: {
                    VStack {
                        Text(buttonData.title)
                        Text(String(buttonData.tag))
                        if selection == buttonData.tag {
                            Rectangle()
                                .frame(height: 4)
                        } else {
                            Rectangle()
                                .fill(.clear)
                                .frame(height: 4)
                        }
                    }
                })
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct ContentView: View {
    @State var mapPosition: MapCameraPosition = .camera(.init(centerCoordinate: CLLocationCoordinate2D.nyc, distance: 1000))
    
    @State var region = MKCoordinateRegion(
        center: .init(latitude: 37.334_900,longitude: -122.009_020),
        span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    @State var selection: Int = 0
    var body: some View {
        VStack(spacing: 0) {
            ButtonTab(selection: $selection, buttonData: [
                TabButtonData(title: "One Item", count: 0, tag: 0),
                TabButtonData(title: "Two\nLonger Item", count: 0, tag: 1),
                TabButtonData(title: "Three\nItem", count: 0, tag: 2)
            ])
            Map(position: $mapPosition) {
                MapPolyline(coordinates: CLLocationCoordinate2D.nycTrip)
                    .strokeStyle(style: StrokeStyle(lineWidth: 1, lineCap: .butt, lineJoin: .round, miterLimit: 1, dash: [5, 2], dashPhase: 0.1))
                    .stroke(.blue)
                Annotation("Start", coordinate: CLLocationCoordinate2D.start) {
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: 45, height: 45)
                        Image(systemName: "s.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.green)
                    }

                    
                }
                Annotation("Start", coordinate: CLLocationCoordinate2D.end) {
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: 45, height: 45)
                        Image(systemName: "e.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.red)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
