import SwiftUI

struct ContentView: View {

    @State
    var name = "ContentView.swift"

    var body: some View {

        ContentUnavailableView("This view intentionally left blank", systemImage: "gear")
        .inspector(isPresented: .constant(true)) {
            XForm {
                XSection("Transform") {
                    XSection("Scale") {
                        TextField("x", value: .constant(0), format: .number)
                            .labeled("X")
                        TextField("y", value: .constant(0), format: .number)
                            .labeled("X")
                        TextField("z", value: .constant(0), format: .number)
                            .labeled("Y")
                    }
                    XSection("Rotation") {
                        TextField("x", value: .constant(0), format: .number)
                            .labeled("X")
                        TextField("y", value: .constant(0), format: .number)
                            .labeled("X")
                        TextField("z", value: .constant(0), format: .number)
                            .labeled("Y")
                    }
                    XSection("Translation") {
                        TextField("x", value: .constant(0), format: .number)
                            .labeled("X")
                        TextField("y", value: .constant(0), format: .number)
                            .labeled("X")
                        TextField("z", value: .constant(0), format: .number)
                            .labeled("Y")
                    }

                    XSection("Testing") {
                        DateView()
                    }
                }


                XSection("Identity and Type") {
                    TextField("Name", text: $name)
                        .labeled("Name")
                    TextField("Type", text: .constant("blah blah"))
                        .labeled("Type")
                    TextField("Location", text: .constant("blah blah"))
                        .labeled("location")
                    HStack {
                        Text("ContentView.swift")
                        Spacer()
                        Image(systemName: "folder.fill")
                    }
                    .labeled {
                        Spacer()
                    }
                }
                XSection("On Demand Resource Tags") {
                    TextField("Name", text: .constant("Blah blah"))
                }
                XSection("Target Membership") {
                    List {
                        Label("MyApp", systemImage: "gear")
                    }
                    .frame(height: 80)
                }
                XSection("Text Settings") {
                    Picker("Text Encoding", selection: .constant("utf8")) {
                        Text("utf8").tag("utf8")
                    }
                    .labeled("Text Encoding")
                    Picker("Line Endings", selection: .constant("LF")) {
                        Text("LF").tag("LF")
                    }
                    .labeled("Line Endings")
                    Divider()
                    Picker("Indent Using", selection: .constant("Spaces")) {
                        Text("Spaces").tag("Spaces")
                    }
                    .labeled("Indent Using")
                }
            }
            .controlSize(.mini)

        }

    }
}

struct DateView: View {
    @State
    var date = Date()

    var body: some View {
        Text("\(date)")
    }
}

#Preview {
    ContentView()
}

