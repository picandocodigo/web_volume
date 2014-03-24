# Web Volume "remote" control

This simple Sinatra app manages the volume on **GNU/Linux** systems with
[ALSA](http://www.alsa-project.org/main/index.php/Main_Page) (most
GNU/Linux distributions as far as I know) and **Mac OS X** (thanks to @dcadenas).

It's basically a web page where you can interact with your computer's
volume via a browser.

## How does it work?

Clone the code, `bundle install` and `rackup`. You should be able to
access the app on: [http://localhost:9292](http://localhost:9292)

You can manage the volume from a Browser or something else that can do a
GET request.

### Routes

 * `volup` - increases volume by 3%.
 * `voldown` - decreases volume by 3%.
 * `mute` - toggles mute/unmute.
 * `vol` - returns current volume and state.

All routes return a JSON with two keys: "number" and "state". The
"number" value is the current volume value and the "state" represents
if the system volume is muted or not.

Example:
```
$ curl localhost:9292/mute
{"number":"100","state":"off"}
```
