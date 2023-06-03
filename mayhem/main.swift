#if canImport(Darwin)
import Darwin.C
#elseif canImport(Glibc)
import Glibc
#elseif canImport(MSVCRT)
import MSVCRT
#endif

import Foundation
import Ink

let possible_modifiers = [
    Modifier.Target.metadataKeys,
    Modifier.Target.metadataValues,
    Modifier.Target.blockquotes,
    Modifier.Target.codeBlocks,
    Modifier.Target.headings,
    Modifier.Target.horizontalLines,
    Modifier.Target.html,
    Modifier.Target.images,
    Modifier.Target.inlineCode,
    Modifier.Target.links,
    Modifier.Target.lists,
    Modifier.Target.paragraphs,
    Modifier.Target.tables,
]

@_cdecl("LLVMFuzzerTestOneInput")
public func test(_ start: UnsafeRawPointer, _ count: Int) -> CInt {
    let fdp = FuzzedDataProvider(start, count)
    let modifier = Modifier(target: fdp.PickValueInList(from: possible_modifiers))
    { html, markdown in
        return fdp.ConsumeRemainingString() + html
    }

    let parser = MarkdownParser(modifiers: [modifier])
    parser.html(from: fdp.ConsumeRemainingString())
    return 0;
}