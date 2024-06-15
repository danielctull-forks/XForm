import SwiftUI

struct XForm <Content>: View where Content: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Group(subviewsOf: content) { subviews in
                    ForEach(subviews.dropLast()) { subview in
                        subview
                        Divider()
                    }
                    subviews.last
                }
            }
            .padding([.leading, .trailing])
        }
    }
}

// MARK: -

struct XSection <Label, Content>: View where Label: View, Content: View {
    let content: Content
    let label: Label

    @Environment(\.xFormDepth)
    var depth: Int?

    @State
    var contentIsHidden: Bool = false

    @State
    var isHovering: Bool = false

    init(@ViewBuilder content: () -> Content, @ViewBuilder label: () -> Label) {
        self.content = content()
        self.label = label()
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                let computedDepth = depth ?? 0
                label.font(computedDepth == 0 ? .title2 : .title3)
                Spacer()
                if computedDepth == 0 && isHovering {
                    Toggle(isOn: $contentIsHidden) {
                        switch contentIsHidden {
                        case false:
                            Text("Hide")
                        case true:
                            Text("Show")
                        }
                    }
                    .controlSize(.mini)
                    .toggleStyle(.button)
                }
            }
            .onHover {
                isHovering = $0
            }
            if !contentIsHidden {
                Group(subviewsOf: content) { subviews in
                    Group(subviewsOf: content) { subviews in
                        ForEach(subviews) { subview in
                            subview
                        }
                    }
                }
            }
        }
        .labeledContentStyle(XSectionLabeledContentStyle())
        .xFormDepth(value: self.depth ?? 0 + 1)
    }
}

extension XSection where Label == Text {
    init(_ title: String, @ViewBuilder content: () -> Content) {
        self.init(content: content) {
            Text(title)
        }
    }
}

// MARK: -

private struct XSectionLabeledContentStyle: LabeledContentStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .firstTextBaseline) {
            HStack {
                Spacer()
                configuration.label
            }
            .frame(width: 120)
            configuration.content
        }
    }
}

extension View {
    func labeled(_ label: LocalizedStringKey) -> LabeledContent<Text, Self> {
        LabeledContent {
            self
        } label: {
            Text(label)
        }
    }

    func labeled<Label: View>(@ViewBuilder _ label: () -> Label) -> LabeledContent<Label, Self> {
        LabeledContent {
            self
        } label: {
            label()
        }
    }
}

// MARK: -

struct XFormDepthKey: EnvironmentKey {
    static var defaultValue: Int?
}

extension EnvironmentValues {
    var xFormDepth: Int? {
        get {
            self[XFormDepthKey.self]
        }
        set {
            self[XFormDepthKey.self] = newValue
        }
    }
}

extension View {
    func xFormDepth(value: Int?) -> some View {
        self.environment(\.xFormDepth, value)
    }
}

