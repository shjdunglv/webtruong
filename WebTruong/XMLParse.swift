//
//  XMLParse.swift
//  WebTruong
//
//  Created by Le Dung on 5/2/17.
//  Copyright © 2017 shjdunglv. All rights reserved.
//

import Foundation
protocol XMLMParserDelegate{
    func XMLMParserError(parser: XMLParser, eroor:String)
}
class XMLParse:NSObject,XMLParserDelegate
{
    let url:NSURL
    var delegate: XMLMParserDelegate?
    var handled:(()->Void)?
    var objects = [Dictionary<String,String>]()
    private var object = Dictionary<String,String>()
    var inItem = false
    var element:String?
    init(url:NSURL)
    {
        self.url = url
    }
    func parse(handler:@escaping ()->Void)
    {
        self.handled = handler
        DispatchQueue.global().async {
            
            if let xmlCode = NSData(contentsOf: self.url as URL){
            let parser = XMLParser(data: xmlCode as Data)
            parser.delegate = self
            if !parser.parse()
            {
                self.delegate?.XMLMParserError(parser: parser, eroor: "Parser not found")
            }
            }
        }
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName=="item"
        {
            object.removeAll(keepingCapacity: true)
            inItem = true
        }
        element = elementName
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if !inItem
        {
            return
        }
        if let temp = object[element!]
        {
            var tempString = temp
            tempString += string
            object[element!] = tempString
        }
        else
        {
            object[element!] = string
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName=="item"
        {
            inItem = false
            objects.append(object)
        }
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        DispatchQueue.main.async {
            if (self.handled != nil)
            {
                self.handled!()
            }
        }
    }
}
