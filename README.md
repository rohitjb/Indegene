# Indegene

What does this PR do?
-----------
This PR download the set of data and present it on the `List` as well as in grid view. Apart from this I have implemented the file caching also. I have taken care of the orientation as well So when device is in landscape mode then only grid view will be enabled because If we don't do so then as per our aspect ration i.e. 4:3 height crosses the screen area and view look weird.

Any background context you want to provide?
------------
NO

Where should the reviewer start?
------------
`ContentViewController.swift`

What tests were added? (if none, why not?)
------------
For now I have written `IndengeContentDataSourceTests.swift`, `ContentJsonParsingTests.swift` but more test cases can be written around the navigation logic and to increase the `code coverage` we can write snap shot test around views and cells and test cases for presenter.

Screenshots (if appropriate)
------------

| Before | After |
| ------ | ----- |
|<img width="270" alt="screen shot 2018-04-16 at 12 53 26 am" src="https://user-images.githubusercontent.com/7466802/38782410-a496951c-4110-11e8-82c3-9504e53000f8.png">|<img width="270" src = "https://user-images.githubusercontent.com/7466802/38782428-d849d7c0-4110-11e8-953a-9acaf34a6bf5.gif">|

Questions
------------
NO
