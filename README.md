# AutoHotKeys-WindowsControl
This repo is for my AutoHotKeys scripts, though currently I only see a need for the WindowsControl script.

## Windows Control script
This script is meant to add much more control over Windows and some apps, via the mouse.
This script assumes your mouse has a gesture/thumb button and back/forward buttons.
I wrote it for the Logitech MX Master mice.
(Though I think it's ideal with the MX Master 3, and I consider the MX Master 3s problematic due to its 'soft' thumb button, but YMMV)

## Installation instructions
In order to create new key combos using the thumb button, I needed to override the default button's behavior by reassigning the keyboard keys it emulates so that I could 'catch' these events in the AHK script.
So what I did is:
1. Install [AHK v2](https://www.autohotkey.com/download/2.0/) 
2. Install Logi options+
3. Reconfigure the thumb/gesture button to send a keyboard shortcut: Windows + Alt + \` (Tilda) (assuming you don't already use that keyboard combo)
4. If you plan on using this script on Admin-running apps also, make sure you're also running this script as Admin
5. If you plan on editing this script, I used Notepad++ and set the language to AutoIt (there's no Notepad++ language definition for AHK files)

## Usage - Configured mouse keys combos and their actions
### Media
##### Modifier - Right click
* Wheel - Volume
* Back/Forward - Previous/Next track
* Middle button - Play/Pause


### Windows management
##### Modifier - Back button
* Wheel - WinKey + right/left  =  Snap window to regions (works best after configuring custom zones using PowerToys's FancyZones)
* Right click - close window (Alt + F4)
* Middle click - Minimize window
* Left click - Resotre window (does Alt+Tab which bring back the restored window, as an undo operation, but also useful to switch between 2 apps quickly)


### Alt tab
##### Modifier - Middle button
* Wheel Down - Open Alt-Tab menu, then, control selection via Wheel, select active window by releasing the Middle button
* Right click - Exit selected app


### Taskbar apps
##### Modifier - Next button
* Wheen Down - Execute an app from the taskbar - control selection via Wheel, select app to execute by releasing the Next button


### Win tab
##### Thumb button
* \- Clicking it will open the Win-Tab menu, like its original behavior, only now you can control selection via wheel, select app by click Left/Right/Thumb buttons
* Wheel - Prev/Next tab (Chrome and many more apps)


### Zoom mode
##### Modifier - Middle button
* Wheel Up/Down = Zoom (Ctrl + '+' / '-')


### Specific Apps
##### Specific app - Chrome
* Right button - Close tab
* Left button - Undo close tab / recover last closed tab
* Middle button - Force refresh (Control + F5)

##### Specific app - Visual Studio
* Left button - Go to definition
* Middle button - Go to implementation
* Right button - Go to usages

##### Specific app - VSCode
* Left button - Go to definition
* Middle button - Go to implementation
* Right button - Go to usages

### Known issues
* Sometimes the mouse buttons will not respond as they should, especially after using the thumb button - click it again, it usually fixes the issue
* In Win tab usage (via the thumb button), need to exit the win tab view via the thumb button, otherwise left/right click act up. Can fix that by clicking the thumb button one more time
* Sometimes, switchinbg workspace (Right click + horizontal scroll) works only when the mouse pointer is on the taskbar
