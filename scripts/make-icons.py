#!/usr/bin/env python3
from argparse import ArgumentParser
from pathlib import Path

from lxml.builder import ElementMaker
from lxml.etree import parse, tostring


NAMESPACE = 'http://www.w3.org/2000/svg'
E = ElementMaker(namespace=NAMESPACE, nsmap={None: NAMESPACE})


if __name__ == '__main__':
    parser = ArgumentParser(description='Combines SVG icons to one file')
    parser.add_argument('-d', '--icons-dir', metavar='PATH', default='icons', help='Directory with separate icons')
    parser.add_argument('-o', '--output', metavar='SVG', default='layouts/partials/icons.svg', help='Output filename')
    args = parser.parse_args()

    svg = E.svg()
    svg.attrib['width'] = svg.attrib['height'] = '16'
    svg.attrib['display'] = 'none'
    for f in Path(args.icons_dir).glob('*.svg'):
        icon = parse(f).getroot()
        elements = icon.xpath('./*')
        for e in elements:
            if 'fill' in e.attrib:
                del e.attrib['fill']
        symbol = E.symbol(*elements)
        symbol.attrib['id'] = f'icon-{f.stem}'
        symbol.attrib['viewBox'] = icon.attrib['viewBox']
        svg.append(symbol)
    with open(args.output, 'bw') as f:
        f.write(tostring(svg))
