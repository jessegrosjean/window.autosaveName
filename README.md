# How best to position NSDocument windows like Safari?

When a new window is created it should:

1. Be positioned and sized based on the position of the last active window.
2. If the last active window is still visible then the new window should be cascaded so it doesn't directly overlap.

I would expect that if I set `window.autosaveName` or `windowController.windowAutosaveName` to the same name for each document window I would get the desired behavior. But that doesn't seem to be the case. From what I can tell it seems that `window.autosaveName` is only designed to work for a single window. As soon as I start assigning the same autosaveName to multiple window instances things stop working.

My question is what's the right way to get this working? I have a hacked solution working in this project's `WindowController` class where I manually save and load window frames. Enalbe my hack by flipping the `useMyHack` BOOL at the top of the file. But this feels messy. I'm sure there are cases that I'm missing and my cascading doesn't work quite in the native way either.

What's the proper way to do this?