<!-- @format -->

# Draft View

[![codecov](https://codecov.io/gh/sirily11/flutter_draftview/branch/main/graph/badge.svg?token=MGA0BCKL8P)](https://codecov.io/gh/sirily11/flutter_draftview) ![Flutter test](https://github.com/sirily11/flutter_draftview/workflows/Flutter%20test/badge.svg)

A Draft JS renderer written in Dart!

This project supports rendering Draft JS object in Flutter natively! It will convert draft js object into Flutter Rich Textspan!

It is implemented in a plugable design so that you can create your own plugin easily.

## Supported Plugins

- Image Plugin
- List Plugin
- Blockquote Plugin
- PostSettings Plugin. [Example](https://blog.sirileepage.com/#/post/39)
- Header Plugin
- Basic Text Plugin

## Demo

1. Header, Postsettings, BlockQuote support
   ![image1](./images/1.png)

2. Image and image's caption support
   ![image2](./images/2.png)

3. Full screen image support (when clicked)
   ![image3](./images/3.png)

4. Text inline style and nested list support
   ![image4](./images/4.png)
