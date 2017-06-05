# Tide - iOS Technical Test
                        
Build an (iPhone) iOS app, written in Swift, that retrieves data about places with close proximity to the user and shows the data on the screen.
 
# Api Request                
It is required to use Google Places Rest API to fetch the data. You may not use a library or a SDK that has already implemented the Google Places API requests. You need to implement a request that would return bars with close proximity to the device.
 
# Layout                        
You should implement a tabbed layout. The first tab should contain a list of the bars returned by the rest API. The second tab should contain a map with pins representing the bars.
 
# Bar List tab
The bar list tab should contain a list of the bars close to the user. Each list item should contain the name of the bar and the estimated distance between the device and the bar.
Clicking on a list item should take you to the Google Maps App and show you the location of the bar.
 
# Map Tab
The map tab should show the pins returned by the web service. Tapping on one of the pins should show info window with the name of the bar and the distance to it.
 
# Submission                                    
It is required to submit a zip file via email or a link to a public repository containing the XCode project. 

# Things in the code to look for

IBINspectable / IBDesignable, constraints and constraint animation, blocks, blocks with default value parameters, singletons, URLSession, custom labels (tracking - it's a beautiful thing), basic MVVM principles
