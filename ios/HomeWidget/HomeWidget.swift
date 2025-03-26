//
//  HomeWidget.swift
//  HomeWidget
//
//  Created by eslam kamel on 24/03/2025.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), data: "Placeholder Data")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let userDefaults = UserDefaults(suiteName: "group.gaztec4widget")
        let data = userDefaults?.string(forKey: "data") ?? "No Data Found"
        let entry = SimpleEntry(date: Date(), data: data)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {

        getSnapshot(in: context){
            (entry) in
            let timeline = Timeline(entries:[entry] , policy: .atEnd)
            completion(timeline)
        }
    }


}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let data: String
}

struct HomeWidgetEntryView : View {
    private let prayers: [(name: String, time: String , image:String)] = [
          ("Fajr", "3:00\nPM" , "two"),
          ("Sunrise", "3:00\nPM" , "two"),
          ("Asr", "3:00\nPM" , "two"),
          ("Maghrib", "3:00\nPM" , "two"),
          ("Isha", "3:00\nPM" , "two")
      ]
    
    var entry: Provider.Entry

    var body: some View {
//        VStack {
//            Text("Time:")
//            Text(entry.date, style: .time)
//            Image("two") // Use the name you assigned in Assets.xcassets
//                .resizable()
//                .scaledToFit()
//                .frame(width: 50, height: 50)
//            Text("Calender2:")
//            Text(entry.data)
//        }
        ScrollView(.horizontal , showsIndicators: false){
            HStack(spacing: 16) {  // Adjust spacing as needed
                     ForEach(prayers, id: \.name) { prayer in
                         PrayerView(name: prayer.name, time: prayer.time, imageName: prayer.image)
                     }
                 }
                 .padding()
        }
    }
}

struct HomeWidget: Widget {
    let kind: String = "HomeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                HomeWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                HomeWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct PrayerView: View {
    let name: String
    let time: String
    let imageName: String

    var body: some View {
        VStack(spacing: 5) {
            // Prayer name
            Text(name)
                .font(.headline)
            
            // Image container:
            // Use a fixed frame that approximates your Flutter dimensions.
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 60)  // Adjust these values as needed
                .clipped()
            
            // Prayer time (allowing multi-line text)
            Text(time)
                .multilineTextAlignment(.center)
                .font(.subheadline)
        }
        .frame(minWidth: 0, maxWidth: .infinity).frame(minWidth: 80)  // This helps to evenly distribute each column
    }
}
