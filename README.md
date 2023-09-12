**AS MOT**

# THIS IS A WORK IN PROGRESS!

# Features

* **Input Unique MOT Number** - This allows your mechanics to put a number on the MOT certificate.
* **Pass/Fail Options** - The mechanic can Pass or Fail the vehicle using a simple qb-menu interaction.
* **Simple Chat Command** - You can customise the MOT menu command in the config.lua file!
* **Job-Locked Command** - Select the job to lock it to. Multiple job support coming soon!

# Installation

* Drag and Drop `as-mot` into your resources directory
* Add the following to your qb-core>server>items.lua:
```lua
	-- as-mot
	["motpass"]                   	= {["name"] = "motpass",                  	["label"] = "MOT Pass Certificate",     ["weight"] = 10,       ["type"] = "item",      ["image"] = "insurance.png",    ["unique"] = true,      ["useable"] = false,     ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
	["motfail"]                   	= {["name"] = "motfail",                  	["label"] = "MOT Fail Certificate",     ["weight"] = 10,       ["type"] = "item",      ["image"] = "insurance.png",    ["unique"] = true,      ["useable"] = false,     ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = ""},
```
* Add the following into your qb-inventory>html>js>app.js, under `itemData.name == "weaponlicense"`:
```js
        } else if (itemData.name == "motpass") {
            $(".item-info-title").html("<p>" + itemData.label + "</p>");
            $(".item-info-description").html(
                "<p><strong>MOT ID: </strong><span>" +
                itemData.info.motid +
                "<p><strong>Authorising Mechanic First Name: </strong><span>" +
                itemData.info.firstname +
                "</span></p><p><strong>Authorising Mechanic Last Name: </strong><span>" +
                itemData.info.lastname +
                "</span></p><p><strong>Vehicle Plate: </strong><span>" +
                itemData.info.vehicleplate +
                "</span></p>"
            );
        } else if (itemData.name == "motfail") {
            $(".item-info-title").html("<p>" + itemData.label + "</p>");
            $(".item-info-description").html(
                "<p><strong>MOT ID: </strong><span>" +
                itemData.info.motid +
                "<p><strong>Authorising Mechanic First Name: </strong><span>" +
                itemData.info.firstname +
                "</span></p><p><strong>Authorising Mechanic Last Name: </strong><span>" +
                itemData.info.lastname +
                "</span></p><p><strong>Vehicle Plate: </strong><span>" +
                itemData.info.vehicleplate +
                "</span></p>"
            );
```

# Dependencies

* qb-core
* qb-menu

* qb-input or ox_lib

# Notes

* No images yet! Working on it!

# Credits

* Jaysee (Discord) - MASSIVE help, thank you!
* Alex (Me)
