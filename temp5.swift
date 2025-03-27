import WidgetKit
import SwiftUI

// MARK: - Data Provider

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
        getSnapshot(in: context) { entry in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let data: String
}

// MARK: - Reusable PrayerView

struct PrayerView: View {
    let name: String
    let time: String
    let imageName: String
    let imageSize: CGSize
    
    var body: some View {
        VStack(spacing: 5) {
            Text(name)
                .font(.system(size: imageSize.height * 0.3, weight: .semibold))
                .foregroundColor(.black)
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: imageSize.width, height: imageSize.height)
                .clipped()
                .cornerRadius(8)
            
            Text(time)
                .font(.system(size: imageSize.height * 0.25))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

// MARK: - Main Widget View

struct HomeWidgetEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    
    
    
    // Prayer data: name, time, and image name
    private let prayers: [(name: String, time: String, image: String)] = [
        ("Fajr", "3:00\nPM", "fajr"),
        ("Sunrise", "3:00\nPM", "three"),
        ("Duhr", "3:00\nPM", "two"),
        ("Asr", "3:00\nPM", "one"),
        ("Maghrib", "3:00\nPM", "four"),
        ("Isha", "3:00\nPM", "five")
    ]
    
    var body: some View {
        
        ZStack {
            // Islamic-themed background: a gradient from a dark to a lighter shade.
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.05), Color.green.opacity(0.05)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Choose layout based on widget family.
            switch family {
            case .systemSmall:
                // Show a single prayer for small widget.
                if let firstPrayer = prayers.first {
                    PrayerView(
                        name: firstPrayer.name,
                        time: firstPrayer.time,
                        imageName: firstPrayer.image,
                        imageSize: CGSize(width: 40, height: 50)
                    )
                    
                }
            case .systemMedium:
                // Show three prayers in a horizontal row for medium widget.
                HStack(spacing: 8) {
                    ForEach(prayers.prefix(3), id: \.name) { prayer in
                        PrayerView(
                            name: prayer.name,
                            time: prayer.time,
                            imageName: prayer.image,
                            imageSize: CGSize(width: 50, height: 60)
                        )
                    }
                }
                
            case .systemLarge:
                // Show all prayers in a grid layout for large widget.
                let columns = [GridItem(.flexible()), GridItem(.flexible())]
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(prayers, id: \.name) { prayer in
                        PrayerView(
                            name: prayer.name,
                            time: prayer.time,
                            imageName: prayer.image,
                            imageSize: CGSize(width: 50, height: 50)
                        )
                    }
                }
            default:
                // Fallback: horizontal layout with all prayers.
                HStack(spacing: 8) {
                    ForEach(prayers, id: \.name) { prayer in
                        PrayerView(
                            name: prayer.name,
                            time: prayer.time,
                            imageName: prayer.image,
                            imageSize: CGSize(width: 30, height: 30)
                        )
                    }
                }            }
        }
    }
}

// MARK: - Widget Declaration

struct HomeWidget: Widget {
    let kind: String = "HomeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                HomeWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                HomeWidgetEntryView(entry: entry)
                   
                    .background()
            }
        }
        .configurationDisplayName("Prayer Times")
        .description("Displays Islamic prayer times with a modern, responsive design.")
    }
}

