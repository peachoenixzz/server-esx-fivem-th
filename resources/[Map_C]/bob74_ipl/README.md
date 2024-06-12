# Fix holes and customize the map (Updated to The Chop Shop DLC)

The purpose of this script is to fix the holes in the map by loading zones that aren’t loaded by default.

This fork by TayMcKenzieNZ is to work alongside my fork of [online-interiors](https://github.com/TayMcKenzieNZ/online-interiors) which adds teleporters to and from the locations for on foot and vehicles.

-------------------

## [Wiki](https://github.com/Bob74/bob74_ipl/wiki)
- The Wiki has been created to help you customize your interiors as you wish. I have gone ahead and customised them for you however if you do not like how it is done, you can set it up the way you like using bob's wiki. It contains every function you can use for each interior.

- Each Wiki page has an example at the bottom of the page to show how you can use it in your own resource.

- Also at the bottom of the Wiki will show you the default values set by `IPL_NAME.LoadDefault()`.

------------------

# Heist Carrier 🛥️

Heist carrier has been disabled as it isn't exactly necessary with Cayo Perico. To reenable it, open `client.lua` and set `HeistCarrier.Enable(false)` to HeistCarrier.Enable(true)`.

------------------

# Pillbox Hospitial 🏥

`PillboxHospital.Enable(false)` due to this location being a popular spot for custom MLO hospitals. Setting it to true makes it so doors appear in front of your custom hospital MLO, therefore you can't access it. If you do not have any custom hospital MLOs in this location and instead have a gaping hole, set this to `PillboxHospital.Enable(true)`

------------------

# Arena Wars Arena 🏟️

Nor Bob or myself have included these IPLs. You can find and configure them [here](https://github.com/Starystars67/Titch2000_Arena) however I can not guarantee compatibility with my forks of either bob74_ipl, or online interiors.



------------------

# Install 💾

1. Download my fork of bob74_ipl
2. Extract `bob74_ipl.zip` and copy the `bob74_ipl` into your `resources` folder.
3. add `start bob74_ipl` and `start online-interiors` to your `server.cfg`

------------------

# Screenshots
- [After Hours Album](https://imgur.com/a/Qg96l0D)
- [Misc. Album](https://imgur.com/a/cs9Ip4d)
- [IPL Fix Album](https://imgur.com/a/1Sfl4)
